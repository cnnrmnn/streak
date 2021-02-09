(defpackage :streak
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :help :print-usage)
  (:export #:main))

(in-package :streak)

(defun main ()
  (let* ((argv sb-ext:*posix-argv*)
         (command (nth 1 argv))
         (args (nthcdr 2 argv)))
    (switch (command :test #'string=)
      ("undo" t)
      ("create" t)
      ("destroy" t)
      (otherwise
        (if (or args (not command))
          (print-usage)
          t)))))
