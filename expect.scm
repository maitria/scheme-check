(include "expect#.scm")

(define *expectations* '())

(define (add-expectation expectation)
  (set! *expectations* (append *expectations* (list expectation))))

(define (run-expectations)
  (for-each expect:run-single *expectations*)
  (newline))

(define (expect:run-single spec)
  (define (reporter kind extra)
    (case kind
      ((pass)
       (display "."))
      ((fail)
       (display "F"))
      ((error)
       (display "E"))))

  (let* ((source-locat (car spec))
	 (check-proc (cdr spec)))
    (check-proc reporter)))

