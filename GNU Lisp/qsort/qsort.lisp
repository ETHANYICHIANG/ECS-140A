(defun app (a b)
    (cond ((null a) b)
          ( t  (cons (car a) 
                    (app (cdr a) b))   )
    )
)

(defun doPivot (n xs sxs lxs)
  (cond 
    ((null xs) (list sxs lxs));; to end of list return smaller-than list and larger-than list
    ((> (car xs) n)
      (doPivot n (cdr xs) sxs (app lxs (list (car xs))))
    )
    ((= (car xs) n)
      (doPivot n (cdr xs) sxs (app lxs (list (car xs))))
    )
    ((< (car xs) n)
      (doPivot n (cdr xs) (app sxs (list (car xs))) lxs)
    )
  )
)


(defun pivot (n xs)
  (doPivot n xs nil nil)
)

(defun len (l)
  (if (null l) 0 
       (+ 1 (len (cdr l))))
)

;;base case 1 orcd 2 item in xs
(defun doQsort (xs sf)
  (print "do qsort")
  (print xs)
  (cond 
    ((or (null xs) (= (len xs) 1)) 
    (print "base")
      xs
    ) ;; base case 1 item or nil
    ((or (> (len xs) 2) (= (len xs) 2))
      (print "calling pivot")
      (cond
        ((sf)
          (print "sf")
          (setq pr (pivot (car (cdr xs)) xs)) ;; split list
        )
        ((not sf)
          (setq pr (pivot (car xs) xs)) ;; split list
        )
      )
      
      (print "checking if all larger")
      (cond 
        ((= (len (cdr pr)) (len xs))
          (print "reset pivot")
          (doQsort pr t)
        )
      )
      (setq prl (doQsort (cdr pr) nil))
      (setq prs (doQsort (car pr) nil))
      (print pr)
      (print prs)
      (print prl)
      (app prs (car prl))

      ;(cond 
        ;((null prs) ;; prl is empy
        ;  (eval prl)
        ;)
        ;((and (not (null prs)) (> (len prl) 1))
        ;  (car (mapcar #'(lambda (a) (app prs (list a))) prl))
        ;)
        ;(((= 1 (len prl))))
        ;  (app )
        ;)
      ;)
    )
  )
)

;;base case nil xs
(defun quicksort (xs)
  (cond 
    ((null xs) nil)
    ((not (null xs)) 
      (doQsort xs nil)
    )
  )
)
