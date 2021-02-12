(defpackage :streak
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :help :print-usage)
  (:import-from :create :create)
  (:export #:main))

(in-package :streak)

(defun main (argv)
  (let ((command (nth 1 argv))
        (args (nthcdr 2 argv)))
    (switch (command :test #'string=)
      ("create" (create args))
      ("destroy" t)
      (otherwise
        (if (or args (not command))
          (print-usage)
          t)))))
