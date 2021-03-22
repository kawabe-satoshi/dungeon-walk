(defun draw-main-menu-castle ()
  (center-caption "C A S T L E")
  (goto-xy 0 4)
  (draw-string (align-center "A)ぼうけんしゃ の やど" 2))
  (goto-xy 0 21)
  (draw-string (align-center "[ESC] メインタイトル に もどる" 2))
  (sdl:update-display))

(defun keydown-castle (k)
  (when (sdl:key= k :sdl-key-escape)
    (progn
      (setf *game-mode* :main-title)
      (sdl:push-quit-event))))
  
(defun castle-main ()
  (fill-screen sdl:*white*)
  (draw-main-menu-castle)
  (sdl:with-events ()
    (:quit-event () t)
    (:key-down-event (:key key)
		     (keydown-castle key))
    (:idle
     (sdl:update-display))))
