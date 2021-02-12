(defpackage :create
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :file :*program-dir*
                      :get-streak-file
                      :write-json-object-elements)
  (:import-from :help :print-if-true
                      :print-usage-if-true)
  (:export #:create))

(in-package :create)

(defun to-hours (interval unit)
  (switch (unit :test #'(lambda (x y)
                          (member x y :test #'string=)))
    ('("hour" "hours") (* interval 3600))
    ('("day" "days") (* interval 86400))
    ('("week" "weeks") (* interval 604800))
    (otherwise nil)))

(defun create (args)
  (print-usage-if-true (not (= (length args) 3))
    (let ((name (first args))
          (interval (ignore-errors (parse-integer (second args))))
          (unit (third args)))
      (print-if-true (not interval)
                     ("Interval \"~A\" is invalid (must be an integer).~%"
                      (second args))
        (let ((hour-interval (to-hours interval unit))
              (streak-file (get-streak-file name)))
          (print-if-true (not hour-interval) ("Unit \"~A\" is invalid.~%" unit)
            (print-if-true (probe-file streak-file)
                           ("Streak \"~A\" already exists.~%" name)
              (ensure-directories-exist *program-dir*)
              (write-json-object-elements streak-file
                "active" t
                "interval" hour-interval
                "created" (get-universal-time)
                "extended" (get-universal-time)
                "length" 0))))))))
