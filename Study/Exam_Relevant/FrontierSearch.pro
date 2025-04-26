% FRONTIER SEARCH - AN A* IMPLEMETATION IN PROLOG
% In this implementation it is assumed that predicates arc/2 and add2frontier/3 are predefined elsewhere.
% arc/2 validates if a transition can be made between Node and Next
% add2frontier/3 builds up the frontier by adding some node's Children.
% Children are found by the findall/3 predicate in the recursive case of frontierSearch/1.
% findall/3 takes the Next arcs from Node and accumulates these into a list named Children.

search(Node) :- frontierSearch([Node]).

% BASE CASE - REST OF INPUT SYMBOLS DON'T MATTER IF THE CURRENT NODE IS THE GOAL NODE
frontierSearch([Node|_]):- goal(Node).

% RECURSIVE CASE - PROCESS THE INPUT SYMBOLS
frontierSearch([Node|Input]):-
    findall(Next, arc(Node,Next), Children),
    add2frontier(Children, Input, NewFrontier),
    frontierSearch(NewFrontier).

% Notes:
% The input string is required in the recursive case
% The Children and the Input string make up the NewFrontier