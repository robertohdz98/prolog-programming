%%% Search game: Knight's Tour
% https://en.wikipedia.org/wiki/Knight%27s_tour

%(*) State Representation: st(X, Y) being X = posX, Y = posY

solve(InitialState, Path):-
    search(InitialState, [InitialState], Path).

search(_CurrentState, Path, Path):-
    is_solution(Path). % if Path is the solution, Acc = Path

search(CurrentState, VisitedStates, Path):-
    try_action(CurrentState, NextState), %(*) Heuristics (at the end)
    no_loop(NextState, VisitedStates),
    validate_state(NextState),
    search(NextState, [NextState|VisitedStates], Path).

% (*) Check solution: is_solution/1
size(8). 

is_solution(Path):-
    size(Size),
    SizeSquare is Size ** 2,
    length(Path, SizeSquare), % check if all states are visited
    noloops(Path).

noloops([]).
noloops([HSt|TSt]):-
    \+ member(HSt, TSt),
    noloops(TSt).

% Aux: try_action/2: (a) write all 8 options with OR, (b) use sign predicate
% (a) 8 possible movements (X+1,Y+2), (X-1,Y+2), (X+2,Y+1), (X-2,Y+1), same w/ Y-1 and Y-2
try_action(st(X, Y), st(NewX, NewY)):-
    sign(SignX),
    sign(SignY),
    (NewY is Y + SignY * 2, NewX is X + SignX * 1
        ; % OR
    NewY is Y + SignY * 1, NewX is X + SignX * 2).

% Aux aux: sign/1
sign(-1).
sign(1).

% Aux: validate_state/1
validate_state(st(X, Y)):-
    1 =< X, X =< Size,
    1 =< Y, Y =< Size.



% (*) Appendix: Add Heuristics
try_action_heuristic(CurrentState, VisitedStates, NextState):-
    findall(Heur/NewState, % find all possible next steps
            (try_action(CurrentState, NextState),
            compute_heuristics(NextState, VisitedStates, Heur)),
            NewPossStates),
    sort(NewPossStates, SortedStates), % smaller heuristic first
    member(_/NewState, SortedStates). % try out the smallest first

% Aux: compute_heuristics/3
compute_heuristics(Pos, Visited, Heur):-
    findall(Pos2,
            reachable_unvisited(Pos, Visited, Pos2),
            Unvisited), % unvisited options
    length(Unvisited, Heur).

% Aux aux: reachable_unvisited/3
reachable_unvisited(Pos, Visited, Pos2):-
    try_action(Pos, Pos2),
    validate_state(Pos2),
    \+ member(Pos2, Visited).