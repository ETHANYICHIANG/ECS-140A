(defun getMin (xs minVal)
    (print "getMin called")
    (cond 
        ((null xs) ;; if at the end of list return min
            (+ minVal 0)
        ) 
        ((> minVal (car xs)) 
            (print "new min")
            (getMin (cdr xs) (car xs));; if new min found call getMin w/ new min
        )
        ((or (< minVal (car xs)) (= minVal (car xs)))
            (print "same min")
            (getMin (cdr xs) minVal) ;; no new min then call getMin with same min val
        )
    )
)

(defun getMax (xs maxVal)
    (print "getMax called")
;;      (car xs)
    (cond 
        ((null xs) 
            (print maxVal)
            (+ maxVal 0)
        )
        ((not (null xs))
            (cond 
                ((< maxVal (car xs)) 
                    (print "new max")
                    (getMax (cdr xs) (car xs));; if new max found call getMax w/ new max
                )
                ((or (> maxVal (car xs)) (= maxVal (car xs)))
                    (print "same max")
                    (getMax (cdr xs) maxVal)  ;; no new max then call getMax with same max val
                )
            )
        )
    )
)


(defun getMean (xs sum len)
    ;;(+ (car xs) sum len)
    (cond
        ((null xs)
            (/ sum len)
        )
        ((not (null xs))
            (setq newSum (+ sum (car xs)))
            (setq newLen (+ len 1))
            (setq newXs (cdr xs))
            (getMean newXs newSum newLen)
        )
    )
)


(defun min-mean-max (xs)

    ;;get length of list
    ;;(setq len getLen(xs))

    ;;call min max helper
    ;;set min or max to first element the call func on the rest of list 
    (setq minVal (getMin (cdr xs) (car xs)))
    (setq maxVal (getMax (cdr xs) (car xs)))
    (print "end")
    ;;(print maxVal)

    ;;mean
    (setq meanVal (getMean xs 0 0))

    ;;return list of min-mean-max
    (list minVal meanVal maxVal)

    ;;(list '(1 2 3))

)
