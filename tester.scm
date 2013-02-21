
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

(write (files-in-directory "."))

