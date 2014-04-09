/*
 * trivial context for cppcalc
 * $Header: /home/johnl/flnb/code/RCS/cppcalc-ctx.hh,v 2.1 2009/11/08 02:53:18 johnl Exp $
 * Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 */

#include <cassert>

class cppcalc_ctx {
public:
  cppcalc_ctx(int r) { assert(r > 0 && r < 10); radix = r; }

  inline int getradix(void) { return radix; } // should be no more than 10

private:
  int radix;

};
