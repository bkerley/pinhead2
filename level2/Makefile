CC = gcc
CFLAGS = -Wall -g -m32 -static

LD = gcc
LDFLAGS = -Wall -m32 -static

CT = gcc
CTFLAGS = -S -m32

RM = rm

RUBY = ruby

OBJS = check.o main.o
PROG = level2

all: $(PROG)

ctest: clean test

clean:
	$(RM) -f $(PROG) $(OBJS) init.c

test: all
	cat test.in | ./$(PROG) 2> /dev/null | diff test.out -

$(PROG): $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $(PROG)

%.o: %.c
	$(CC) $(CFLAGS) -c $<

%.s: %.c
	$(CT) $(CTFLAGS) -c $<

check.c: gen
check.h: gen

gen: gen.rb
	$(RUBY) $<
