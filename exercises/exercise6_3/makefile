LOWEROBJS = main.o tolower.o

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LSTFLGS =

all: lower

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o build/$@
	
lower: $(LOWEROBJS)
	ld -o build/lower build/$(LOWEROBJS) 