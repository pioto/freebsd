#$FreeBSD$

LIB=	heimbase
LDFLAGS=	-Wl,--no-undefined
LDADD=	-lpthread
VERSION_MAP= ${KRB5DIR}/base/version-script.map

INCS=	heimbase.h

SRCS= \
	array.c \
	baselocl.h \
	bool.c \
	dict.c \
	heimbase.c \
	heimbasepriv.h \
	heimqueue.h \
	null.c \
	number.c \
	string.c

CFLAGS+=	-I${KRB5DIR}/include

.include <bsd.lib.mk>

.PATH: ${KRB5DIR}/base
