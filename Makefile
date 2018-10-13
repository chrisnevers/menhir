default: main

main: main.native

%.native:
	corebuild -use-menhir -use-ocamlfind $@
	mv $@ $*
