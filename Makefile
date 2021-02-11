quicklisp_path = ~/.quicklisp/dists/quicklisp/software

build:
	buildapp --output streak --entry streak:main --load-system streak \
		--asdf-path . --asdf-tree ${quicklisp_path} --compress-core
