# Notes:
# * Some files take a long time (30min+) and lots of RAM (8GB+).
#   Don't be surprised.

OPENSCAD_FLAGS=-q --render -m make -d $@.deps

SCAD_FILES=$(wildcard *.scad)
STL_FILES=$(SCAD_FILES:.scad=.stl)
PNG_FILES=$(SCAD_FILES:.scad=.png)

default : all

all : stl png

stl : $(STL_FILES)

png : $(PNG_FILES)

clean :
	rm $(wildcard *.stl *.png *.deps)

%.stl: %.scad
	openscad $(OPENSCAD_FLAGS) -o $@ $<
	sed -i "s,$(shell pwd)/,,g" $@.deps

%.png: %.scad
	openscad $(OPENSCAD_FLAGS) -o $@ $<
	sed -i "s,$(shell pwd)/,,g" $@.deps

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

.PHONY: default all stl png clean
