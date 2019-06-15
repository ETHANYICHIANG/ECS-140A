(defun adder (l1 l2)
    (mapcar #'+ l1 l2)
)

(defun matrix-add (m1 m2)
   (mapcar #'adder  m1 m2)
)

(defun multiplyer (a b)
    ;(mapcar #'* firlist seclist)
    (print "im mulitplyer")
    (print a)
    (print b)
    ;(print seclist)
    ;(apply '+ (mapcar #'(lambda (a-el)(mapcar #'(lambda (b-el)(print b-el)) b)) a))
    ;(mapcar #'(lambda (b-el)(apply '+ (mapcar #'* a b))) b)
    (mapcar #'(lambda (b-el)(apply '+ (mapcar #'* a b-el))) b)

)

(defun len (a)
  (apply '+ (mapcar (lambda (n) 1) a))
)

(defun matrix-multiply (a b)
    ;;(print "in multi")
    ;;(print (len a))
    ;(setq bdu (make-du-lst (list b) (len a) b))
    ;(print bdu)
    (setq tranb (matrix-transpose b))
    (mapcar #'(lambda (a-el) (multiplyer a-el tranb)) a)
)


(defun app (a b)
    (cond ((null a) b)
          ( t  (cons (car a) 
                    (app (cdr a) b))   )
    )
)

(defun transposer (m)
    
)

(defun matrix-transpose (m)
    (cond 
        ((null (cdr m)) 
            (mapcar #'list (car m))
        )
        ((not (null (cdr m)))
           (apply #'mapcar #'list m)
        )
    )
)

