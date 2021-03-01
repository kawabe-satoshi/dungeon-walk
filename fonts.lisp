
;;;; フォント画像ファイル(Gothic16.png, etc..)は、
;;;; 1行目 半角英数(Ascii)
;;;; 2行目 全角の 。「」 の3文字
;;;; 3行目 全角ひらがな
;;;; 4行目 全角カタカナ
;;;; 5-6行目 全角英数・記号
;;;; の構成になっており、全角/半角それぞれで文字幅が異なる。
;;;; 文字オブジェクトには文字をキーとしたハッシュテーブルが含まれ、その文字の表示に必要な画像範囲を返す。



;;;;
;;;; フォントテーブル設定
;;;;

(defparameter *gothic32* nil)
(defparameter *gothic16* nil)

(defparameter *font-table* (make-hash-table))

(defparameter *ascii-set*     '(#\SPACE  #\~))
(defparameter *hankaku-kigou* '(#\｡ #\･))
(defparameter *hiragana-set*  '(#\ぁ #\ゖ))
(defparameter *katakana-set*  '(#\ァ #\ヾ))
(defparameter *zenkaku-sign1* '(#\　 #\〟))
(defparameter *zenkaku-sign2* '(#\！ #\｠))
(defparameter *all-set* (list *ascii-set*
			      *hankaku-kigou*
			      *hiragana-set*
			      *katakana-set*
			      *zenkaku-sign1*
			      *zenkaku-sign2*))
(defun set-font-table ()
  (let ((cell-index 0))
    (flet ((set-each-table (char-set)
	     (loop for c from (char-code (car char-set)) to (char-code (cadr char-set)) do
	       (progn
		 (setf (gethash (code-char c) *font-table*) cell-index)
		 (incf cell-index)))))
      (dolist (i *all-set*)
	(set-each-table i)))))

;;;;
;;;; 表示用カーソル情報(不要?)
;;;;

;(defparameter *x32* 0)
;(defparameter *y32* 0)
;defparameter *x16* 0)
;(defparameter *y16* 0)

;;;;
;;;; フォントオブジェクト設定
;;;;

(defclass font-obj ()
  ((filename    :accessor font-filename :initarg :filename)
   (img         :accessor font-img)
   (size        :accessor font-size :initarg :size)
   (half-size   :accessor font-half-size)
   (width-table :accessor font-width-table)
   (cells       :accessor font-cells)
   (x           :accessor font-x  :initform 0)
   (y           :accessor font-y  :initform 0)))

(defun make-font-obj (filename size)
  (let ((fo (make-instance 'font-obj :filename filename :size size)))
    (setf (font-img fo) (load-png-image (font-filename fo)))
    (setf (font-half-size fo) (/ (font-size fo) 2))
    (setf (font-cells fo) (make-cells size))
    (setf (sdl:cells (font-img fo)) (font-cells fo))
    (setf (font-width-table fo) (make-width-table size))
    fo))

;;;; ひらがな、カタカナ、全角英数、半角英数それぞれの文字幅が入り乱れる。
;;;; それぞれの文字セットごとに、フォント画像の対応する座標範囲(cells of char-set)を決定する。
(defun cells-of-line (char-set height row &optional half)
  (let ((result nil)
	(width))
    (if half
	(setf width (/ height 2))
	(setf width height))
    (dotimes (i (1+ (- (char-code (cadr char-set)) (char-code (car char-set)))))
      (setf result (cons (list (* width i) (* height row) width height) result)))
    (reverse result)))


;;;; 各文字をキーとしたハッシュテーブルを作る。
;;;; 文字を検索すると、その文字を表示する画像範囲(cell)が返る。
(defun make-cells (size)
  (let ((result nil)
	(row 0))
    (dolist (i *all-set*)
      (if (or (eql i *ascii-set*)
	      (eql i *hankaku-kigou*))
	  (setf result (append result (cells-of-line i size row t)))
	  (setf result (append result (cells-of-line i size row nil))))
      (incf row))
    result))

(defun make-width-table (size)
  (let ((width-table (make-hash-table))
	(half-size (/ size 2)))
    (flet ((make-each-table (char-set width)
	     (loop for c
		from (char-code (car  char-set))
		to   (char-code (cadr char-set))
		do
		  (setf (gethash (code-char c) width-table) width))))
      (dolist (i *all-set*)
	(if (or (eql i *ascii-set*)
		(eql i *hankaku-kigou*))
	    (make-each-table i half-size)
	    (make-each-table i size)))
      width-table)))

;;;;
;;;; フォント表示
;;;;

;;; 現在のFont-objのカーソル位置を(x,y)に設定する。
(defun goto-xy (x y font-obj)
  (setf (font-x font-obj) x)
  (setf (font-y font-obj) y))

;;; フォントオブジェクトのカーソルXを、letterに応じて半角/全角分だけ移動させる。
(defun next-x (letter font-obj)
  (let ((next-width (gethash letter (font-width-table font-obj))))
    (if (= next-width (font-size font-obj))
	(setf (font-x font-obj) (+ (font-x font-obj) 2))
	(setf (font-x font-obj) (+ (font-x font-obj) 1)))))

;;;; カーソル座標 -> 画面座標の変換
;;;; 注意!： カーソルのX座標は、半角単位で指定する。
;;;; 表示する文字種によって、自動的に半角/全角に応じたカーソル座標を加算する。
;;;; そのため、X=(* font-x font-half-size), Y=(* font-y font-size)となる。
(defun x-pixel (font-obj)
  (* (font-x font-obj) (font-half-size font-obj)))

(defun y-pixel (font-obj)
  (* (font-y font-obj) (font-size font-obj)))

;;;; 現在のfont-objのカーソル位置を画面上のピクセルに変更して、
;;;; (x y)のリストにして返す。
;;;; 使いかた：
;;;;    (goto-xy x y font-obj)
;;;;    (xy-pixel) -> 返り値に(x-pixel y-pixel)が返る。

(defun xy-pixel (font-obj)
  (list (x-pixel font-obj) (y-pixel font-obj)))
		 
;;; 文字/文字列表示の本体
(defun draw-letter (letter font-obj)
  (sdl:draw-surface-at-* (font-img font-obj)
			 (x-pixel font-obj)
			 (y-pixel font-obj)
			 :cell (gethash letter *font-table*))
  (next-x letter font-obj))

(defmethod draw-string (str font-obj)
  (dolist (c (concatenate 'list str))
    (draw-letter c font-obj)))

;;;;
;;;;
;;;;

;;;; initialize-fontsは、sdl:with-initのあとで呼ぶこと!
(defun initialize-fonts ()
  (set-font-table)
  (setf *gothic16* (make-font-obj "Gothic16.png" 16))
  (setf *gothic32* (make-font-obj "Gothic32.png" 32)))





;;;
;; (defun main ()
;;   (set-font-table)
;;   (sdl:with-init ()
;;     (sdl:window 640 480)

;;     (setf *gothic16* (make-font-obj "Gothic16.png" 16))
 
;;     (setf (sdl:frame-rate) 60)
;;     (sdl:update-display)

;;     (sdl:with-events ()
;;       (:quit-event () t)
;;       (:key-down-event
;;        (:key key)
;;        (when (sdl:key= key :sdl-key-escape)
;; 	 (sdl:push-quit-event)))
;;       (:idle ()
;; 	     (sdl:clear-display sdl:*white*)
;; 	     (goto-xy 2 4 *gothic16*)
;; 	     (draw-string "abcdefg12345678!@#$%^&*()_+|~" *gothic16*)
;; 	     (sdl:update-display)))))

