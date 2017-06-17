(in-package :skitter)

;; - We only hold the latest state in a control
;; - if you need a signal that is a composition of events then use a combo
;; -

;;----------------------------------------------------------------------

(deftclass control
  (container-slot :unknown-slot :type symbol)
  (container-index -1 :type fixnum)
  (listeners (make-array 0 :element-type 'predicate-source :adjustable t
                         :fill-pointer 0)
             :type (array predicate-source (*))))

(defun set-control-slots (control listeners-array slot-name index)
  "Set all the slots of an event source"
  (setf (control-listeners control) listeners-array
        (control-container-slot control) slot-name
        (control-container-index control) index))

(defgeneric add (inst control))

;;----------------------------------------------------------------------

(defun control-hidden-constructor-name (control-type)
  (intern (format nil "%MAKE-~a" control-type) :skitter-hidden))

(defun control-constructor-name (control-type)
  (intern (format nil "MAKE-~a" control-type) (symbol-package control-type)))

(defun control-data-acc-name (control-type)
  (intern (format nil "~a-DATA" control-type) (symbol-package control-type)))

(defun control-apply-name (control-type)
  (intern (format nil "APPLY-~a" control-type) (symbol-package control-type)))

(defmacro define-control (name type init-val)
  (let* ((constructor (control-hidden-constructor-name name)))
    `(progn
       (deftclass (,name (:include control)
                         (:constructor ,constructor))
         (data ,init-val :type ,type))

       ;; This exists so people can't set values via the constructor
       (defun ,(control-constructor-name name) ()
         (,constructor))

       (defun ,(control-apply-name name) (control timestamp data
                                          &optional tpref)
         (setf (,(control-data-acc-name name) control) data)
         (propagate control timestamp tpref)))))

;;----------------------------------------------------------------------
