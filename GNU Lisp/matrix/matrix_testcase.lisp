 
  
    




 
(defun append
    (lambda args
        (let f ((ls '()) (args args))
            (if (null? args)
            ls
                (let g ((ls ls))
                    (if (null? ls)
                        (f (car args) (cdr args))
                    (cons (car ls) (g (cdr ls)))
                    )
                )
            )
        )
    )
)

(defun append-elt (lst elt)             
  (if (null lst)                         
    (list elt)                            
    (cons (car lst)                      
          (append-elt (cdr lst) elt))))  