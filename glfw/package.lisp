;;;; package.lisp

(uiop:define-package #:skitter.glfw
    (:use #:cl #:skitter #:rtg-math #:skitter.internals)
  (:export :collect-glfw-events))

(defpackage #:skitter.glfw.keys
  (:use #:cl)
  (:export :key.id
           :key.a
           :key.b
           :key.c
           :key.d
           :key.e
           :key.f
           :key.g
           :key.h
           :key.i
           :key.j
           :key.k
           :key.l
           :key.m
           :key.n
           :key.o
           :key.p
           :key.q
           :key.r
           :key.s
           :key.t
           :key.u
           :key.v
           :key.w
           :key.x
           :key.y
           :key.z
           :key.1
           :key.2
           :key.3
           :key.4
           :key.5
           :key.6
           :key.7
           :key.8
           :key.9
           :key.0
           :key.return
           :key.escape
           :key.backspace
           :key.tab
           :key.space
           :key.minus
           :key.equals
           :key.leftbracket
           :key.rightbracket
           :key.backslash
           ;; :key.nonushash
           :key.semicolon
           :key.apostrophe
           :key.grave
           :key.comma
           :key.period
           :key.slash
           :key.capslock
           :key.f1
           :key.f2
           :key.f3
           :key.f4
           :key.f5
           :key.f6
           :key.f7
           :key.f8
           :key.f9
           :key.f10
           :key.f11
           :key.f12
           :key.printscreen
           :key.scrolllock
           :key.pause
           :key.insert
           :key.home
           :key.pageup
           :key.delete
           :key.end
           :key.pagedown
           :key.right
           :key.left
           :key.down
           :key.up
           :key.numlockclear
           :key.kp_divide
           :key.kp_multiply
           :key.kp_minus
           :key.kp_plus
           :key.kp_enter
           :key.kp_1
           :key.kp_2
           :key.kp_3
           :key.kp_4
           :key.kp_5
           :key.kp_6
           :key.kp_7
           :key.kp_8
           :key.kp_9
           :key.kp_0
           :key.kp_period
           ;; :key.nonusbackslash
           ;; :key.application
           ;; :key.power
           :key.kp_equals
           :key.f13
           :key.f14
           :key.f15
           :key.f16
           :key.f17
           :key.f18
           :key.f19
           :key.f20
           :key.f21
           :key.f22
           :key.f23
           :key.f24
           ;; :key.execute
           ;; :key.help
           :key.menu
           ;; :key.select
           ;; :key.stop
           ;; :key.again
           ;; :key.undo
           ;; :key.cut
           ;; :key.copy
           ;; :key.paste
           ;; :key.find
           ;; :key.mute
           ;; :key.volumeup
           ;; :key.volumedown
           ;; :key.lockingcapslock
           ;; :key.lockingnumlock
           ;; :key.lockingscrolllock
           ;; :key.kp_comma
           ;; :key.kp_equalsas400
           ;; :key.international1
           ;; :key.international2
           ;; :key.international3
           ;; :key.international4
           ;; :key.international5
           ;; :key.international6
           ;; :key.international7
           ;; :key.international8
           ;; :key.international9
           ;; :key.lang1
           ;; :key.lang2
           ;; :key.lang3
           ;; :key.lang4
           ;; :key.lang5
           ;; :key.lang6
           ;; :key.lang7
           ;; :key.lang8
           ;; :key.lang9
           ;; :key.alterase
           ;; :key.sysreq
           ;; :key.cancel
           ;; :key.clear
           ;; :key.prior
           ;; :key.return2
           ;; :key.separator
           ;; :key.out
           ;; :key.oper
           ;; :key.clearagain
           ;; :key.crsel
           ;; :key.exsel
           ;; :key.kp_00
           ;; :key.kp_000
           ;; :key.thousandsseparator
           ;; :key.decimalseparator
           ;; :key.currencyunit
           ;; :key.currencysubunit
           ;; :key.kp_leftparen
           ;; :key.kp_rightparen
           ;; :key.kp_leftbrace
           ;; :key.kp_rightbrace
           ;; :key.kp_tab
           ;; :key.kp_backspace
           ;; :key.kp_a
           ;; :key.kp_b
           ;; :key.kp_c
           ;; :key.kp_d
           ;; :key.kp_e
           ;; :key.kp_f
           ;; :key.kp_xor
           ;; :key.kp_power
           ;; :key.kp_percent
           ;; :key.kp_less
           ;; :key.kp_greater
           ;; :key.kp_ampersand
           ;; :key.kp_dblampersand
           ;; :key.kp_verticalbar
           ;; :key.kp_dblverticalbar
           ;; :key.kp_colon
           ;; :key.kp_hash
           ;; :key.kp_space
           ;; :key.kp_at
           ;; :key.kp_exclam
           ;; :key.kp_memstore
           ;; :key.kp_memrecall
           ;; :key.kp_memclear
           ;; :key.kp_memadd
           ;; :key.kp_memsubtract
           ;; :key.kp_memmultiply
           ;; :key.kp_memdivide
           ;; :key.kp_plusminus
           ;; :key.kp_clear
           ;; :key.kp_clearentry
           ;; :key.kp_binary
           ;; :key.kp_octal
           ;; :key.kp_decimal
           ;; :key.kp_hexadecimal
           ;; :key.lctrl
           ;; :key.lshift
           ;; :key.lalt
           ;; :key.lgui
           ;; :key.rctrl
           ;; :key.rshift
           ;; :key.ralt
           ;; :key.rgui
           ;; :key.mode
           ;; :key.audionext
           ;; :key.audioprev
           ;; :key.audiostop
           ;; :key.audioplay
           ;; :key.audiomute
           ;; :key.mediaselect
           ;; :key.www
           ;; :key.mail
           ;; :key.calculator
           ;; :key.computer
           ;; :key.ac_search
           ;; :key.ac_home
           ;; :key.ac_back
           ;; :key.ac_forward
           ;; :key.ac_stop
           ;; :key.ac_refresh
           ;; :key.ac_bookmarks
           ;; :key.brightnessdown
           ;; :key.brightnessup
           ;; :key.displayswitch
           ;; :key.kbdillumtoggle
           ;; :key.kbdillumdown
           ;; :key.kbdillumup
           ;; :key.eject
           ;; :key.sleep
           ))

(defpackage #:skitter.glfw.mouse-buttons
  (:use #:cl)
  (:export :mouse.button-id
           :mouse.left
           :mouse.middle
           :mouse.right
           :mouse.other0
           :mouse.other1
           :mouse.other2
           :mouse.other3
           :mouse.other4))
