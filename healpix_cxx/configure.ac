AC_INIT([healpix_cxx], [3.31.0])
AM_INIT_AUTOMAKE([foreign subdir-objects -Wall -Werror])
AM_MAINTAINER_MODE([enable])

dnl
dnl Needed for linking on Windows.
dnl Protect with m4_ifdef because AM_PROG_AR is required in
dnl autoconf >= 1.12 when using -Wall, but the macro is
dnl absent in old versions of autoconf.
dnl
m4_ifdef([AM_PROG_AR], [AM_PROG_AR])

LT_INIT
AC_CONFIG_MACRO_DIR([m4])

dnl
dnl By default, install the headers into a subdirectory of
dnl ${prefix}/include to avoid possible header filename collisions.
dnl
includedir="${includedir}/${PACKAGE_NAME}"

dnl
dnl Enable silent build rules if this version of Automake supports them
dnl
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

AC_DEFUN([AX_CHECK_COMPILE_FLAG],
[AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]flags_$4_$1])dnl
AC_CACHE_CHECK([whether _AC_LANG compiler accepts $1], CACHEVAR, [
  ax_check_save_flags=$[]_AC_LANG_PREFIX[]FLAGS
  _AC_LANG_PREFIX[]FLAGS="$[]_AC_LANG_PREFIX[]FLAGS $4 $1"
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM()],
    [AS_VAR_SET(CACHEVAR,[yes])],
    [AS_VAR_SET(CACHEVAR,[no])])
  _AC_LANG_PREFIX[]FLAGS=$ax_check_save_flags])
