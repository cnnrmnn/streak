(defpackage :create
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :file :*program-dir*
                      :get-streak-file
                      :write-json-object-elements)
  (:import-from :help :print-usage)
  (:export #:create))

(in-package :create)

(defun to-hours (interval unit)
  (switch (unit :test #'(lambda (x y)
                          (member x y :test #'string=)))
    ('("hour" "hours") interval)
    ('("day" "days") (* interval 24))
    ('("week" "weeks") (* interval 168))
    (otherwise nil)))

(defun create (args)
  (if (= (length args) 3)
    (let ((name (first args))
          (interval (ignore-errors (parse-integer (second args))))
          (unit (third args)))
      (if interval
        (let ((hour-interval (to-hours interval unit))
              (streak-file (get-streak-file name)))
          (if hour-interval
            (if (probe-file streak-file)
              (format t "Streak \"~A\" already exists.~%" name)
              (progn
                (ensure-directories-exist *program-dir*)
                (write-json-object-elements streak-file
                  "active" t
                  "interval" hour-interval
                  "created" (get-universal-time)
                  "extended" (get-universal-time)
                  "length" 0)))
            (format t "Unit \"~A\" is invalid.~%" unit)))
        (format t "Interval \"~A\" is invalid (must be an integer).~%"
                (second args))))
      (print-usage)))
