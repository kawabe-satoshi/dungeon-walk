

(defun draw-main-title ()
  (fill-screen sdl:*white*)
  (draw-horizontal-line 9 "-")
  (goto-xy 10 10)
  (draw-string "[M A I N   T I T L E]")
  (draw-horizontal-line 11 "-")
  (goto-xy 1 1)
  (sdl:update-display)
  (print "draw-main-title"))

(defun main-title ()
  (print "main-title")
  (draw-main-title)
  (loop-until-pressed :sdl-key-escape)
  (setf *game-mode* :castle))

