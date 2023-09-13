%%% Sorting a list of elements

% Non-recursive version
quicksort([], []).
quicksort([X|Tail], Sorted):-
    split(X, Tail, Small, Big),
    quicksort(Small, SortedSmall), %first small
    quicksort(Big, SortedBig),
    conc(SortedSmall, [X|SortedBig], Sorted).

split(X, [], [], []).
split(X, [Y|Tail], [Y|Small], Big):-
    gt(X, Y), !,
    split(X, Tail, Small, Big).
split(X, [Y|Tail], Small, [Y|Big]):-
    split(X, Tail, Small, Big).

% Recursive version
quicksortt(List, Sorted):-
    quicksort_acc(List, [], Sorted). %*

quicksort_acc([], Sorted, Sorted).
quicksort_acc([X|Tail], Acc, Sorted):-
    split(X, Tail, Small, Big),
    quicksort_acc(Big, Acc, NewAcc), %first big
    quicksort_acc(Small, [X|NewAcc], Sorted).

% quicksort_acc(List, Acc, Sorted) explanation:
% Acc is sorted list of elements larger than (or equal) to the elements in List
% Sorted is a list starting with the sorted elements of List, followed by the elements from Acc