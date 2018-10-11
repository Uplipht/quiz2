CC=g++
CFLAGS=-g -Wall
#Enable all warnings
DOXCONFIG=Doxyfile

#Build game, archive it, and document it
all: build doczip

build: myexe

myexe: college.o collegemain.o course.o
	$(CC) $(CFLAGS) -o myexe college.o collegemain.o course.o

college.o: college.cc college.h node.h course.h
	$(CC) $(CFLAGS) -c college.cc

collegemain.o: collegemain.cc course.h college.h
	$(CC) $(CFLAGS) -c collegemain.cc

course.o: course.cc course.h
	$(CC) $(CFLAGS) -c course.cc

doczip: html
	zip mydocs.zip html/*

doc: html

html: $(DOXCONFIG) *.cc *.h
	doxygen $(DOXCONFIG)

clean:
	-rm -f *.o myexe mydocs.zip
	-rm -rf html
