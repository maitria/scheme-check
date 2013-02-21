(include "expect#.scm")

(expect (let ((m (make-memory)))
	  (= 0 (memory-ref m 0))))
