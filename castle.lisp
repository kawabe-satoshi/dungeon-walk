(defun draw-main-menu-*castle* ()
  (goto-xy 0 0)
  (draw-string "C A S T L E")
  (goto-xy 0 20)
  (draw-string "A)dventure's Inn")
  (goto-xy 0 21)
  (draw-string "[ESC] or L)eave")
  (sdl:update-display))

(defun keydown-castle (k)
  (when (sdl:key= k :sdl-key-escape)
    (setf *game-mode* :main-title)
    (sdl:push-quit-event)))
  
(defun castle-main ()
  (fill-screen sdl:*blue*)
  (draw-main-menu-*castle*)
  (loop 
     (sdl:with-events ()
       (:quit-event () t)
       (:key-down-event (:key key)
			(keydown-castle key))
       (:idle
	(sdl:update-display)))))
