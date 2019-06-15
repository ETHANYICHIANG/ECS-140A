year_1953_1996_novels(Book) :-
   novel(Book,1953); novel(Book,1996).

period_1800_1900_novels(Book) :-
    novel(Book,Y), Y >= 1800, Y =< 1900.

lotr_fans(Fan) :-
    fan(Fan,B), member(the_lord_of_the_rings, B).

%author_names
author_names(Author) :-
    author(Author, B1), % books by Author
    fan(chandler, B2),  % books Chandler is a fan of
    check_list(B1,B2).
   
%check if L1 is in L2
check_list([H|T],L) :- 
    member(H,L).
check_list([H|T],L) :- 
    not(member(H,L)),
    check_list(T,L).
%check_list([],_) :- fail.

%fans_names
fans_names(Fan) :-
    fan(Fan, B1),   %book is Fan likes
    author(brandon_sanderson,B2),
    check_list(B1,B2).

%mutual_novels helper 
is_fan_common(Fan1,Fan2,Book) :-
    fan(Fan1,B1),
    fan(Fan2,B2),
    member(Book,B1),
    member(Book,B2).

%mutual_novels
mutual_novels(Book) :-  
    is_fan_common(phoebe,ross,Book);
    is_fan_common(monica,ross,Book);
    is_fan_common(phoebe,monica,Book).
    

   