AS_IF([test x"AS_VAR_GET(CACHEVAR)" = xyes],
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_COMPILE_FLAGS

dnl
dnl Introduce --enable-native-optimizations command line argument to turn on
dnl -march=native compiler flag, disabled by default.
dnl
AC_ARG_ENABLE(
    [native-optimizations],
    [AS_HELP_STRING([--enable-native-optimizations], [Enable non-portable optimizations for your own CPU by compiling with -march=native @<:@default=no@:>@])]
)

AC_PROG_CC_C99
AC_OPENMP
CPPFLAGS="$CPPFLAGS $OPENMP_CFLAGS"
CFLAGS="$CFLAGS $OPENMP_CFLAGS"
AS_IF(
    [test "x$enable_native_optimizations" = "xyes"],
    [AX_CHECK_COMPILE_FLAG([-march=native],[CC="$CC -march=native"])],
    dnl
    dnl FIXME: On GCC 4.4, we hit an internal compiler error unless either
    dnl -march=native or -fno-tree-fre is specified.
    dnl
    [
        AS_IF(
            [test "x$GCC" = "xyes" -a "x`$CC -dumpversion | cut -d. -f1,2`" = "x4.4"],
            [AX_CHECK_COMPILE_FLAG([-fno-tree-fre], [CFLAGS="$CFLAGS -fno-tree-fre"])]
        )
    ]
)
AX_CHECK_COMPILE_FLAG([-fno-tree-vectorize],[CFLAGS="$CFLAGS -fno-tree-vectorize"])
AX_CHECK_COMPILE_FLAG([-fno-math-errno],[CFLAGS="$CFLAGS -fno-math-errno"])
AX_CHECK_COMPILE_FLAG([-funsafe-math-optimizations],[CFLAGS="$CFLAGS -funsafe-math-optimizations"])
AX_CHECK_COMPILE_FLAG([-fno-trapping-math],[CFLAGS="$CFLAGS -fno-trapping-math"])
AX_CHECK_COMPILE_FLAG([-fno-rounding-math],[CFLAGS="$CFLAGS -fno-rounding-math"])
AX_CHECK_COMPILE_FLAG([-fno-signaling-nans],[CFLAGS="$CFLAGS -fno-signaling-nans"])
AX_CHECK_COMPILE_FLAG([-fcx-limited-range],[CFLAGS="$CFLAGS -fcx-limited-range"])

AC_PROG_CXX
AC_LANG_PUSH([C++])
AC_OPENMP
CXXFLAGS="$CXXFLAGS $OPENMP_CFLAGS"
AS_IF(
    [test "x$enable_native_optimizations" = "xyes"],
    [AX_CHECK_COMPILE_FLAG([-march=native],[CXX="$CXX -march=native"])],
    dnl
    dnl FIXME: On GCC 4.4, we hit an internal compiler error unless either
    dnl -march=native or -fno-tree-fre is specified.
    dnl
    [
        AS_IF(
            [test "x$GCC_CXX" = "xyes" -a "x`$CXX -dumpversion | cut -d. -f1,2`" = "x4.4"],
            [AX_CHECK_COMPILE_FLAG([-fno-tree-fre], [CXXFLAGS="$CXXFLAGS -fno-tree-fre"])]
        )
    ]
)
AX_CHECK_COMPILE_FLAG([-fno-tree-vectorize],[CXXFLAGS="$CXXFLAGS -fno-tree-vectorize"])
AX_CHECK_COMPILE_FLAG([-fno-math-errno],[CXXFLAGS="$CXXFLAGS -fno-math-errno"])
AX_CHECK_COMPILE_FLAG([-funsafe-math-optimizations],[CXXFLAGS="$CXXFLAGS -funsafe-math-optimizations"])
AX_CHECK_COMPILE_FLAG([-fno-trapping-math],[CXXFLAGS="$CXXFLAGS -fno-trapping-math"])
AX_CHECK_COMPILE_FLAG([-fno-rounding-math],[CXXFLAGS="$CXXFLAGS -fno-rounding-math"])
AX_CHECK_COMPILE_FLAG([-fno-signaling-nans],[CXXFLAGS="$CXXFLAGS -fno-signaling-nans"])
AX_CHECK_COMPILE_FLAG([-fcx-limited-range],[CXXFLAGS="$CXXFLAGS -fcx-limited-range"])
AC_LANG_POP([C++])

AC_ARG_WITH(libcfitsio,
  [  --with-libcfitsio=<path>         prefix to the cfitsio installation],
  [CFITSIO_LIBS="-L$withval/lib -lm -lcfitsio"
	 CPPFLAGS="-I$withval/include $CPPFLAGS"
   LDFLAGS="-L$withval/lib $LDFLAGS"])
AC_ARG_WITH(libcfitsio-include,
  [  --with-libcfitsio-include=<path> path containing the cfitsio headers],
  [CFITSIO_LIBS="-L$withval/lib -lm -lcfitsio"])
AC_ARG_WITH(libcfitsio-lib,
  [  --with-libcfitsio-lib=<path>     path containing the cfitsio library],
  [CFITSIO_CFLAGS="-L$withval/lib"
	 LDFLAGS="-L$withval $LDFLAGS"])

SILENT_RULE=".SILENT:"
AC_ARG_ENABLE(noisy-make,
  [  --enable-noisy-make     enable detailed make output],
  [if test "$enableval" = yes; then
     SILENT_RULE=""
   fi])

ENABLE_DEBUG=no
AC_ARG_ENABLE(debug,
  [  --enable-debug          enable generation of debugging symbols],
  [if test "$enableval" = yes; then
     ENABLE_DEBUG=yes
   fi])

ENABLE_NATIVE=no
AC_ARG_ENABLE(
    [native-optimizations],
    [AS_HELP_STRING([--enable-native-optimizations], [Enable non-portable optimizations for your own CPU by compiling with -march=native @<:@default=no@:>@])],
  [if test "$enableval" = yes; then
     ENABLE_NATIVE=yes
   fi])

case $CCTYPE in
  gcc)
    CCFLAGS="-O3 -ffast-math -fomit-frame-pointer -fno-tree-vectorize"
    GCCVERSION="`$CC -dumpversion 2>&1`"
    echo "Using gcc version $GCCVERSION"
    AC_SUBST(GCCVERSION)
    case $system in
      Darwin-*)
        ;;
      *)
        CCFLAGS="$CCFLAGS -ffunction-sections -fdata-sections"
        ;;
    esac
    changequote(,)
    gcc43=`echo $GCCVERSION | grep -c '4\.[3456789]'`
    changequote([,])
    if test $ENABLE_NATIVE = yes; then
      if test $gcc43 -gt 0; then
        CCFLAGS="$CCFLAGS -march=native"
      fi
    fi
    ;;
  icc)
    CCFLAGS="-O3 -Wbrief -Wall -openmp-report0 -wd383,981,1419,1572"
    if test $ENABLE_NATIVE = yes; then
      CCFLAGS="$CCFLAGS -xHOST"
    fi
    ;;
  *)
    CCFLAGS="-O2"
    # Don't do anything now
    ;;
