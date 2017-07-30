(in-package skitter.glfw.mouse-buttons)

(defun mouse.button-id (name/event)
  (etypecase name/event
    (keyword
     (or (position name/event skitter.glfw::*mouse-button-names*)
         (error "mouse.button-id: invalid name ~s" name/event)))

    (t (error "mouse.button-id: Must be given a keyword name or an instance of the button event.~%Recieved ~s"
              name/event))))

(defconstant mouse.left 0)
(defconstant mouse.middle 1)
(defconstant mouse.right 2)
(defconstant mouse.other0 3)
(defconstant mouse.other1 4)
(defconstant mouse.other2 5)
(defconstant mouse.other3 6)
(defconstant mouse.other4 7)
