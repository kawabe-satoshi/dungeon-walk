
(defun main-loop ()
  (case *game-mode*
    ((:quit-game)
     (setf *quit-game* t))
    ((:main-title)
     (main-title))
    ((:castle)
     (castle-main))
    ((:adventures-inn)
     (adventures-inn-main))
    (otherwise
     ())))
     
;;;;;

(defun main ()
  (print "main")
  (sdl:with-init ()
    (initialize)
    (initialize-fonts)
    (loop
       do
	 (progn
	   (print (format nil "game-mode=~a" *game-mode*))
	   (main-loop)
	   (fill-screen sdl:*white*)
	   (sdl:update-display))
	 until *quit-game*)))