esac

case $CXXTYPE in
  g++)
    CXXCFLAGS="-O2 -ffast-math -fomit-frame-pointer"
    GXXVERSION="`$CXX -dumpversion 2>&1`"
    echo "Using g++ version $GXXVERSION"
    AC_SUBST(GXXVERSION)
    case $system in
      Darwin-*)
        ;;
      *)
        CXXCFLAGS="$CXXCFLAGS -ffunction-sections -fdata-sections"
        LDFLAGS="$LDFLAGS -Wl,--gc-sections"
        ;;
    esac
    changequote(,)
    gxx43=`echo $GXXVERSION | grep -c '4\.[3456789]'`
    changequote([,])
    if test $ENABLE_NATIVE = yes; then
      if test $gxx43 -gt 0; then
        CXXCFLAGS="$CXXCFLAGS -march=native"
      fi
    fi
    ;;
  icpc)
    CXXCFLAGS="-O3 -Wbrief -Wall -openmp-report0 -wd383,444,981,1572"
    if test $ENABLE_NATIVE = yes; then
      CXXCFLAGS="$CXXCFLAGS -xHOST"
    fi
    ;;
  *)
    CXXCFLAGS="-O2"
    ;;
esac

case $system in
  Darwin-*)
    ARCREATE="libtool -static -o"
    ;;
  *)
    ARCREATE="ar cr"
    ;;
esac

CCFLAGS="$CCFLAGS $OPENMP_CFLAGS"
CXXCFLAGS="$CXXCFLAGS $OPENMP_CXXFLAGS"

if test $ENABLE_DEBUG = yes; then
  CCFLAGS="$CCFLAGS -g"
  CXXCFLAGS="$CXXCFLAGS -g"
fi

CCFLAGS_NO_C="$CCFLAGS $CPPFLAGS"
CXXCFLAGS_NO_C="$CXXCFLAGS $CPPFLAGS"

LDCCFLAGS="$LDFLAGS $CCFLAGS"
LDCXXFLAGS="$LDFLAGS $CXXCFLAGS"

AC_CHECK_LIB([cfitsio], [ffgnrwll], [:], AC_MSG_ERROR([could not find the cfitsio library]))
AC_CHECK_HEADERS([fitsio.h], [:], AC_MSG_ERROR([could not find the cfitsio header file]))

AC_SUBST(SILENT_RULE)
AC_SUBST(CC)
AC_SUBST(CCFLAGS_NO_C)
AC_SUBST(CFITSIO_LIBS)
AC_SUBST(CXX)
AC_SUBST(CXXCFLAGS_NO_C)
AC_SUBST(LDCCFLAGS)
AC_SUBST(LDCXXFLAGS)
AC_SUBST(LIBS)
AC_SUBST(ARCREATE)

dnl
dnl Create pkgconfig .pc file.
dnl
AX_CREATE_PKGCONFIG_INFO(,,,,[$OPENMP_CFLAGS $CFITSIO_CFLAGS])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
