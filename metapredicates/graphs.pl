%%% Graphs
% Find shortest path between two nodes of a graph

shortest_path(X, Y , Graph, ShortestPath):-
    findall(Path,
            (find_path_2(X, Y, Path, Graph)), % knowing arc/3, find_path/4, find_path_acc/4
            AllPaths), %list of lists with each possible path from X to Y
    AllPaths = [FirstPath | Rest],
    length(FirstPath, FirstPathLength),
    find_shortest_path(Rest, FirstPath, FirstPathLength, ShortestPath).

% Aux: find_shortest_path(PathsLeftToCheck, CurrBestPath, LengthCurrBestPath, ShortestPath)
find_shortest_path([], CurrBestPath, _, CurrBestPath). % base case

find_shortest_path([HPathsLeft|TPathsLeft], CurrBestPath, LengthCurrBestPath, ShortestPath):-
    length(HPathsLeft, LengthHPathsLeft),
    LengthHPathsLeft < LengthCurrBestPath, % recursive case 1
    find_shortest_path(TPathsLeft, HPathsLeft, LengthHPathsLeft, ShortestPath).

find_shortest_path([HPathsLeft|TPathsLeft], CurrBestPath, LengthCurrBestPath, ShortestPath):-
    length(HPathsLeft, LengthHPathsLeft),
    LengthHPathsLeft >= LengthCurrBestPath, % recursive case 2
    find_shortest_path(TPathsLeft, CurrBestPath, LengthCurrBestPath, ShortestPath).



% Add. Appendix: get list with each parent of node in a graph
allParents(Graph, Node, ParentList):-
    findall(Parent,
            member(Parent / Node, Graph),
            ParentList).