#$FreeBSD$

LIB=	heimipcs
INTERNALLIB=
LDADD=	-lheimbase -lroken
LDFLAGS=	-pthread
DPADD=	${LIBHEIMBASE} ${LIBROKEN}

SRCS=	hi_locl.h \
	heim_ipc_types.h \
	server.c \
	common.c

CFLAGS+=	-DPIC ${PICFLAG}
CFLAGS+=	-I${KRB5DIR}/lib/roken \
		-I${KRB5DIR}/base \
		-I${KRB5DIR}/lib/ipc -I.

.include <bsd.lib.mk>

.PATH: ${KRB5DIR}/lib/ipc
