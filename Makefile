ROM_NAME = pong
SRCDIR = src
INCDIR = include
BUILDDIR = build

RGBASM = rgbasm
RGBLINK = rgblink
RGBFIX = rgbfix

ASM_FLAGS = -i $(INCDIR)/
FIX_FLAGS = -v -p 0xFF

SOURCES  := $(wildcard $(SRCDIR)/*.asm)
OBJECTS  := $(patsubst $(SRCDIR)/%.asm, $(BUILDDIR)/%.o, $(SOURCES))

all: $(BUILDDIR)/$(ROM_NAME).gb

$(BUILDDIR)/$(ROM_NAME).gb: $(OBJECTS)
	$(RGBLINK) -o $@ $^
	$(RGBFIX) $(FIX_FLAGS) $@
	@echo "Success!"

$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	@mkdir -p $(BUILDDIR)
	$(RGBASM) $(ASM_FLAGS) -o $@ $<

clean:
	rm -rf $(BUILDDIR)

.PHONY: all clean