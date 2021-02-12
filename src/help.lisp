(defpackage :help
  (:use :common-lisp)
  (:export #:print-usage
           #:print-if-false))

(in-package :help)

(defun print-usage ()
  (format t "streak usage:~%")
  (format t "   streak <command>~%")
  (format t "commands:~%")
  (format t "   <name>~%")
  (format t "   create <name> <interval> ~
                  {hour(s) | day(s) | week(s)}~%")
  (format t "   destroy <name>~%"))

(defmacro print-if-false (test text &rest body)
  `(if ,test
     (progn ,@body)
     (format t ,@text)))
