
(defun key-down-handler (key)
  (when  (sdl:key= key :sdl-key-escape)
    (sdl:push-quit-event)
    (setf *quit-game* t)))
;;;;
;;;; key-down-handlerは各モードで別の反応をしなくてはならない。

;;;;

(defun key-up-handler (k)
  )

;;;;

(defun update-screen ()
  (sdl:fill-surface sdl:*white* :surface sdl:*default-display*)
  (goto-xy 0 0 *gothic16*)
  (draw-string "こんにちは! みなさん!" *gothic16*)
  (draw-string "  それからね、これはつづきなんだけどs...." *gothic16*)
  (sdl:update-display))

;;;;

(defun main-loop ()
  (case *game-mode*
    (:main-title
     (main-title))
    (otherwise
     ())))
     

;;;;;

(defun main ()
  (sdl:with-init ()
    (initialize)
    (initialize-fonts)
    (loop
       (main-loop)
       (if *quit-game*
	   (return nil)))))


;;;; 全体の構造
;;;; *game-mode* -> opening, town , store, inn, dungeon, leave-game ....etc.
;;; (defun main ()
;;;  (sdl:with-init ()
;;;   (initialize)
;;;   (loop
;;;    (case *game-mode*
;;;     (:opening (opening-loop)
;;;     (:town    (town-loop)
;;;           ......
;;;     (:leave-game (quite-game))))

;;;  各モード内で、それぞれloopとキー入力の処理を行なう。
