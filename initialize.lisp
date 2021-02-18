
;;;;
(defun initialize ()
;;; Windowの準備とスプライトオブジェクトの作成

  (sdl:window 640 480 :title-caption "Dungeon Walker")
  (sdl:fill-surface sdl:*blue* :surface sdl:*default-display*)
  (setf (sdl:frame-rate) 30)
  (sdl:update-display)

  (setf *sprite-sheet* (make-sprite-sheet "sprite16.png" 16)))
  
;;;; まずダンジョンデータ読み込み

					;  (let ((sp-image (load-png-image "sprite16.png"))))
