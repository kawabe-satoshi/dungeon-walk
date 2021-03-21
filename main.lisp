
;; <<<<<<< HEAD
;; =======
;; (defun key-down-handler (key)
;;   (when  (sdl:key= key :sdl-key-escape)
;;     (sdl:push-quit-event)
;;     (setf *quit-game* t)))
;; ;;;;
;; ;;;; key-down-handlerは各モードで別の反応をしなくてはならない。

;; ;;;;

;; (defun key-up-handler (k)
;;   )

;; ;;;;

;; (defun update-screen ()
;;   (sdl:fill-surface sdl:*white* :surface sdl:*default-display*)
;;   (goto-xy 33 10 *gothic16*)
;;   (draw-string "Dungeon Walk" *gothic16*)
;;   (goto-xy 35 11 *gothic16*)
;;   (draw-string "Ver. 0.1" *gothic16*)
;;   (sdl:update-display))

;; ;;;;

;; >>>>>>> 7950f8b17aed797f51d8fced58044bd0a85343f6
(defun main-loop ()
  (case *game-mode*
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
       (print (format nil "game-mode=~a" *game-mode*))
       (main-loop)
       (fill-screen sdl:*white*)
       (sdl:update-display)
       (if *quit-game*
	   (return nil)))))
