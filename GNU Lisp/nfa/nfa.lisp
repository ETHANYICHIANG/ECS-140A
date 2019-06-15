(defun checkStates (start final)
  (print "in checkStates")
  (print start)
  (print final)
  (cond
    ((eq final start)
      (eval t)
    )
    ((not (eq final start))
      (eval nil)
    )
  )
)

(defun doNFAForAll (transition startls final input)
  (cond 
    ((not (null startls))
      doNFA(transition (car startls) final input)
    )
  )
)

(defun doNFA (transition startls final input)
  (print "doNFA called")
  (print input)
  (cond 
      ((null input) ;; if end of input check if reach final 
        (print "calling checkState")
        (print startls)
        (print final)
        ;;(cond 
        ;;  ((null (cdr startls)) ;; single end state
        ;;    (checkStates startls final)
        ;  )
        ;  ((not (null (cdr startls))) ;; with multi end
        ;    (car (mapcar #'(lambda (start) (checkStates start final)) startls))
        ;  )
        ;)
        (car (mapcar #'(lambda (start) (checkStates start final)) startls))
      )
      ((not (null input));; not end of input and still more start states
        (print "in doNFA - not null input")
        ;;(print "going to get states")
        (setq newS (funcall transition (car startls) (car input))) ;; list of next state
        (print "set newS")
        (print newS)
        ;; for each new states run DFA with (crd input)
        (car (mapcar #'(lambda (state) (doNFA transition (list state) final (cdr input))) newS))
      )
    )
)

(defun reachable (transition start final input)
  (print "case ")
  (print input)
  (cond 
      ((null input) ;;check for nil input list
        (cond 
          ((eq start final) 
            (eval t)
          )
          ((not (eq start final)) 
            (eval nil)
          )
        )
      )
      ((not (null input)) ;; do first transition to get start as list
        (setq newS (funcall transition start (car input)))
        (doNFA transition newS final (cdr input))
      )
    )
)
