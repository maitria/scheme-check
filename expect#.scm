(namespace 
  ("expect#"
   add-expectation
   run-expectations))

(##define-syntax expect
  (lambda (spec)
    (let* ((test-expression (cadr (##source-code spec)))
	   (source-locat (##source-locat test-expression))
	   (source (##source-code test-expression))
	   (reporter-symbol (gensym)))
      `(add-expectation (cons ',source-locat (lambda (,reporter-symbol)
					       (with-exception-catcher
						 (lambda (e)
						   (,reporter-symbol 'error e))
						 (lambda ()
						   (if ,source
						     (,reporter-symbol 'pass #f)
						     (,reporter-symbol 'fail #f))))))))))

