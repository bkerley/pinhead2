CC = clang
CFLAGS = -Wall -g -arch x86_32

LD = clang
LDFLAGS = -Wall -arch x86_32

CT = clang
CTFLAGS = -S -arch x86_32

RM = rm

RUBY = ruby

OBJS = main.o check.o
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
