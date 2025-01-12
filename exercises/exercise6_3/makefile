LOWEROBJS = main.o tolower.o
BUILD_DIR := build

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif

LSTFLGS =

all: lower

%.o: %.s
	as $(DEBUGFLGS) $(LSTFLGS) $< -o $(BUILD_DIR)/$@
	
lower: $(LOWEROBJS) $(BUILD_DIR)
	ld -o $(BUILD_DIR)/lower $(BUILD_DIR)/$(LOWEROBJS)

$(BUILD_DIR):
	mkdir -p $@