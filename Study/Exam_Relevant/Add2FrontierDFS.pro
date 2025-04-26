% An implementation of the add2frontier/3 predicate which expands the frontier by appending the Children to the front of the frontier
% This is a LIFO implementation which implements Frontier Search as DFS
% The input parameters to add2frontier/3 are (Children, Inputstring, NewFrontier)

% BASE CASE - IF THERE ARE NO MORE CHILDREN TO BE ADDED, THE NEW FRONTIER IS JUST THE INPUT LIST
add2frontier([], InputList, InputList).

% RECURSIVE CASE
add2frontier([ChildrenHead | ChildrenTail], InputList, [ChildrenHead|BuildFrontier]):-
    add2frontier(ChildrenTail, InputList, BuildFrontier).

