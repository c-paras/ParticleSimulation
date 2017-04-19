all:
	cd src && ghc -O -o ../particles Main.hs -hidir ../build -odir ../build

clean:
	cd build && rm -f *.o *.hi
