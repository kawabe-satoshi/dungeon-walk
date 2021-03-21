(defun draw-main-menu-*castle* ()
  (both-side-caption "C A S T L E" "Adventure's INN")
  (goto-xy 0 21)
  (draw-string "[ESC] or L)eave")
  (sdl:update-display))

(defun keydown-castle (k)
  (when (sdl:key= k :sdl-key-escape)
    (setf *game-mode* :main-title)
    (sdl:push-quit-event)))
  
(defun castle-main ()
  (fill-screen sdl:*white*)
  (draw-main-menu-*castle*)
  (loop 
     (sdl:with-events ()
       (:quit-event () t)
       (:key-down-event (:key key)
			(keydown-castle key))
       (:idle
	(sdl:update-display)))))
