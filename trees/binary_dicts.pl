%%% Binary dictionaries
% Search the median of the ordered list,
% compare and decide which half we must look into

%%% 1. Naive version
sorted(nil).
sorted(t(Left, N, Right)):-
    smaller(Left, N), 
    sorted(Left),
    larger(Right, N),
    sorted(Right).

% Aux: smaller/2
smaller(nil, _).
smaller(t(Left, Node, Right), N):-
    N > Node,
    smaller(Left, N),
    smaller(Right, N).

% Aux: larger/2
larger(nil, _).
larger(t(Left, Node, Right), N):-
    Node > N,
    larger(Left, N),
    larger(Right, N).


%%% 2. More efficient version
sorted2(nil).
sorted2(t(Left, N, Right)):-
    smaller_sorted(Left, N),
    larger_sorted(Right, N).

% Aux: smaller_sorted/2
smaller_sorted(nil, _).
smaller_sorted(t(Left, Node, Right), N):-
    N > Node,
    smaller_sorted(Left, Node),
    between_sorted(Right, Node, N).

% Aux: larger_sorted/2
larger_sorted(nil, _).
larger_sorted(t(Left, Node, Right), N):-
    Node > N,
    between_sorted(Left, N, Node),
    larger_sorted(Right, Node).

% Aux: between_sorted/3
between_sorted(nil, _, _).
between_sorted(t(Left, N, Right), Low, High):-
    N > Low, High > N,
    between_sorted(Left, Low, N),
    between_sorted(Right, N, High).