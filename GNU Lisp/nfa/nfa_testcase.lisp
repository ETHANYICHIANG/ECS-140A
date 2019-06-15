
    
    
    (assert-equal T (reachable 'fooTransitions 0 0 '( )))
    (assert-equal NIL (reachable 'fooTransitions 0 3 '(A A)))
    (assert-equal NIL (reachable 'fooTransitions 0 3 '(A)))
    (assert-equal NIL (reachable 'fooTransitions 0 1 '(B)))
    (assert-equal NIL (reachable 'fooTransitions 0 0 '(B)))


    (assert-equal T (reachable 'expTransitions 0 0 '(A B)))
    (assert-equal T (reachable 'expTransitions 0 2 '(A B A)))
    (assert-equal T (reachable 'expTransitions 0 2 '(A B A B A)))
    (assert-equal NIL (reachable 'expTransitions 0 0 '(A A)))
    (assert-equal NIL (reachable 'expTransitions 0 2 '(A B A B)))

    (assert-equal T (reachable 'langTransitions 0 0 '(A B B)))
    (assert-equal T (reachable 'langTransitions 0 1'(A A B)))
    (assert-equal T (reachable 'langTransitions 0 0 '(A A A A A)))