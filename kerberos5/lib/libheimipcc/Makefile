#$FreeBSD$

LIB=	heimipcc
INTERNALLIB=
LDADD=	-lheimbase -lroken -lpthread
DPADD=	${LIBHEIMBASE} ${LIBROKEN} ${LIBPTHREAD}

SRCS=	hi_locl.h \
	heim_ipc_types.h \
	client.c \
	common.c

CFLAGS+=	-DPIC ${PICFLAG}
CFLAGS+=	-I${KRB5DIR}/lib/roken \
		-I${KRB5DIR}/base \
		-I${KRB5DIR}/lib/ipc

.include <bsd.lib.mk>

.PATH: ${KRB5DIR}/lib/ipc
