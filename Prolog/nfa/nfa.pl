% check if reach input end with list SS
reachable_check(SS, FS, []) :- 
    member(FS,SS).

% chekc if reach with initial [] input
reachable_check(SS, FS, []) :-
    SS = FS.

% SS is a list 
reachable_check([SSH|SST], FS, I) :- 
    I = [IH|IT],
    transition(SSH,IH,NS),     % use SSH and IH to get NS
    reachable_check(NS,FS,IT). % do nfa with head on SS

reachable_check(SS, FS, I) ;-
    SS = [SSH|SST],
    reachable_check(SST,FS,I). % pass the rest of SS to next round


% SS is a single state (Start)
reachable_check(SS,FS,[IH|IT]) :-
    transition(SS,IH,NS),
    reachable_check(NS,FS,IT).


reachable(StartState, FinalState, Input) :-
    reachable_check(StartState,FinalState,Input).
