(defpackage :extend
  (:use :common-lisp)
  (:import-from :file :get-streak-namestring
                      :parse-json-from-file
                      :encode-json-dom)
  (:import-from :help :print-if-true)
  (:export #:extend))

(in-package :extend)

(defun extend-streak (streak streak-ht)
  (let ((due (gethash "due" streak-ht))
        (interval (gethash "interval" streak-ht))
        (length (gethash "length" streak-ht)))
    (setf (gethash "due" streak-ht)
          (+ due interval))
    (setf (gethash "length" streak-ht)
          (incf length))
    (format t "Extended streak \"~A\" to length ~A.~%" streak length)))

(defun break-streak (streak streak-ht)
  (let ((length (gethash "length" streak-ht)))
    (setf (gethash "active" streak-ht) nil)
    (format t "Streak \"~A\" broke at length ~A.~%" streak length)))

(defun extend (streak)
  (let ((streak-namestring (get-streak-namestring streak)))
    (let ((streak-ht (parse-json-from-file streak-namestring)))
      (print-if-true (not streak-ht) ("Streak \"~A\" does not exist.~%" streak)
        (print-if-true (not (gethash "active" streak-ht))
                       ("Streak \"~A\" is broken.~%" streak)
          (let ((due (gethash "due" streak-ht))
                (interval (gethash "interval" streak-ht))
                (length (gethash "length" streak-ht))
                (time (get-universal-time)))
            (print-if-true (> due time)
                           ("Streak \"~A\" was already extended.~%" streak)
              (if (< (- (get-universal-time) due)
                     interval)
                (extend-streak streak streak-ht)
                (break-streak streak streak-ht))
              (encode-json-dom streak-ht streak-namestring))))))))
