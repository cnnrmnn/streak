(defpackage :file
  (:use :common-lisp)
  (:import-from :yason :encode
                       :encode-object-elements
                       :parse
                       :with-output
                       :with-object)
  (:export #:*program-dir*
           #:get-streak-file
           #:parse-json-from-file
           #:encode-json-dom
           #:write-json-object-elements))

(in-package :file)

(defvar *program-dir* (uiop:native-namestring "~/.streak/"))

(defun get-streak-file (name)
  (format nil "~A~A.json" *program-dir* name))

(defun parse-json-from-file (namestring)
  (with-open-file (str namestring
                       :direction :input
                       :if-does-not-exist nil)
    (and str
         (parse str))))

(defun encode-json-dom (json-dom namestring)
  (with-open-file (str namestring
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (encode json-dom str)))

(defmacro write-json-object-elements (file &rest elements)
  (let ((str (gensym)))
    `(with-open-file (,str ,file
                          :direction :output
                          :if-does-not-exist :create)
       (with-output (,str)
         (with-object ()
           (encode-object-elements ,@elements))))))
