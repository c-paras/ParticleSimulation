all:
	cd src && ghc -O -o ../particles Main.hs -hidir ../build -odir ../build

test:
	cd src && runhaskell MainTest.hs

clean:
	cd build && rm -f *.o *.hi

vclean:
	rm -f particles
	cd build && rm -f *.o *.hi
