%%% Get duplicates in a list

% Recursive version using accumulator
get_doubles(List, Doubles):-
    % first []: elements that we have seen once before so far
    % second []: elements that we have seen twice or more before so far
    get_doubles_acc(List, Doubles, [], []).

get_doubles_acc([], Doubles, _, Doubles). %base case

% Different cases (analogous to "if" clause)
get_doubles_acc([E|Tail], Result, Singles, Doubles):-
    % we have seen the element E twice (or more) before
    member(E, Doubles), !,
    get_doubles_acc(Tail, Result, Singles, Doubles).

get_doubles_acc([E|Tail], Result, Singles, Doubles):-
    % we have seen the element E once before
    member(E, singles), remove(E, Singles, NewSingles), !,
    get_doubles_acc(Tail, Result, NewSingles, [E|Doubles]).

get_doubles_acc([E|Tail], Result, Singles, Doubles):-
    % we have not seen the element E before
    get_doubles_acc(Tail, Result, [E|Singles], Doubles).