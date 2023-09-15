%%% Search game: water jugs
% 2 water bowls with 15L and 16L each
% Goal: extract exactly 8L

%% (*) State Representation: J1/J2 (number of liters in jug1/jug2) settings
required_liters(8).
max_liters_1(15).
max_liters_2(16).
%% (*) Solution found when required number of liters in J1 or J2
is_solution(J1/_):- required_liters(J1).
is_solution(_/J2):- required_liters(J2).


iterative_deepening(InitialState, Trace):-
    natural(DepthLim),
    solve_depthlim(InitialState, DepthLim, Trace),
    write('Number of steps:'),
    write(DepthLim), nl.

% Aux: natural/1
natural(1).
natural(N):-
    natural(N1),
    N is N1 + 1.

% Aux: solve_depthlim/3
solve_depthlim(InitialState, DepthLim, Trace):-
    search_depthlim(InitialState, DepthLim, [InitialState], Trace).

% Aux aux: search_depthlim/4
search_depthlim(CurrentState, _, Trace, Trace):-
    is_solution(CurrentState).

search_depthlim(CurrentState, StepsLeft, AccTrace, Trace):-
    StepsLeft > 0,
    try_action(CurrentState, NewState), % (*)
    % validate_state(NewState): not needed since only valid states are generated
    no_loop(NewState, AccTrace),
    NewStepsLeft is StepsLeft - 1,
    search_depthlim(NewState, NewStepsLeft, [NewState|AccTrace], Trace).

% Aux aux aux: try_action/2 
% Empty jug1 and jug2 action
try_action(_/J2, 0/J2).
try_action(J1/_, J1/0).
% Completely fill jug1 and jug2 action
try_action(_/J2, M1/J2):- max_liters_1(M1).
try_action(J1/_, J1/M2):- max_liters_2(M2).
% Empty jug1 in jug2 as far as possible action
try_action(J1/J2, NewJ1/NewJ2):-
    max_liters_2(M2),
    NewJ2 is min(J2 + J1, M2),
    NewJ1 is max(0, J1 - (M2 - J2)).
% Empty jug2 in jug1 as far as possible action
try_action(J1/J2, NewJ1/NewJ2):-
    max_liters_1(M1),
    NewJ1 is min(J1 + J2, M1),
    NewJ2 is max(0, J2 - (M1 - J1)).
    


