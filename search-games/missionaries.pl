%%% Search game: missionaries and cannibals
% https://en.wikipedia.org/wiki/Missionaries_and_cannibals_problem#:~:text=In%20the%20missionaries%20and%20cannibals,were%2C%20the%20cannibals%20would%20eat
% Missionaries cannot be outnumbered by cannibals
% Boat has 2 person maximum capacity

% (*) State Representation: t(M, C, B)
% M: number of missionaries in the start shore
% C: number of cannibals in the start shore
% B: position of the boat, {-1, 1}

% So, to check whether a state corresponds to a solution: 
is_solution(t(0, 0, 1)). % boat in pos1, no people in start-shore

no_loop(NewState, AccTrace):-
    not(member(Newstate, AccTrace)).

% (a) Boat moves from start-shore to end-shore
try_action(t(M, C, -1), t(NewM, NewC, 1)):-
    cross_start_to_end(M, C, 2, NewM, NewC), % either 2 people cross
    cross_start_to_end(M, C, 1, NewM, NewC), % or only 1 person crosses

% (b) Boat moves from end-shore to start-shore
try_action(t(M, C, 1), t(NewM, NewC, -1)):-
    cross_end_to_start(M, C, 2, NewM, NewC), % either 2 people cross
    cross_end_to_start(M, C, 1, NewM, NewC). % or only 1 person crosses

%% Aux: cross_start_to_end/5 and cross_end_to_start/5
% M, C: number of people in the start-shore
% N: number of people still allowed in the boat
% NewM, NewC: number of people in the start-shore if the people in the boat cross

cross_start_to_end(M, C, 0, M, C):- !. % base case

cross_start_to_end(M, C, N, NewM, NewC):-
    M2 is M - 1, % let a missionary in the boat
    M2 >= 0,
    N1 is N - 1,
    cross_start_to_end(M2, C, N1, NewM, NewC).

cross_start_to_end(M, C, N, NewM, NewC):-
    C2 is C - 1, % let a cannibal in the boat
    C2 >= 0,
    N1 is N - 1,
    cross_start_to_end(M, C2, N1, NewM, NewC).

cross_end_to_start(M, C, 0, M, C):- !. % base case

cross_end_to_start(M, C, N, NewM, NewC):-
    M2 is M + 1, % let a missionary cross
    M2 =< 3,
    N1 is N - 1,
    cross_end_to_start(M2, C, N1, NewM, NewC).

cross_end_to_start(M, C, N, NewM, NewC):-
    C2 is C + 1, % let a cannibal cross
    C2 =< 3,
    N1 is N - 1,
    cross_end_to_start(M, C2, N1, NewM, NewC).

% Validate the state: validate_state/1
validate_state(t(M, C, _)):-
    OtherM is 3 - M, % missionaries in end-shore
    OtherC is 3 - C, % cannibals in end-shore
    nobody_eaten(M, C), % start-shore
    nobody_eaten(OtherM, OtherC). % end-shore

% Aux: nobody_eaten/2 to check validity
nobody_eaten(0, _). % base case: no missionaries in start-shore
nobody_eaten(M, C):-
    C =< M. % less cannibals than missionaries
