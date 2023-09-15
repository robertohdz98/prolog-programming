%%% Exercise KU Leuven: Programming Methods & Programming Methodologies

% Consider the following puzzle. Take the 12 numbers on the face of a clock (1...12). 
% Rearrange the numbers (keeping them in a circle) in such a way that no triplet of adjacent numbers sums more than 21.
% Goal: predicate clock_round (N, Sum, Xs) that can solve the above puzzle and related ones. 
% For the above puzzle the call is ?- clock round (12, 21, Xs). It finds a lot of solutions for Xs (e.g. [12,2,6,11,4,5,9,7,3,10,8, 1], [12,2,7,9,5,4,11,6,3,10,8,1], ..., and [12,7,2,11,6,4,10,5,3,9,8,1]).
% If you take the numbers 1 up to 5, the call ?- clock round (5, 10, Xs) finds (5,2,3,4,1] and [5,3,2,4,1] as solutions for Xs. 
% Note that all rotations of (5,2,3,4,1] are also valid solutions e.g [2,3,4,1,5], [3,4,1,5,2], ..., as is [5,1,4,3,2] 
% (when you read the numbers anti-clockwise) and its rotations. Note also that [5,2,3,1,4] is not a solution, because 4+5+2 is larger than 10.

% Goal 1: clock_round/3 that solves the puzzles
% Goal 2: try to avoid solutions that are just variants (e.g. the rotations and the anti-clockwise readings)

% Using CLP(FD): Constraint Logic Programming
clock_round(N, Sum, Xs):-
    length(Xs, N),
    Xs ins 1..N,
    all_different(Xs),
    nth_element(1, Xs, V1),
    nth_element(2, Xs, V2),
    nth_element(N, Xs, VL),
    N1 is N - 1,
    nth_element(N1, Xs, VBF),
    VL + V1 + V2 #=< Sum,
    VBL + VL + V1 #=< Sum,
    checksums(Xs, Sum),
    labeling([], Xs).

% Aux: nth_element/3
nth_element(1, [H|_], H).
nth_element(N, [_|T], E):-
    N > 1, 
    N1 is N - 1,
    nth_element(N1, T, E).

% Aux: checksums/2
checksums([X, Y, Z]|[], Sum):-
    X + Y + Z #=< Sum.
checksums([X, Y, Z, D|T], Sum):-
    X + Y + Z #=< Sum,
    checksums([Y, Z, D|T], Sum).
    
