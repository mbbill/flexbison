Chapter1

lex 程序包含：

1. 声明部分
2. 规则部分
3. C 代码部分

`fb1-1.l`  记录了 `words` 和 `chars`, 在 

```lex
%{

%}
```

在上面定义了 vars，然后在下面定义了规则

```
%%
%%
```

`fb1-2.l` 就更简单了，直接 `printf`, 这两个都是只有 flex 的程序。生成词法分析器就可以了。

`fb1-3.l` 定义了计算器和打印。flex 里面，使用词法分析器来获得一个 token stream, 利用 `yylex` 读取一小部分输入，然后吐出 token.

“如果一个模式不能够产生 token，那么`yylex` 会继续，否则会等待下次调用”

比如  `fb1-3.l` 下面那个 `[ \t]` 就没返回：

```lex
[0-9]+	{ printf("NUMBER %s\n", yytext); }
\n      { printf("NEWLINE\n"); }
[ \t] { }
```

这里定义了一个简单的雏形，下面需要引入 bison 来处理

---

`fb1-5.l` 和 `fb1-5.y` 引入了 bison 来处理。`.y` 程序 `include` 

这个地方实现了一个完整的加法计算器，在 `Makefile.ch1` 里面有完整的逻辑。这个 1.5 涉及了：

* `flex` 定义了 `yylval` 保存值
* 大小括号
* `bison` 定义了 `factor` 和 `exp` 处理优先级
* 定义 `OP` `CP` 来处理

（其实我能很清楚说出为什么这个能计算加减乘除，但是说不清楚这个优先级是怎么定义的）

----

## Chapter 2

这一节介绍的是 `flex` 一些细很多的内容，其实不那么难理解：

### 二义性

有两条规则：

* flex 匹配的时候，匹配尽可能多的字符串（greedy）
* 两个模式都可以匹配的话，匹配更早出现的模式

```
"+" { return ADD;}
"=" { return ASSIGN; }
"+=" {return ASSIGNADD; }
"if" { return KEYWORDIF; }
"else" { return KEYWORDELSE; }
"[a-zA-Z]" { return IDENTIFIER; }
```

* 对于 `+=` 来说，因为第一个规则，匹配 `ASSIGNADD` 了。
* 假设 `+=` 是一个合法的变量名称符号（当然这里不是）

### I/O

```c
%option noyywrap
  
// ...
main(argc, argv)
int argc;
char **argv;
{
  // 这个地方的逻辑是: yyin 是定义的输入流
  // 这里定义了 yyin
  if(argc > 1) {
    if(!(yyin = fopen(argv[1], "r"))) {
      perror(argv[1]);
      return (1);
    }
  }

  yylex();
  printf("lines: %8d; words: %8d; chars: %8d\n", lines, words, chars);
}
```

`yywrap` 是默认的 io, `yyin` 结束的时候，他们会调用 `yywrap`. 后者会调整 `yyin`, 重新开始分析

这个 flex 禁了 `yywrap`, 然后 yyin 如果没赋值, `yylex` 会给它 `stdin` :

```c
main(int argc, char **argv)
{
  int i;

  if(argc < 2) { /* just read stdin */
    yylex();
    printf("%8d%8d%8d\n", lines, words, chars);
    return 0;
  }

  for(i = 1; i < argc; i++) {
    FILE *f = fopen(argv[i], "r");
  
    if(!f) {
      perror(argv[1]);
      return (1);
    }
    // 多个文件的时候，restart
    yyrestart(f);
    yylex();
    fclose(f);
    printf("%8d%8d%8d %s\n", lines, words, chars, argv[i]);
    totchars += chars; chars = 0;
    totwords += words; words = 0;
    totlines += lines; lines = 0;
  }
  if(argc > 1)
    printf("%8d%8d%8d total\n", totlines, totwords, totchars);
  return 0;
}
```

flex 有一个三层输入系统，让人自行选择输入结构：

* 利用 `yyin` 设置读取文件
* 利用 `YY_BUFFER_STATE` 读取，指向一个 `File*`
* 重新定义 YY_INPUT, 这个 flex 读取当前

对于输出，有一个：

```
. ECHO;
#define ECHO fwrite(yytext, yyleng, 1, yyout)
```

输入到 `yyout`

### 起始状态和 I/O

fb2-3 把上面的知识合并起来了，定义了一个比较复杂的程序：

1. flex 层定义了一个 `IFILE` 状态机，第一次读头文件的时候，调用 `newfile` 切换 IO，然后切状态机
2. 读完一个文件的时候，对于 `<<EOF>>`，尝试 popfile
3. 在读 `#include <{}>` 中间的内容的时候，丢给 `IFILE` 状态机，切换完后丢回来。

### 简单的符号表

2.4 实现了一个简单的符号表