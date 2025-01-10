LOWEROBJS = main.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LSTFLGS =

all: lower

main.o: main.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o build/$@
	
lower: $(LOWEROBJS)
	ld -o build/lower build/$(LOWEROBJS) 