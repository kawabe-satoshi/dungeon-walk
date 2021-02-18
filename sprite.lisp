

;;;;; ----------------------------
;;;;; SPRITE
;;;;; ----------------------------


;;;;
;;;; 使用画像読み込み
;;;; (注： sdl:windowの後に呼ばないといけません。)

(defun load-png-image (source-file)
  (sdl:convert-to-display-format :surface (sdl:load-image source-file)
				 :enable-alpha t
				 :pixel-alpha t))

;;;;
;;;; Constant
;;;;

(defconstant +sprite-table-size+ 16) ; 0-15までの16個をタテヨコのサイズとする。16x16

;;;;
;;;; Sprite Object
;;;;

(defclass sprite-sheet ()
  ((filename    :accessor sprite-filename :initarg :filename)
   (image       :accessor sprite-image)
   (size        :accessor sprite-size :initarg :size)
   (cells       :accessor sprite-cells)))

(defun make-sprite-sheet (filename size)

  ;; スプライトファイルのfilename、ひとつのスプライトのドット数(8x8ドットなら8)を指定し、
  ;; スプライトオブジェクトを作って返す。
  
  (let ((so (make-instance 'sprite-sheet :filename filename :size size)))
    (setf (sprite-image so) (load-png-image filename))
    (setf (sprite-cells so) (make-sprite-cells size))
    (setf (sdl:cells (sprite-image so)) (sprite-cells so))
    so))

(defun make-sprite-cells (size)
  (loop for y below +sprite-table-size+ append
       (loop for x below +sprite-table-size+ append
	    (list (list (* x size) (* y size) size size)))))

;;;;
;;;; Draw Sprite
;;;;

;; スプライトの描画に必要なのは
;; 1.スプライトシート・オブジェクト (sprite-st)
;; 2.描画するスプライトナンバー : +sprite-table-size+が16なら、0-255
;; 3.描画する場所 : スプライトサイズで規定される場所(x y)か、ピクセルで指定(px py)

(defun draw-sprite-pixel (sprite-st cell-number px py)
  (sdl:draw-surface-at-* (sprite-image sprite-st)
			 px
			 py
			 :cell cell-number))

(defun draw-sprite (sprite-st cell-number x y)
  (sdl:draw-surface-at-* (sprite-image sprite-st)
			 (* (sprite-size sprite-st) x)
			 (* (sprite-size sprite-st) y)
			 :cell cell-number))
