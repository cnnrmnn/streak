(defpackage :streak
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :help :print-usage-if-true)
  (:import-from :create :create)
  (:import-from :destroy :destroy)
  (:import-from :extend :extend)
  (:import-from :info :info)
  (:import-from :all :all)
  (:export #:main))

(in-package :streak)

(defun main (argv)
  (let ((command (nth 1 argv))
        (args (nthcdr 2 argv)))
    (switch (command :test #'string=)
      ("create" (create args))
      ("destroy" (destroy args))
      ("info" (info args))
      ("all" (all args))
      (otherwise
        (print-usage-if-true (or args (not command))
          (extend command))))))
