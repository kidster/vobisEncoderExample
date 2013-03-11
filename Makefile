CXX=$(HOME)/source/clang_complete/bin/cc_args.py g++
#CXX=g++

PROG=a.out

CFLAGS= \
	-fpermissive \
	-g \
	`pkg-config vorbis --cflags` \

SOURCES= \
	encoder_example.c \

INCLUDES= \
	`pkg-config vorbis --cflags-only-I` \

LIBS= \
	-lvorbisenc \
	`pkg-config vorbis --libs` \

OBJECTS=$(SOURCES:%.c=%.o)

$(PROG): $(OBJECTS)
	$(CXX) $(CFLAGS) -o $(PROG) $^ $(LIBS)

%.o: %.c
	$(CXX) $(CFLAGS) $(INCLUDES) -c $< -o $@

make.depend: $(SOURCES)
	$(CXX) $(INCLUDES) -M $^ >$@

clean:
	rm $(PROG) $(OBJECTS) make.depend

include make.depend
