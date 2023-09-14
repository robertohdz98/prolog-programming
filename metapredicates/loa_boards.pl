%%% Checking for valid LOA boards
% Board: list of lists [[r1,r2,r3...], [...]]
% LOA board: valid if square 8-width & if every position is o/w/b

validboard(B):-
    length(B, 8),
    validRows(B).

% Aux: check rows validity
validRows([]). %base case
validRows([R|Tail]):-
    length(R, 8),
    allmember(R, [b, w, o]),
    validRows(Tail).

% Aux aux: allmember
allmember([], _).
allmember([H|T], List):-
    member(H, List),
    allmember(T, List).

% Aux aux aux: check if it is member of list
member(X, [X|_]).
member(X, [_|T]):-
    member(X, T).