(defpackage :streak
  (:use :common-lisp :help)
  (:export #:main))

(in-package :streak)

(defun main ()
  (let* ((argv sb-ext:*posix-argv*)
         (command (nth 1 argv))
         (args (nthcdr 2 argv)))
    (case command
      ("undo" t)
      ("create" t)
      ("destroy" t)
      (otherwise
        (if args
          (help:print-usage)
          t)))))
