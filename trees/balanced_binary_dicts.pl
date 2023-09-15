%%% Balanced binary dictionaries

% balanced/1
balanced(t(L, _, R)):-
    depth(L, DepthL),
    depth(R, DepthR),
    Dif is DepthL - DepthR,
    -1 =< Dif, Dif =< 1, % watch these 2 possible cases
    balanced(L),
    balanced(R).

% list_to_balanced/2: list to balanced tree
list_to_balanced([], nil).
list_to_balanced(List, t(Left, Middle, Right)):-
    length(List, N),
    N > 0,
    SplitPos is (N + 1) // 2, % integer division
    % split List at position SplitPos
    split_list(List, SplitPos, Part1, Middle, Part2), 
    list_to_balanced(Part1, Left),
    list_to_balanced(Part2, Right).

% Aux: split_list/5
split_list([H|T], 1, [], H, T).
split_list([H|T], SplitPos, [H|T1], El, L2):-
    SplitPos > 1,
    NextSplitPos is SplitPos - 1,
    split_list(T, NewSplitPos, T1, El, L2).
