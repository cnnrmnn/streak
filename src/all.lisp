(defpackage :all
  (:use :common-lisp)
  (:import-from :file :get-streak-namestrings)
  (:import-from :help :print-usage-if-true
                      :print-if-true
                      :print-streak-heading
                      :print-streak)
  (:export #:all))

(in-package :all)

(defun all (args)
  (print-usage-if-true args
    (let ((streaks (get-streak-namestrings)))
      (print-if-true (not streaks) ("No streaks found.~%")
        (print-streak-heading)
        (dolist (streak streaks)
          (print-streak streak))))))
