PROGNAME := tcpserv
INCDIR := include
SRCDIR := src
LIBDIR := lib
OUTDIR := build
TARGET := $(OUTDIR)/$(PROGNAME)
SRCS := $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/$(LIBDIR)/*.c)
OBJS := $(addprefix $(OUTDIR)/,$(patsubst %.c,%.o,$(SRCS)))
#$(warning $(OBJS))

CC = gcc
CFLAGS = -Wall -O2 -I $(INCDIR)

.PHONY: all clean
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(OUTDIR)/%.o:%.c
	@if [ ! -e `dirname $@` ]; then mkdir -p `dirname $@`; fi
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	rm -rf $(OUTDIR)
