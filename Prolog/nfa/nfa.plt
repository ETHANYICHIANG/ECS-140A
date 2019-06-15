:- initialization main.

main :-
    consult(['transitions.pl', 'nfa.pl']),
    (show_coverage(run_tests) ; true),
    halt.
     
:- begin_tests(nfa).

test(nfa1, [nondet]) :- reachable(0, 2, [a]).

test(nfa2, [nondet]) :-  reachable(0, 2, [b]).

test(nfa9, [nondet]) :- reachable(0, 0, [a,b]).

test(nfa3, [nondet]) :-  reachable(0, 1, [a, b, a]).

test(nfa4, [fail]) :- reachable(0, 1, [a, b, a, b]).
       
test(nfa5, [nondet]) :- reachable(0, 2, [a, b, a]).

test(nfa6, [nondet]) :- reachable(0, 0, []).
test(nfa7, [nondet]) :- reachable(0, 2, [b]).
test(nfa8, [fail]) :- reachable(0, 1, [b]).

:- end_tests(nfa).
