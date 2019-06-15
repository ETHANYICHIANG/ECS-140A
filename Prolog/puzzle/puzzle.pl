% state 
%state(left,left,left,left).
%state(left,left,left,right).
%state(left,left,right,left).
%state(left,left,right,right).
%state(left,right,left,left).
%state(left,right,left,right).
%state(left,right,right,left).
%state(left,right,right,right).
%state(right,left,left,left).
%state(right,left,left,right).
%state(right,left,right,left).
%state(right,left,right,right).
%state(right,right,left,left).
%state(right,right,left,right).
%state(right,right,right,left).
%state(right,right,right,right).


% opposite 
opposite(A,B) :- 
    not(A = B).

% unsafe 
unsafe(A) :- 
    unsafe_GC(A);unsafe_WG(A).


unsafe_WG(A) :-  % wolf and goat same bank
    A = state(F,W,G,C),
    opposite(F,W),
    G = W.

unsafe_GC(A) :-  % goat and cabbage same bank
    A = state(F,W,G,C), 
    opposite(F,G),
    G = C.

% safe 
safe(A) :- 
    not(unsafe(A)).

% take 
%take(farmer,left,right).
%take(farmer,right,left).
%take(wolf,left,right).
%take(wolf,right,left).
%take(goat,left,right).
%take(goat,right,left).
%take(cabbage,left,right).
%take(cabbage,right,left).

% all_takes(X) gives list of takes
all_takes([
    take(wolf,left,right),
    take(wolf,right,left),
    take(goat,left,right),
    take(goat,right,left),
    take(cabbage,left,right),
    take(cabbage,right,left),
    take(farmer,left,right),
    take(farmer,right,left)
]).


% arc for all 4 roles
arc(N,X,Y) :- 
    safe(Y),                % end state is safe
    N = take(Who,A,B),
    Who = farmer,
    X = state(F1,W,G,C),    % get start state
    A = F1,                 % check start state
    Y = state(B,W,G,C).     % create next state

arc(N,X,Y) :- 
    safe(Y),                % is Y (final state) safe?
    N = take(Who,A,B),
    Who = wolf,
    X = state(F1,W1,G,C),   % start state
    not(opposite(F1,W1)),   % farmer and object on same side
    A = W1,                 % check start state 
    %not(opposite(F2,W2)),
    
    Y = state(B,B,G,C).     % creat final state

arc(N,X,Y) :- 
    safe(Y),
    N = take(Who,A,B),
    Who = goat,
    X = state(F1,W,G1,C),
    not(opposite(F1,G1)),   
    A = G1,
    Y = state(B,W,B,C).

arc(N,X,Y) :- 
    safe(Y),
    N = take(Who,A,B),
    Who = cabbage,
    X = state(F1,W,G,C1),
    not(opposite(F1,C1)),   
    A = C1,
    Y = state(B,W,G,B).

% check if solved
is_solved(A,B) :- 
    A = state(F1,W1,G1,C1),
    B = state(F2,W2,G2,C2),
    F1 = F2,
    W1 = W2,
    G1 = G2,
    C1 = C2.


% try to solve puzzle, takes 2 states and list of takes



% first take is legal
solve_puzzle(A,GS,Ts) :-    
    not(is_solved(A,GS)),    % not solved
    Ts = [H|T],             % guess with first take
    arc(H,A,NS),            % take, cur state, next state
    solve_puzzle(NS,GS,Ts). % rest takes to try

% first take is illegal try the rest of takes
solve_puzzle(A,GS,Ts) :-    
    not(is_solved(A,GS)),    
    Ts = [H|T],             
    not(arc(H,A,NS)),       % first take no go
    solve_puzzle(NS,GS,T).  % try with the rest of the takes

% solved case
solve_puzzle(A,GS,Ts) :- 
    is_solved(A,GS).

% fail with not safe cases
set_fail() :- 
    fail.

% solve for .plt
solve(F1, W1, G1, C1, F2, W2, G2, C2) :-
    A = state(F1,W1,G1,C1),
    unsafe(A),
    set_fail().

solve(F1, W1, G1, C1, F2, W2, G2, C2) :-
    GS = state(F2,W2,G2,C2),    % GS = goal state
    unsafe(GS),
    set_fail().


solve(F1, W1, G1, C1, F2, W2, G2, C2) :-
    A = state(F1,W1,G1,C1),
    GS = state(F2,W2,G2,C2),    % GS = goal state
    safe(A),
    safe(GS),
    all_takes(Ts),              % list of takes
    solve_puzzle(A,GS,Ts).



