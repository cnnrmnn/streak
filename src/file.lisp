(defpackage :file
  (:use :common-lisp)
  (:import-from :yason :with-output
                       :with-object
                       :encode-object-elements)
  (:export #:*program-dir*
           #:get-streak-file
           #:write-json-object-elements))

(in-package :file)

(defvar *program-dir* (uiop:native-namestring "~/.streak/"))

(defun get-streak-file (name)
  (format nil "~A~A.json" *program-dir* name))

(defmacro write-json-object-elements (file &rest elements)
  (let ((str (gensym)))
    `(with-open-file (,str ,file
                          :direction :output
                          :if-does-not-exist :create)
       (with-output (,str)
         (with-object ()
           (encode-object-elements ,@elements))))))
