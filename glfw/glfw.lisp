(in-package :skitter.glfw)

;;--------------------------------------------
;; scancode lookup

(defvar *mouse-button-names*
  #(:0 :left :middle :right :other0 :other1 :other2 :other3 :other4))

(defvar *key-button-names*
  #(:unknown nil nil nil :a :b
    :c :d :e :f
    :g :h :i :j
    :k :l :m :n
    :o :p :q :r
    :s :t :u :v
    :w :x :y :z
    :1 :2 :3 :4
    :5 :6 :7 :8
    :9 :0 :return :escape
    :backspace :tab :space
    :minus :equals :leftbracket
    :rightbracket :backslash :nonushash
    :semicolon :apostrophe :grave
    :comma :period :slash
    :capslock :f1 :f2 :f3
    :f4 :f5 :f6 :f7
    :f8 :f9 :f10 :f11
    :f12 :printscreen :scrolllock
    :pause :insert :home
    :pageup :delete :end
    :pagedown :right :left
    :down :up :numlockclear
    :kp_divide :kp_multiply :kp_minus
    :kp_plus :kp_enter :kp_1
    :kp_2 :kp_3 :kp_4 :kp_5
    :kp_6 :kp_7 :kp_8 :kp_9
    :kp_0 :kp_period :nonusbackslash
    :application :power :kp_equals
    :f13 :f14 :f15 :f16
    :f17 :f18 :f19 :f20
    :f21 :f22 :f23 :f24
    :execute :help :menu
    :select :stop :again
    :undo :cut :copy :paste
    :find :mute :volumeup
    :volumedown :lockingcapslock
    :lockingnumlock :lockingscrolllock
    :kp_comma :kp_equalsas400
    :international1 :international2
    :international3 :international4
    :international5 :international6
    :international7 :international8
    :international9 :lang1 :lang2
    :lang3 :lang4 :lang5
    :lang6 :lang7 :lang8
    :lang9 :alterase :sysreq
    :cancel :clear :prior
    :return2 :separator :out
    :oper :clearagain :crsel
    :exsel nil nil nil nil nil nil nil nil nil nil nil
    :kp_00 :kp_000 :thousandsseparator
    :decimalseparator :currencyunit
    :currencysubunit :kp_leftparen
    :kp_rightparen :kp_leftbrace
    :kp_rightbrace :kp_tab :kp_backspace
    :kp_a :kp_b :kp_c :kp_d
    :kp_e :kp_f :kp_xor
    :kp_power :kp_percent :kp_less
    :kp_greater :kp_ampersand
    :kp_dblampersand :kp_verticalbar
    :kp_dblverticalbar :kp_colon :kp_hash
    :kp_space :kp_at :kp_exclam
    :kp_memstore :kp_memrecall
    :kp_memclear :kp_memadd
    :kp_memsubtract :kp_memmultiply
    :kp_memdivide :kp_plusminus :kp_clear
    :kp_clearentry :kp_binary :kp_octal
    :kp_decimal :kp_hexadecimal nil nil
    :lctrl :lshift :lalt
    :lgui :rctrl :rshift
    :ralt :rgui nil nil nil nil nil nil nil nil nil nil
    nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil
    :mode :audionext :audioprev
    :audiostop :audioplay :audiomute
    :mediaselect :www :mail
    :calculator :computer :ac_search
    :ac_home :ac_back :ac_forward
    :ac_stop :ac_refresh :ac_bookmarks
    :brightnessdown :brightnessup
    :displayswitch :kbdillumtoggle
    :kbdillumdown :kbdillumup :eject
    :sleep))

;;--------------------------------------------
;; glfw event helpers

(defvar *tpref* nil)

(glfw:def-window-close-callback window-close-callback (window)
  (declare (ignore window))

  (set-window-manager-quitting
   +window-manager+ (glfw:get-time) t tpref))

(glfw:def-window-size-callback window-size-callback (window w h)
  (declare (ignore window))

  (set-window-size (window 0) (glfw:get-time)
                   (v!uint w h)
                   tpref))

(glfw:def-key-callback key-callback (window key scancode action mod-keys)
  (declare (ignore window scancode mod-keys))
  (let ((kbd (keyboard 0)))
    (set-keyboard-button kbd key (glfw:get-time) (eq action :press) tpref)))

(glfw:def-mouse-button-callback mouse-button-callback (window button action mod-keys)
  (declare (ignore window mod-keys))
  (let* ((mouse-id 0)
         (mouse (mouse mouse-id)))
    (set-mouse-button mouse button (get-time) (eq action :press) tpref)))

(glfw:def-cursor-pos-callback mouse-moved-callback (window x y)
  (declare (ignore window))
  (let* ((mouse-id 0)
         (mouse (mouse mouse-id)))
    (set-mouse-pos mouse
                   (get-internal-real-time)
                   (v! x y)
                   tpref)))

(defvar *event-listeners-installed* nil)

(defun setup-event-listeners ()
  (glfw:set-window-close-callback 'window-close-callback)
  (glfw:set-window-size-callback 'window-size-callback)
  (glfw:set-key-callback 'key-callback)
  (glfw:set-mouse-button-callback 'mouse-button-callback)
  (glfw:set-cursor-position-callback 'mouse-moved-callback)

  (setf *event-listeners-installed* t))

(defun collect-glfw-events (win &optional tpref)
  (declare (ignore win))

  (if (not *event-listeners-installed*)
      (setup-event-listeners))

  (let ((*tpref* tpref))
    (glfw:poll-events)))

;;--------------------------------------------
;; intializing

(defmethod initialize-kind :after ((kind keyboard))
  (loop for nil across *key-button-names* do
       (add kind (make-boolean-control))))

(defmethod initialize-kind :after ((kind mouse))
  (loop for nil across *mouse-button-names* do
       (add kind (make-boolean-control))))
