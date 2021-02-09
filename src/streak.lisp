(defpackage :streak
  (:use :common-lisp :help)
  (:export #:main))

(in-package :streak)

(defun main ()
  (help:print-usage))
