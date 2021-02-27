

;;;;; ----------------------------
;;;;; GLOBAL VARIABLES & CONSTANTS
;;;;; ----------------------------


;;; GAME CONTROL
(defparameter *quit-game* nil)
(defparameter *game-mode* :title)
(defparameter *counter* 0)
(defparameter *cursor-x* 1)

;;; DUNGEON DATA
(defparameter *dungeon-data* (make-hash-table))

(defparameter *single-key* '("name" "max-stories" "entrance"))
(defparameter *double-key* '("message" "event" "locked-door" "map"))


;;; SPRITE
(defparameter *sprite-sheet* nil)

(defconstant +white-square+  0)
(defconstant +black-square+  1)
(defconstant +red-square+    2)
(defconstant +purple-square+ 3)
(defconstant +blue-square+   4)
(defconstant +cyan-square+   5)
(defconstant +green-square+  6)
(defconstant +yellow-square+ 7)
(defconstant +white-circle+  8)
(defconstant +black-circle+  9)
(defconstant +red-circle+    10)
(defconstant +purple-circle+ 11)
(defconstant +blue-circle+   12)
(defconstant +cyan-circle+   13)
(defconstant +green-circle+  14)
(defconstant +yellow-circle+ 15)


;;; SCREEN

(defparameter *bg-color* sdl:*white*)

;;;;; ----------------------------
;;;;; Basic Tools
;;;;; ----------------------------

(defun single (lst)
  (and (consp lst) (not (cdr lst))))
