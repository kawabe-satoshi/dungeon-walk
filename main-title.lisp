

(defun draw-main-title ()
  (fill-screen sdl:*white*)
  (center-caption "[ M A I N  T I T L E ]")
  (print "draw-main-title"))

(defun keydown-main-title (k)
  (cond
    ((sdl:key= k :sdl-key-escape)
     (setf *game-mode* :castle)
     (sdl:push-quit-event))
    ((sdl:key= k :sdl-key-q)
     (setf *game-mode* :quit-game)
     (sdl:push-quit-event))))

(defun main-title ()
  (print "main-title")
  (fill-screen sdl:*white*)
  (draw-main-title)
  (sdl:with-events ()
    (:quit-event () t)
    (:key-down-event (:key key)
		     (keydown-main-title key))
    (:idle
     (sdl:update-display))))


