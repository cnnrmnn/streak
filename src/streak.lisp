(defpackage :streak
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :help :print-usage-if-true)
  (:import-from :create :create)
  (:import-from :extend :extend)
  (:export #:main))

(in-package :streak)

(defun main (argv)
  (let ((command (nth 1 argv))
        (args (nthcdr 2 argv)))
    (switch (command :test #'string=)
      ("create" (create args))
      ("destroy" t)
      (otherwise
        (print-usage-if-true (or args (not command))
          (extend command))))))
