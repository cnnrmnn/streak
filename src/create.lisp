(defpackage :create
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :file :*program-dir*
                      :get-streak-namestring
                      :encode-json-object-elements)
  (:import-from :help :print-if-true
                      :print-usage-if-true)
  (:export #:create))

(in-package :create)

(defun to-seconds (interval unit)
  (switch (unit :test #'(lambda (x y)
                          (member x y :test #'string=)))
    ('("hour" "hours") (* interval 3600))
    ('("day" "days") (* interval 86400))
    ('("week" "weeks") (* interval 604800))
    (otherwise nil)))

(defun fix-unit (unit interval)
  (let ((plural (eql (uiop:last-char unit) #\s))
        (>1 (> interval 1)))
    (cond
      ((and plural (not >1)) (subseq unit 0 (1- (length unit))))
      ((and >1 (not plural)) (concatenate 'string unit "s"))
      (t unit))))

(defun parse-args (args)
  (if (string= (first args) "-m")
    (values (rest args) t)
    (values args nil)))

(defun midnight-of-today ()
  (multiple-value-bind
           (second minute hour day month year)
           (get-decoded-time)
    (encode-universal-time 0 0 0 day month year)))

(defun create (args)
  (multiple-value-bind (rest-args flag) (parse-args args)
    (print-usage-if-true (not (or (>= (length rest-args) 3)))
        (let ((name (first rest-args))
              (interval (ignore-errors (parse-integer (second rest-args))))
              (unit (third rest-args)))
          (print-if-true (not interval)
                         ("Interval \"~A\" is invalid (must be an integer).~%"
                          (second rest-args))
            (let ((seconds-interval (to-seconds interval unit))
                  (streak-namestring (get-streak-namestring name)))
              (print-if-true (not seconds-interval)
                             ("Unit \"~A\" is invalid.~%" unit)
                (print-if-true (probe-file streak-namestring)
                               ("Streak \"~A\" already exists.~%" name)
                  (ensure-directories-exist *program-dir*)
                  (encode-json-object-elements streak-namestring
                    "name" name
                    "active" t
                    "interval" seconds-interval
                    "unit" (fix-unit unit interval)
                    "created" (get-universal-time)
                    "due" (if flag
                            (midnight-of-today)
                            (get-universal-time))
                    "length" 0)))))))))
