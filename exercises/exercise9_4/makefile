BUILD_DIR := build
LIBOBJS = tolower.o
VENV_DIR := venv

ifdef DEBUG
DEBUGFLGS = -g
else
DEBUGFLGS =
endif
LSTFLGS =

all: exercise9_4 exercise9_5 exercise9_6

exercise9_4: exercise9_4.c tolower.s $(BUILD_DIR)
	gcc -o $(BUILD_DIR)/exercise9_4 exercise9_4.c tolower.s

exercise9_5: tolower.s 
	as $(DEBUGFLGS) $(LSTFLGS) tolower.s -o $(BUILD_DIR)/$(LIBOBJS)
	ar -cvq $(BUILD_DIR)/tolower.a $(BUILD_DIR)/$(LIBOBJS)

	gcc -shared -Wl,-soname,liblow.so.1 -o $(BUILD_DIR)/liblow.so.1.0 $(BUILD_DIR)/$(LIBOBJS)
	sudo mv $(BUILD_DIR)/liblow.so.1.0 /usr/local/lib
	sudo ln -sf /usr/local/lib/liblow.so.1.0 /usr/local/lib/liblow.so.1
	sudo ln -sf /usr/local/lib/liblow.so.1.0 /usr/local/lib/liblow.so
	sudo ldconfig
	echo "Run make clean to clean up dynamic libraries"

exercise9_6: exercise9_6.c
	gcc -o $(BUILD_DIR)/exercise9_6 exercise9_6.c

clean:
	rm -rf $(VENV_DIR)
	rm -r $(BUILD_DIR)
	sudo rm /usr/local/lib/liblow.so.1.0 /usr/local/lib/liblow.so.1 /usr/local/lib/liblow.so
	sudo ldconfig

$(BUILD_DIR):
	mkdir -p $@