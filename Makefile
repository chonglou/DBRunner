CXX	 = $(shell fltk-config --cxx)
CXXFLAGS= $(shell fltk-config --use-gl --use-images --cxxflags ) -I.
LDFLAGS	= $(shell fltk-config --use-gl --use-images --ldflags )
LDSTATIC= $(shell fltk-config --use-gl --use-images --ldstaticflags )

BIN	= bin
SRC	= src
TARGET	= $(BIN)/dbrunner
OBJS	= $(addprefix $(BIN)/, main.o logging.o sql.o)

.SUFFIXES: .o .cxx
$(BIN)/%.o: $(SRC)/%.cxx
	$(CXX) $(CXXFLAGS) -o $@ -c $<

all: release

debug: CXX += -DDEBUG -g
debug: $(TARGET)
	$(CXX) -o $(TARGET) $(OBJS) $(LDFLAGS)


release: $(TARGET)
	$(CXX) -s -o $(TARGET) $(OBJS) $(LDFLAGS)



$(TARGET): check $(OBJS)

$(BIN)/main.o: $(addprefix $(SRC)/, main.cxx common.h)
$(BIN)/logging.o: $(addprefix $(SRC)/, logging.h logging.cxx)
$(BIN)sql.o: $(addprefix $(SRC)/, sql.h sql.cxx)


clean: $(TARGET) $(OBJS)
	if [ -d $(BIN) ]; then rm -rv $(BIN); fi

check:
	if [ ! -d $(BIN) ]; then mkdir -pv $(BIN); fi


