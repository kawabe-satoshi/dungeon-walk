

;;;;; ----------------------------
;;;;; GLOBAL VARIABLES & CONSTANTS
;;;;; ----------------------------

;;; PLAYER DATA

(defparameter *party* '(("そのいち") ("そのに") ("sono-san") ("ソノヨン")))

(defmacro number-of-party (p)
  `(length ,p))

(defun select-who-string (p)
  (if (single p)
      "1"
      (format nil "1-~A" (number-of-party p))))
      

;;; GAME CONTROL
(defparameter *quit-game* nil)

(defparameter *game-mode* :main-title) ; mode-> :main-title :castle :trading-post :inn :tavern :temple :training :option

;;; SDL NUMERIC KEYS
(defparameter *sdl-numeric-keys* '(:sdl-key-0
				   :sdl-key-1
				   :sdl-key-2
				   :sdl-key-3
				   :sdl-key-4
				   :sdl-key-5
				   :sdl-key-6
				   :sdl-key-7
				   :sdl-key-8
				   :sdl-key-9))

(defun sdl-key-numberp (k)
  (find k *sdl-numeric-keys*))

(defun sdl-key-to-number (k)
  (position k *sdl-numeric-keys*))
;;(position key *number-of-sdl-keys*) で何番目かを調べて数値に変換
;; key が0-9になければnilを返す。


;;; DUNGEON DATA
(defparameter *dungeon-data* (make-hash-table))

;(defparameter *single-key* '("name" "max-stories" "entrance"))
;(defparameter *double-key* '("message" "event" "locked-door" "map"))



;;; SCREEN

;(defparameter *bg-color* sdl:*white*)
;(defparameter *fg-color* sdl:*black*)

(defparameter *screen-width*  640)
(defparameter *screen-height* 480)

;;; 今のフォントで1画面の縦横の文字数
;;; 本来、font-obj内に情報を埋めたいが、"globals :depends-on font"なので
;;; globals側でマクロにて対応。

(defmacro screen-font-width ()
  `(/ *screen-width*  (font-half-size *current-font*)))
(defmacro screen-font-height ()
  `(/ *screen-height* (font-size      *current-font*)))

;;;;; ----------------------------
;;;;; Basic Tools
;;;;; ----------------------------

(defun single (lst)
  (and (consp lst) (not (cdr lst))))


;;; CONVERT SDL-Key TO CHAR

(defparameter *sdl-alphabet-key-alist* '((:sdl-key-0 #\0) (:sdl-key-1 #\1) (:sdl-key-2 #\2)
					 (:sdl-key-3 #\3) (:sdl-key-4 #\4) (:sdl-key-5 #\5)
					 (:sdl-key-6 #\6) (:sdl-key-7 #\7) (:sdl-key-8 #\8)
					 (:sdl-key-9 #\9)
					 					 
					 (:sdl-key-a #\a) (:sdl-key-b #\b) (:sdl-key-c #\c)
					 (:sdl-key-d #\d) (:sdl-key-e #\e) (:sdl-key-f #\f)
					 (:sdl-key-g #\g) (:sdl-key-h #\h) (:sdl-key-i #\i)
					 (:sdl-key-j #\j) (:sdl-key-k #\k) (:sdl-key-l #\l)
					 (:sdl-key-m #\m) (:sdl-key-n #\n) (:sdl-key-o #\o)
					 (:sdl-key-p #\p) (:sdl-key-q #\q) (:sdl-key-r #\r)
					 (:sdl-key-s #\s) (:sdl-key-t #\t) (:sdl-key-u #\u)
					 (:sdl-key-v #\v) (:sdl-key-w #\w) (:sdl-key-x #\x)
					 (:sdl-key-y #\y) (:sdl-key-z #\z)))
(defun sdl-key-char (k)
  (car (assoc k *sdl-alphabet-key-alist*)))
				       
(defun loop-until-pressed (k)
  (print "loop-until-pressed k")
  (sdl:with-events ()
    (:quit-event () t)
    (:key-down-event (:key key)
		     (when (sdl:key= key k)
		       (progn
			 (print (format nil "~a pressed" k))
			 (sdl:push-quit-event))))
    (:idle ()
	   (sdl:update-display))))

(defun loop-until-pressed-any-key ()
  (sdl:with-events ()
    (:quit-event () t)
    (:key-down-event (:key k)
		     (sdl:push-quit-event))
    (:idle ()
	   (sdl:update-display))))
