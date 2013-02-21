
HEADERS		= $(wildcard *\#.scm)
SOURCES		= $(filter-out $(HEADERS),$(wildcard *.scm))

.PHONY: test
test: tester
	./tester

tester: $(SOURCES)
	gsc -exe -postlude '(run-expectations)' -o tester $(SOURCES)

