quicklisp_path = ~/.quicklisp/dists/quicklisp/software

build: bin
	buildapp --output bin/streak --entry streak:main --load-system streak \
		--asdf-path . --asdf-tree ${quicklisp_path} --compress-core

bin:
	mkdir bin
