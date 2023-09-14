%%% Basic sudoku solver

% 1. Generate and test
% 2. Representation of sudoku: list of 81 numbers (1...9 in row1, 10...18 in row2, etc.)

% 3. Solve solution given
solve(Solution):-
    generate(Solution),
    test(Solution),
    write(Solution).

%%% Generate solution
generate([]).
generate([H|T]):-
    member(H, [1, 2, 3, 4, 5, 6, 7, 8, 9]) %using member/2
    generate(T).

% Aux: member function analogous to member/2
member2(X, [X|_T]).
member2(X, [_H|T]):-
    member2(X, T).

%%% Test solution
test(Solution):-
    test_constraints([r1, r2, r3, r4, r5, r6, r7, r8, r9], Solution), %test rows
    test_constraints([c1, c2, c3, c4, c5, c6, c7, c8, c9], Solution), %test columns
    test_constraints([b1, b2, b3, b4, b5, b6, b7, b8, b9], Solution). %test blocks

% Aux: test constraints (testing group of 9 positions)
test_constraints([], _, Solution).
test_constraints([HConstID|TConstID], Solution):- % first check 1st row/column/block
    group(HConstID, ListPositions), % get involved positions (*)
    get_values(ListPositions, Solution, Values), % get values at those positions
    all_different(Values), % check they are different
    test_constraints(TConstID, Solution).

% (*) For this, define Facts where named rows/columns/blocks identifiers are 
% linked with their indices in list (do this for r1-r9, c1-c9, b1-b9)
group(r1, [1, 2, 3, 4, 5, 6, 7, 8, 9]) 
group(c1, [1, 10, 19, 28, 37, ...]) 

% Aux aux: get_values
get_values([], _, []).
get_values([HPos|TPos], Solution, [Val|TVal]):-
    nth_element(HPos, Solution, Val), % get value at HPos
    get_values(TPos, Solution, TVal).

% Aux aux: all_different
all_different([]).
all_different([H|T]):-
    not(member(H, T)), % H should not appear in T again
    all_different(T).

% Aux aux aux: nth element
nth_element(Pos, [H|_T], H):-
    Pos = 1, !.
nth_element(Pos, [_H|T], Val):-
    Pos > 1,
    Pos1 is Pos - 1,
    nth_element(Pos1, T, Val).