%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% CLASSIFICATION PROBLEM %%%%%%%%
%%% 125 training instances: wine bottles (13 descriptive attr + class of farmer 1/2/3)
%%% 39 test instances to classify using KNN
% testdata(number, descriptive attributes)
% testdata_class(number, class) > to check predictions

% Aux: distances
% a) Manhattan distance
manhattan_dist(List1, List2, Distance):-
    manhattan_acc(List1, List2, 0, Distance).

manhattan_acc([], [], Distance, Distance).
manhattan_acc([H1|T1], [H2|T2], Acc, Distance):-
    NewAcc is Acc + abs(H1 - H2),
    manhattan_acc(T1, T2, NewAcc, Distance).

% b) Euclidean distance
euclidean_dist(List1, List2, Distance):-
    euclidean_acc(List1, List2, 0, Distance).

euclidean_acc([], [], Distance, Distance).
euclidean_acc([H1|T1], [H2|T2], Acc, Distance):-
    NewAcc is Acc + (H1 - H2)**2,
    euclidean_acc(T1, T2, NewAcc, Distance).

%%%% Generic strategy: 5-KNN
% 1. Compute distance with each bottle in the training set
% 2. Sort distances
% 3. Take pairs with 5 shortest distances (5 most similar instances)
% 4. Get majority class label of these 5 bottles

% Main: classify bottle
classify(BottleList1, PredictedFarmer):-
    findall(Distance/Farmer, %list of (Distance/Farmer) pairs
            (traindata(BottleList, Farmer),
            manhattan_dist(BottleList, BottleList1, Distance)),
            AllDistances),
    sort(AllDistances, SortedDistances),
    first_nelements(5, SortedDistances, FiveMostSimilar), 
    most_freq_class(FiveMostSimilar, PredictedFarmer).


% Aux: first_nelements
% 2 stop conditions: n_elements left to take is 0, or list to take elements is empty
first_nelements(0, _, []):- !.
first_nelements(_, [], []):- !.
first_nelements(N, [H|Tail], [Class|Tail1]):-
    H = _Distance/Class, %keep only the class label
    N1 is N - 1,
    first_nelements(N1, Tail, Tail1).

% Aux: get the majority class label (El being predicted farmer)
most_freq_class(BottleListClasses, El):- 
    count_ocurrences(BottleListClasses, Counts),
    most_frequent(Counts, El).

% Aux aux: count_ocurrences(list of class labels, list of (class label, counts) pairs)
count_ocurrences(List, Counts):-
    count_acc(List, Counts, []).

count_acc([], Counts, Counts).
count_acc([H|T], Counts, Acc):-
    member((H, N), Acc), !, % count for that label already exists
    remove((H, N), Acc, Rest),
    N2 is N + 1,
    count_acc(T, Counts, [(H, N2)|Rest]).
count_acc([H|T], Counts, Acc):-
    count_acc(T, Counts, [(H, 1)|Rest]). %did not exist a count yet for that label

% Aux aux: most_frequent class label
most_frequent([(El, N)|Tail], MostFrequent):-
    most_frequent_acc(Tail, El, MostFrequent).

most_frequent_acc([], MostFrequent, _, MostFrequent): -!.
most_frequent_acc([(El, N)|Tail], _, TmpN, MostFrequent):-
    N > TmpN, !, % El is more freq (N times) than previously mostfreq label (TmpN times)
    most_frequent_acc(Tail, El, N, MostFrequent).
most_frequent_acc([_|Tail], TmpMostFrequent, TmpN MostFrequent):-
    most_frequent_acc(Tail, TmpMostFrequent, TmpN, MostFrequent).


%% Check prediction accuracy
compute_accuracy(Accuracy):-
    findall(BottleList / RealClass, 
            (testdata(BottleN, BottleList),
            testdata_class(BottleN, RealClass)),
            TestBottles),
    check_classifications(TestBottles, NbOfClassif, NbOfCorrectClassif),
    Accuracy is NbOfCorrectClassif / NbOfClassif.

% Aux: check classifications
check_classifications(TestBottles, N, NCorrect):-
    check_classifications_acc(TestBottles, 0, N, 0, NCorrect).

check_classifications_acc([], N, N, NCorrect, NCorrect).
check_classifications_acc([BottleList / RealClass | Tail], Acc, N, AccCorrect, NCorrect):-
    check_one_classif(BottleList, RealClass, Check),
    NewAccCorrect is AccCorrect + Check,
    NewAcc is Acc + 1,
    check_classifications_acc(Tail, NewAcc, N, NewAccCorrect, NCorrect).

% Aux aux: check one classification
check_one_classif(BottleList, RealClass, Check):-
    classify(BottleList, PredictedClass),
    (PredictedClass = RealClass -> Check is 1; Check is 0).