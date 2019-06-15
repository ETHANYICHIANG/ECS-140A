   
    
    (cond 
      ((eq '! (car pattern)) ;; pattern is !
         (cond
            ((eq '! (cdr pattern))
               (checkMatch (cdr pattern) (cdr assertion) t)
            )
            ((not (eq (car (cdr assertion)) (car (cdr pattern)))) ;; ! not end
               (checkMatch pattern (cdr assertion) t)
            )
            ((eq (car (cdr assertion)) (car (cdr pattern))) ;; ! end reset isE
               (checkMatch (cdr pattern) (cdr assertion) nil)
            )
         )
      )
      ((not (eq (car pattern) (car assertion))) ;; miss match return nil
         (eval nil)
      )
   )
  
    
    
    
    
   