(asdf:defsystem #:skitter.glfw
    :description "An event system for games - backed by glfw"
    :author "Daniel Parnell <me@danielparnell.com>"
    :license "BSD 2 Clause"
    :serial t
    :depends-on (:skitter #:cl-glfw3)
    :components ((:file "glfw/package")
                 (:file "glfw/glfw")
                 (:file "glfw/keys")
                 (:file "glfw/mouse-buttons")))
