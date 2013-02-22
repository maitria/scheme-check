
(define (system command)
  (let ((p (open-process (list 
			   path: "/bin/sh"
			   arguments: `("-c" ,command)
			   stdin-redirection: #f
			   stdout-redirection: #f
			   stderr-redirection: #f))))
    (process-status p)))

(define (files-in-directory dir)
  (let* ((directory-handle (open-directory dir))
	 (files (read-all directory-handle)))
    (close-input-port directory-handle)
    (map
      (lambda (file)
	(string-append dir "/" file))
    files)))

(define (filter predicate list)
  (define results '())
  (for-each
    (lambda (element)
      (if (predicate element)
	(set! results (cons element results))))
    list)
  (reverse results))

(define (file-extension filename)

  (define (last-index-of char str)
    (let loop ((index (- (string-length str) 1)))
      (cond
	((< index 0)
	 #f)
	((char=? char (string-ref str index))
	 index)
	(else
	 (loop (- index 1))))))

  (let ((dot-index (last-index-of #\. filename))
	(slash-index (last-index-of #\/ filename)))
    (cond
      ((or (not dot-index)
	   (and dot-index
		slash-index
		(> slash-index dot-index)))
       "")
      (else
       (substring filename dot-index (string-length filename))))))

(define (scheme-file? filename)
  (member (file-extension filename) '(".scm" ".ss")))


