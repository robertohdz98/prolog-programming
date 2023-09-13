%%% GRAPHS %%%

% arc(From, To, Graph)
arc(From, To, Graph):-
    member(From/To, Graph).

% connected(X, Y, Graph): could cause inf loops if cyclic graph 
connected(X, X, _).
connected(X, Y, Graph):-
    arc(Z, Y, Graph),
    connected(X, Z, Graph). % viceversa = infinite loops

% find_path(X, Y, Graph, Path): could cause inf loops if cyclic graph
find_path(X, Y, Graph, Path):-
    find_path_acc(X, Y, Path, [Y], Graph).

find_path_acc(X, X, Path, Path, _).
find_path_acc(X, Y, Path, Acc, G):-
    arc(Z, Y, G),
    find_path_acc(X, Z, Path, [Z|Acc], G).

% alternative for find_path
find_path_2(X, Y, Path, Graph):-
    find_path_acc_2(X, Y, Path, [Y], Graph).

find_path_acc_2(X, X, Path, Path, _).
find_path_acc_2(X, Y, Path, Acc, G):-
    arc(Z, Y, G),
    not(member(Z, Acc)), % difference: do not go into node if already visited
    find_path_acc_2(X, Z, Path, [Z|Acc], G).

connected_2(X, Y, Graph):-
    find_path_2(X, Y, _, Graph).

% Undirected graphs
arc(From, To, Graph):-
    member(From/To, Graph).
arc(From, To, Graph):-
    member(To/From, Graph).

% NOTE: To create undirected graphs, 
% predicate "edge(X, Y):- edge(Y, X)." will cause loops
% Instead, must define new predicate:
edge(X, Y):- link(X, Y); link(Y, X).