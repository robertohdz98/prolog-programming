%%% Sudoku puzzles incrementally

% Gain efficiency: interleave Generate and Test steps (stepwise approach)
% Step through 81 positions, for each one:
% 1. Create a value
% 2. Test if current partial solution still satisfies constraints
% 3. Only 3 constraints have to be checked (row/column/block it belongs to)

solve(Sol):-
    Size is 9,
    N is Size ** 2, %9 by 9 sudoku
    stepwise(1, N, Sol),
    write(Sol).

% Aux: stepwise
stepwise(Pos, N, _):-
    Pos > N, !.

stepwise(Pos, N, Sol):-
    member(Val, [1, 2, 3, 4, 5, 6, 7, 8, 9]), % generate value between 1...9
    nth_element(Pos, Sol, Val), % assign it to the element at Pos in Sol
    test_stepwise(Pos, Sol), % test current (partially instantiated) solution
    Next is Pos + 1, % generate and test the rest
    stepwise(Next, N, Sol).

% Aux aux: test_stepwise (test row/column/block that contain Pos)
test_stepwise(Pos, Sol):-
    test_1D(Pos, [r1, r2, r3, r4, r5, r6, r7, r8, r9]),
    test_1D(Pos, [c1, c2, c3, c4, c5, c6, c7, c8, c9]),
    test_1D(Pos, [b1, b2, b3, b4, b5, b6, b7, b8, rb9]).

% Aux aux aux: test_1D
test_1D(Pos, GroupList, Sol):-
    group(Group, PositionList), % find group of positions (row/col/block)
    member(Pos, PositionList), % Pos is a position in that group
    member(Group, GroupList), % group is of the correct kind (row/col/block)
    get_values(PositionList, Sol, Values), % get the values at the positions
    all_different(Values). % check if these values are different

% Aux x4: get_values
get_values([], _, []).
get_values([Pos|T], Sol, ValList):-
    get_values(T, Sol, T2),
    nth_element(Pos, Sol, Val),
    (var(Val) -> 
        ValList = T2 % Val is not instantiated yet (do not include in ValList)
    ;
    ValList = [Val|T2] % Val is instantiated (include in ValList)
    ).
