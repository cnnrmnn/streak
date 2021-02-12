(defpackage :help
  (:use :common-lisp)
  (:export #:print-if-true
           #:print-usage-if-true))

(in-package :help)

(defmacro print-if-true (test text &rest body)
  `(if ,test
     (format t ,@text)
     (progn ,@body)))

(defmacro print-usage-if-true (test &rest body)
  `(if ,test
     (progn
       (format t "streak usage:~%")
       (format t "   streak <command>~%")
       (format t "commands:~%")
       (format t "   <name>~%")
       (format t "   create <name> <interval> {hour(s) | day(s) | week(s)}~%")
       (format t "   destroy <name>~%"))
     (progn ,@body)))
