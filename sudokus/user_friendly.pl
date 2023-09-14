%%% Easier to use sudoku (user friendly)

% Give each element in the list a triple: Row/Column/Number
% Ex.: [1/4/2]: 2 in 1st row, 4th column

solve(Given):-
    Size is 9,
    N is Size ** 2,
    init(Given, N, Sol),
    stepwise(1, N, Sol),
    write_pretty(Sol, 1, Size), nl.

% Aux: init
init(Given, N, Sol):-
    length(Sol, N), % create a list containing N non-instantiated variables
    fill_given(Given, Sol). % fill in the given values

% Aux aux: fill_given (instantiate the var at pos Row/Col as Value)
fill_given([], _).
fill_given([Row/Col/Value | RestGiven], Sol):-
    Pos is Col + (Row - 1) * 9, % get single pos in the entire sudoku
    nth_element(Pos, Sol, Value),
    fill_given(RestGiven, Sol).

% Aux: write_pretty
write_pretty([], _, _).
write_pretty([H|T], Pos, Size):-
    write(H),
    M is mod(Pos, Size),
    (M == 0 -> nl; write (' ')), % if Pos is multiple of Size, then write newline, otherwise a space
    Next is Pos + 1,
    write_pretty(T, Next, Size).


%%%% Appendix: last option for sudokus
% Chaos sudokus: lets make it more general by creating blocks
% Only must determine new fixed positions of the sudoku square of each new block
group(b1, [1, 2, 3, 4, 5, 6, 7, 8, 9]). 
group(b2, [10, 19, 20, 28, 37, 38, 46, 55, 56]).
% ...
group(b9, [68, 69, 70, 76, 77, 77, 78, 79, 80, 81]). 