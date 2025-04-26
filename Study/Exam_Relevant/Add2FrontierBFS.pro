% An implementation of the add2frontier/3 predicate which expands the frontier by appending the Children to the end of the frontier
% This is a FIFO implementation which implements Frontier Search as BFS
% The input parameters to add2frontier/3 are (Children, Inputstring, NewFrontier)

% BASE CASE - If there is no more input string, the NewFrontier is simply the list of Children
add2frontier(Children, [], Children).

% RECURSIVE CASE - ADD THE HEAD OF THE INPUT LIST AND RECUSRE BACK
add2frontier(Children, [InputStringHead | InputStringTail], [InputStringHead | BuildFrontier]) :-
    add2frontier(Children, InputStringTail, BuildFrontier).

% Notes:
% The recursion of add2frontier takes in the same Children list, with the tail of the input list.
% The recusrion has the head of the input list added to the built-up frontier