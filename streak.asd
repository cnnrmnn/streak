(defsystem :streak
  :author "Connor Mann"
  :license "MIT"
  :depends-on (:alexandria :yason)
  :components ((:module src
                  :components ((:file "file")
                               (:file "help")
                               (:file "create")
                               (:file "destroy")
                               (:file "extend")
                               (:file "info")
                               (:file "all")
                               (:file "streak"))))
  :build-operation "program-op"
  :build-pathname "streak"
  :entry-point "streak:main")
