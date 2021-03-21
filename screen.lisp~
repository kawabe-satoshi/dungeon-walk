

;;;; ウィンドウを塗り潰す。colorはsdl:*(color-name)* で指定すること。

(defmacro fill-screen (color)
  `(sdl:fill-surface ,color :surface sdl:*default-display*))

(defun draw-filled-frame (x y w h color font)
  )

(defun draw-frame (x y w h color font)
  )

(defun draw-horizontal-line (y c)
  (goto-xy 0 y)
  (draw-string (format nil "~V@{~A~:*~}" (screen-font-width) c)))
