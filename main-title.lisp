

(defun draw-main-title ()
  (fill-screen sdl:*white*)
  (center-caption "[ M A I N  T I T L E ]")
  (print "draw-main-title"))

(defun main-title ()
  (print "main-title")
  (fill-screen sdl:*white*)
  (sdl:update-display)
  (draw-main-title)
  (loop-until-pressed-any-key)
  (setf *game-mode* :castle))

