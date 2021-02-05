(defsystem :streak
  :author "Connor Mann"
  :license "MIT"
  :components ((:module src
                 :components ((:file "streak"))))
  :build-operation "program-op"
  :build-pathname "streak"
  :entry-point "streak:main")
