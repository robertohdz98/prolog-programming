%%% Revert a list

% Non-recursive version (no accumulator)
reverse([], []).
reverse([H|T], Reversed):-
    reverse(T, TailReversed),
    append(TailReversed, [H], Reversed).

% Recursive version (accumulator)
reverse(List, Reversed):-
    reverse_acc(List, Reversed, []).

reverse_acc([], Result, Result).
reverse_acc([H|T], Result, Acc):-
    reverse_acc(T, Result, [H|Acc]).