(defsystem :streak
  :author "Connor Mann"
  :license "MIT"
  :depends-on (:alexandria :yason)
  :components ((:module src
                  :components ((:file "help")
                               (:file "file")
                               (:file "create")
                               (:file "streak"))))
  :build-operation "program-op"
  :build-pathname "streak"
  :entry-point "streak:main")
