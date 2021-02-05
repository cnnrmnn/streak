lisp = sbcl

build:
	$(lisp)	--eval '(ql:quickload :streak)' \
		--eval '(asdf:make :streak)' \
		--eval '(quit)'
