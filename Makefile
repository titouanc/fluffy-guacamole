DATASET := $(wildcard *.dat)
SOLUTIONS = $(subst .dat,.sol,${DATASET})

all: ${SOLUTIONS}
	cat $^

%.sol: %.dat metro metro.py metro-script
	./metro-script $< > $@

metro: metro.hs
	ghc $<

clean:
	rm -f *.hi *.pyc *.o

mrproper: clean
	rm -f *.sol metro
