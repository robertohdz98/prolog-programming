%%% Mixing products problem
% Using findall clause

calc_reaction(ListOfProducts, TotalReactionStrength):-
    findall(StrengthOfTwoProducts,
            (member(ProductA, ListOfProducts), 
            member(ProductB, ListOfProducts),
            reacts(ProductA, ProductB, StrengthOfTwoProducts)
            ),
            ReactionStrengthList),
    list_sum(ReactionStrengthList, TotalReactionStrength).

% Aux: sum of elements of list
list_sum(List, Sum):-
    list_sum_acc(List, 0, Sum).

list_sum_acc([], Sum, Sum).
list_sum_acc([H|T], Acc, Sum):-
    NewAcc is Acc + H,
    list_sum_acc(T, NewAcc, Sum).