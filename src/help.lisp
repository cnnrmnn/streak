(defpackage :help
  (:use :common-lisp)
  (:import-from :alexandria :switch)
  (:import-from :file :parse-json-from-file)
  (:export #:print-if-true
           #:print-usage-if-true
           #:print-streak-heading
           #:print-streak))

(in-package :help)

(defmacro print-if-true (test text &rest body)
  `(if ,test
     (format t ,@text)
     (progn ,@body)))

(defmacro print-usage-if-true (test &rest body)
  `(if ,test
     (progn
       (format t "streak usage:~%")
       (format t "   streak <command>~%")
       (format t "commands:~%")
       (format t "   <name>~%")
       (format t "   create <name> <interval> {hour(s) | day(s) | week(s)}~%")
       (format t "   destroy <name>~%")
       (format t "   info <name>~%")
       (format t "   all~%"))
     (progn ,@body)))

(defun print-streak-heading ()
  (format t "~15A ~6A ~6A ~8A ~6A ~16A ~16A~%"
            "name"
            "active"
            "length"
            "interval"
            "unit"
            "created"
            "due"))

(defun format-universal-time (universal-time)
  (let ((decoded-time (multiple-value-list
                        (decode-universal-time universal-time))))
    (format nil "~A/~A/~A ~A:~A"
                (nth 4 decoded-time)
                (nth 3 decoded-time)
                (nth 5 decoded-time)
                (nth 2 decoded-time)
                (nth 1 decoded-time))))

(defun format-boolean (bool)
  (case bool
    ('nil "false")
    (t "true")))

(defun to-unit (interval unit)
  (switch (unit :test #'(lambda (x y)
                          (member x y :test #'string=)))
    ('("hour" "hours") (/ interval 3600))
    ('("day" "days") (/ interval 86400))
    ('("week" "weeks") (/ interval 604800))
    (otherwise nil)))

(defun print-streak (streak-namestring)
  (let ((streak-ht (parse-json-from-file streak-namestring)))
    (let ((name (gethash "name" streak-ht))
          (active (gethash "active" streak-ht))
          (length (gethash "length" streak-ht))
          (interval (gethash "interval" streak-ht))
          (unit (gethash "unit" streak-ht))
          (created (gethash "created" streak-ht))
          (due (gethash "due" streak-ht)))
      (format t "~15A ~6A ~6A ~8A ~6A ~16A ~16A~%"
                 name
                 (format-boolean active)
                 length
                 (to-unit interval unit)
                 unit
                 (format-universal-time created)
                 (format-universal-time due)))))
