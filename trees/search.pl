%%% Efficiently searching sorted lists

% occur/2: if X>H continue searching, else stop (assuming order)
occur(X, [X|_]).
occur(X, [H|T]):-
    X > H,
    occur(X, T).

% occurthree/2: if X>H continue searching, else stop and look back
occurthree(X, [_, _, X|_]).
occurthree(X, [_, _, H|Tail]):-
    X > H,
    occurthree(X, Tail).
occurthree(X, [X|_]). % look back at 1st element
occurthree(X, [_, X|_]). % look back at 2nd element