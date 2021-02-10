(defpackage :help
  (:use :common-lisp)
  (:export #:print-usage))

(in-package :help)

(defun print-usage ()
  (format t "streak usage:~%")
  (format t "   streak <command>~%")
  (format t "commands:~%")
  (format t "   <name>~%")
  (format t "   create <name> <interval> ~
                  {hour(s) | day(s) | week(s) | month(s)}~%")
  (format t "   destroy <name>~%"))
