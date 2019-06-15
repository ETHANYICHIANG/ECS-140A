%isUnion helper, consulted Tutorials Point India Private Limited
union([],[],[]).
union(L1,[],L1).
union(L1, [H2|T2],[H2|R]) :-
    not(member(H2,L1)), 
    union(L1,T2,R).
union(L1, [H2|T2],R) :-
    member(H2,L1), 
    union(L1,T2,R). 

isUnion(Set1,Set2,Union) :-
    union(Set1,Set2,Union).

% isIntersection helper, consulted Tutorials Point India Private Limited
inter([],_,[]).
inter([H1|T1],L,[H1|T2]) :-
    member(H1,L),
    inter(T1,L,T2).
inter([H1|T1],L,T2) :- 
    not(member(H1,L)),
    inter(T1,L,T2).

isIntersection(Set1,Set2,Intersection) :-
    inter(Set1,Set2,Intersection).

% isEqual helper
equal([],[]).
equal([H1|T1],L) :- 
    member(H1,L),
    equal(T1,L).
equal([],L).

isEqual(Set1,Set2) :-
    equal(Set1,Set2).


%powerSet helper, consulted VahidM on stackoverflow
generate(X,[Y],[[X| Y]]).

generate(X, [H|T], P) :-
    %S = [H| T],
    append([X], H, Temp),
    generate(X, T, R),
    append([Temp], R, P), !.

% base case
powerSet([], [[]]).


get_powerSet([H|T], P) :-
    %Set = [H| T],
    powerSet(T, PsT),
    generate(H, PsT, Ps),
    append(Ps, PsT, P), !.

powerSet(Set,PowerSet) :-
    get_powerSet(Set,PowerSet).