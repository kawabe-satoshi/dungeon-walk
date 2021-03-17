

;;;;; +---------------+
;;;;; ! ADVENTURS INN !
;;;;; +---------------+


(defun draw-main-menu-inn ()
  (goto-xy 0 0 *gothic16*)
  (draw-string "Adventures Inn")
  (goto-xy 5 20 *gothic16*)
  (draw-string (format nil "だれが とまり ますか？ (~A)" (select-who-string *party*)))
  (goto-xy 5 21 *gothic16*)
  (draw-string "[ESC] しろ に もどる"))

(defun draw-room-menu-inn (c)
  (goto-xy 0 0 *gothic16*)
  (draw-string "どの へや に とまりますか? [A-D]")
  (goto-xy 5 10 *gothic16*)
  (draw-string "[A] うまごや (むりょう!)")
  (goto-xy 5 21 *gothic16*)
  (draw-string "[ESC] しろ に もどる"))


(defun keydown-room (k)
;;; kが正しい部屋指定かは、まだ不明。
  (cond ((sdl:key= key :sdl-key-escape)
	 (sdl:push-quit-event))
	((sdl:key= key :sdl-key-a)
	 (fill-screen sdl:*green*)
	 (goto-xy 5 10 *gothic16*)
	 (draw-string "うまごや に たいざい しました。")
	 (loop-until-pressed-escape))))




(defun stay-inn (c)
  ;; (print "stay-inn (c)です"))
;;; cは1-6のどれかで、パーティに居るメンバーかどうか、まだ不明。
  (when (<= c (number-of-party *party*)) ;cがパーティ内に居れば、
    (draw-room-menu-inn c)
    (loop
       (sdl:with-events ()
	 (:quiut-event t nil)
	 (:key-down-event (:key key)
			  (keydown-room key))
	  (:idle t)))))

(defun keydown-inn (key)
;;; key-down-eventでこの関数を評価。
;;; keyが[ESC]なら城に帰る。
;;; keyが1-6の数値なら、対応メンバーが宿に行く。
;;; keyがいないメンバーなら何もしない。
  (let ((who-stay (sdl-key-to-number key)))
    (cond ((sdl:key= key :sdl-key-escape);; [ESC]で宿を出て城に帰る。
	   (setf *game-mode* :castle)
	   (sdl:push-quit-event))
	  (who-stay                       ;; who-stay が nil でなければ、(who-stayが1-6なら)
	   (stay-inn who-stay)))))


(defun adventures-inn-main ()
  (fill-screen sdl:*blue*)
  (draw-main-menu-inn)
  (loop
    (sdl:with-events ()
      (:quiut-event t nil)
      (:key-down-event (:key key)
		       (keydown-inn key))
      (:idle t))))

