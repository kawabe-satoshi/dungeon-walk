(defpackage #:dungeon-walk
    (:use :cl :asdf))

(in-package :dungeon-walk)

(defsystem dungeon-walk
    :name       "Dungeon Walk"
    :version    "0.0.0"
    :maintainer "sedawk"
    :author     "sedawk"
    :serial     t
    :components (
		 (:file "sprite")
                 (:file "fonts"
			:depends-on ("sprite"))
                 (:file "globals"
                        :depends-on ("sprite" "fonts"))
		 (:file "initialize"
			:depends-on ("sprite" "fonts" "globals"))
                 (:file "main"
                        :depends-on ("initialize" "sprite" "fonts" "globals"))))
