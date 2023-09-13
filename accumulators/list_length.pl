%%% Length of a list

% Non-recursive (no accumulator)
list_length([], 0).
list_length([H|T], L):-
    list_length(T, L1),
    L is L1 + 1.

% Recursive
list_length_(List, Result):-
    list_length_acc(List, 0, Result).

list_length_acc([], Result, Result). % base case
list_length_acc([_|T], Acc, Result):-
    Acc1 is Acc + 1,
    list_length_acc(T, Acc1, Result).