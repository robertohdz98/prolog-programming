%%% Exercise KU Leuven: Programming Methods & Programming Methodologies

% A single-elimination badminton tournament is organised with n players (where n is a power of 2). 
% Players are numbered from 1 to n. For each potential match between 2 players you know who would win the match. 
% The relation is not necessarily transitive: it may be the case that n1 beats n2, n2 beats n3, and n3 beats n1. 
% There are n! (m factorial) ways to assign the players to the starting positions in the tournament. 
% Different assignments may produce a different winner of the tournament.

% 1) For a given n, represent the information about who beats who?
beats(W, ListofLosersVSW).
% Represent that 1 beats 2,3,4,5, and 6 but is beaten by 7 and 8.
beats(1, [2, 3, 4, 5, 6]).
beats(7, [1]).
beats(8, [1]).

% 2) Represent an initial sequence of n players (any permutation of numbers 1,2,...,(n-1), is a valid starting sequence)
SequenceOfParticipants=[P1, P2, P3, P4...] % e.g.: [1, 3, 4, 7, 8, 2, 6, 5]

% 3) Predicate "onematch" that for a given sequence of players determines the players that go to the next round 
% (taking into account the given information about who beats who). Note that there is a match between 1st and 2nd player in the sequence, and a match between 3rd and 4th, and ...
onematch([], []).
onematch([X, Y|T], [W1|RestWinners]):-
    wins(X, Y, W1),
    onematch(T, RestWinners).

wins(X, Y, X):-
    beats(X, ListOfLosers),
    member(Y, ListOfLosers).
wins(X, Y, Y):-
    beats(Y, ListOfLosers),
    member(X, ListOfLosers).
wins(X, _, X).

% 4) Predicate "tournament" that for a given initial sequence of n players determines the winner of the tournament
tournament([Participant], Participant). % when only 1 player is left in participants list
tournament(Participants, Winners):-
    onematch(Participants, NextRound),
    tournament(NextRound, Winners).

% 5) Predicate "numberwins" that determines for a given player in how many initial sequences that player wins the tournament
% Find all possible sequences with the participants we have, and then take the ones where Player wins
numberwins(Participants, Player, NbWins):-
    findall(Sequence,
            (player_sequence(Participants, Seq),
            tournament(Seq, Player)),
            Tournaments),
    length(Tournaments, NbWins).

% :-use_module(library(clpfd))
player_sequence(Participants, Sequence):-
    length(Participants, N),
    length(Sequence, N),
    all_different(Sequence),
    Sequence ins 1..N,
    labeling([], Sequence).
    
