(defpackage :destroy
  (:use :common-lisp)
  (:import-from :file :get-streak-file)
  (:import-from :help :print-usage-if-true
                      :print-if-true)
  (:export #:destroy))

(in-package :destroy)

(defun destroy (args)
  (print-usage-if-true (not (eql (length args) 1))
    (let ((streak (first args)))
      (let ((streak-namestring (get-streak-file streak)))
        (let ((streak-path (probe-file streak-namestring)))
          (print-if-true (not streak-path)
                         ("Streak \"~A\" does not exist.~%" streak)
            (delete-file streak-path)
            (format t "Destroyed streak \"~A\".~%" streak)))))))
