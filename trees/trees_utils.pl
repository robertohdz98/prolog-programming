%%% Some useful predicates for trees

% count/2: count elements in tree
count(nil, 0).
count(t(L, _X, R), Elements):-
    count(L, El1),
    count(R, El2),
    Elements is El1 + El2 + 1.

% depth/2: extract depth of tree
depth(nil, 0).
depth(t(L, _X, R), Depth):-
    depth(L, DepthL),
    depth(R, DepthR),
    max(DepthL, DepthR, MaxDepth),
    Depth is MaxDepth + 1.

% linearize/2: convert tree to list
lin(nil, []).
lin(t(L, Value, R), List):-
    lin(L, LeftList),
    lin(R, RightList),
    append(LeftList, [Value|RightList], List). %% or...

lin2(t(L, X, R), [X|Rest]):-
    lin2(L, Rest1),
    lin2(R, Rest2),
    append(Rest1, Rest2, Rest).

% close/1: close a tree
close(nil).
close(t(L, _Val, R)):-
    close(L),
    close(R).



