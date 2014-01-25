tests: Main.hs Foo.hs foo.cpp.o
	ghc --make Main foo.cpp.o -o tests

foo.cpp.o: foo.cpp foo.h
	gcc -c foo.cpp -o foo.cpp.o

Foo.hs: Foo.hsc foo.h
	hsc2hs -I. Foo.hsc

clean:
	rm -rf *.hi *.o tests Foo.hs
