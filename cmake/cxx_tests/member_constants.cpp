// DESCRIPTION
//
//   Test to check whether the C++ compiler supports member constants, define HAVE_MEMBER_CONSTANTS.
//   In sync with AC_CXX_MEMBER_CONSTANTS (2008-04-12)
//
// COPYLEFT
//
//   Copyright (c) 2009 Theo Papadopoulo <Theodore.Papadopoulo@inria.fr>
//   Copyright (c) 2008 Todd Veldhuizen
//   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
//
//   Copying and distribution of this file, with or without modification, are
//   permitted in any medium without royalty provided the copyright notice
//   and this notice are preserved.

class C {public: static const int i = 0;};
const int C::i;

int main() {
    return C::i;
}
