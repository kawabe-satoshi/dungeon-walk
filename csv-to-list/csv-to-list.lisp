(defparameter *dungeon-data* nil)
(defparameter *csv-filename* "dungeon-data.csv")
(defparameter *first* nil)

(defun remove-empty-string (l)
  ;;; read-from-string は ""(空文字列)に対応できないので、
  ;;; 最初に取り除いておく。
  (remove-if #'(lambda (x) (equal x '"")) l))

(defun convert-each (l)
  (mapcar #'read-from-string (remove-empty-string l)))

(defun main ()
  (setf *dungeon-data*
	(with-open-file (*dungeon-data* *csv-filename*)
	  (parse-csv *dungeon-data*)))
  (mapcar #'convert-each *dungeon-data*))

