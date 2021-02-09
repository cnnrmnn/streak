(defpackage :help
  (:use :common-lisp)
  (:export #:print-usage))

(in-package :help)

(defun print-usage ()
  (format t "streak usage:~%")
  (format t "   streak <command>~%")
  (format t "commands:~%")
  (format t "   <name>~%")
  (format t "   undo <name>~%")
  (format t "   add <name> {day | week | month} [interval]~%")
  (format t "   destroy <name>~%"))
