iplist: lib/iplist/*.ex config/*.exs deps
	mix escript.build

install: iplist
	cp iplist ~/bin/

test:
	mix test

deps: mix.exs
	mix deps.get

docs: doc/index.html

doc/index.html: iplist
	mix docs

watch:
	while sleep 2; do find . -name '*.ex*' | entr -r -d make test; done

.PHONY: test watch
