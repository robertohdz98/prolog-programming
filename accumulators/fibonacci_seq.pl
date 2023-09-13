%%% Fibonacci sequence
% https://en.wikipedia.org/wiki/Fibonacci_sequence

% Non-recursive version
fib(1,1).
fib(2,1).
fib(N, F):-
    N > 2,
    N1 is N - 1,
    fib(N1, F1),
    N2 is N - 2,
    fib(N2, F2),
    F is F1 + F2.

% Recursive version
fibo(N, Fib):-
    % Args: step we are in, fib number to eventually compute, fibprevious, fibcurrent,
    % where we will return solution when recursion finishes
    fibo_acc(1, N, 0, 1, Fib).

fibo_acc(N, N, _, Result, Result). % base case
fib_oacc(Count, N, PreviousFib, CurrentFib, Result):-
    Count < N,
    NextCount is Count + 1,
    NextFib is CurrentFib + PreviousFib,
    fibo_acc(NextCount, N, CurrentFib, NextFib, Result).