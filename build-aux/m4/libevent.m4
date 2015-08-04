#
# AC_CHECK_LIBEVENT
#

AC_DEFUN([AC_CHECK_LIBEVENT], [
  # First, try with pkg-config
  PKG_CHECK_MODULES([LIBEVENT], [libevent >= 2.0.5], [
       # Check if we have a working libevent
       AC_MSG_CHECKING([if system libevent works as expected])
       _save_CFLAGS="$CFLAGS"
       _save_LIBS="$LIBS"
       CFLAGS="$CFLAGS $LIBEVENT_CFLAGS"
       LIBS="$LIBS $LIBEVENT_LIBS"
       CFLAGS="$_save_CFLAGS"
       LIBS="$_save_LIBS"
			 LIBEVENT_EMBEDDED=0
  ], [
    # No appropriate version, let's use the shipped copy
    AC_MSG_NOTICE([using shipped libevent])
    LIBEVENT_EMBEDDED=1
  ])

  if test x"$LIBEVENT_EMBEDDED" != x0; then
    unset LIBEVENT_LIBS
    LIBEVENT_CFLAGS="-I\$(top_srcdir)/libevent/include -I\$(top_builddir)/libevent/include"
    LIBEVENT_LDFLAGS="\$(top_builddir)/libevent/libevent.la"
  fi

  # Override configure arguments
  ac_configure_args="$ac_configure_args --disable-libevent-regress --disable-thread-support --disable-openssl"
  ac_configure_args="$ac_configure_args --disable-malloc-replacement --disable-debug-mode --enable-function-sections"
  ac_configure_args="$ac_configure_args --disable-shared --enable-static"
  AC_CONFIG_SUBDIRS([libevent])
  AC_SUBST([LIBEVENT_LIBS])
  AC_SUBST([LIBEVENT_CFLAGS])
  AC_SUBST([LIBEVENT_LDFLAGS])
])
