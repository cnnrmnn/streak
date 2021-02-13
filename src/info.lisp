(defpackage :info
  (:use :common-lisp)
  (:import-from :help :print-if-true
                      :print-usage-if-true
                      :print-streak-heading
                      :print-streak)
  (:import-from :file :get-streak-namestring
                      :parse-json-from-file))

(in-package :info)

(defun info (args)
  (print-usage-if-true (not (eql (length args) 1))
    (let* ((streak (first args))
           (streak-namestring (get-streak-namestring streak))
           (streak-ht (parse-json-from-file streak-namestring)))
      (print-if-true (not streak-ht) ("Streak \"~A\" does not exist~%" streak)
        (print-streak-heading)
        (print-streak streak-ht)))))
