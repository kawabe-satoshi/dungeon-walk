

(defun draw-main-title ()
  )

(defun main-title ()
  (draw-main-title)
  
  (sdl:with-events ()
    (:quit-event () t)
    (:key-down-event (:key key)
		     (key-down-handler key))
    (:key-up-event (:key key)
		   (key-up-handler key))
    (:idle
     ())))

