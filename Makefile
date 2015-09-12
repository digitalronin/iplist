iplist:
	mix escript.build

install: iplist
	cp iplist ~/bin/

test:
	mix test

watch:
	while sleep 2; do find . -name '*.ex*' | entr -r -d make test; done

.PHONY: test watch
