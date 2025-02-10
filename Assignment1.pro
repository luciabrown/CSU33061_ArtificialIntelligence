% 22336688 - Lucia Brown
% astar(+Node,?Path,?Cost,+KB) - mode indicators are only used for documentation, not in the actual predicate itself
% +: Input Argument - must already be instantiated when predicate is called
% ?: Input or Output Argument - can either be instantiated or uninstantiated, may return a value if uninstantiated

arc([H|T],Node,Cost,KB) :- 
    member([H|B],KB),   % Find a rule in the KB with head H and body B
    append(B,T,Node),   % Append B to the tail T to generate a new Node
    length(B,L),        % 
    Cost is 1+ L/(L+1). % Cost calculation, length of body B

heuristic(Node,H) :- length(Node,H).    % Heuristic of a node is the length of the node

goal([]).   % Goal state is reached when there are no more subgoals left

astar(Node, Path, Cost, KB) :-
    heuristic(Node, H),
    search([[Node, [], 0, H]], KB, Path, Cost).

% A* search that maintains a sorted frontier
search([[Node, RevPath, Cost, _]|_], _, Path, Cost) :-
    goal(Node),
    reverse([[]|RevPath], Path).

search([[Node, RevPath, Cost, _]|Rest], KB, Path, FinalCost) :-
    findall([Child, [Node|RevPath], NewCost, F], 
            (arc(Node, Child, StepCost, KB),
             \+ member(Child, RevPath),  % Avoid cycles
             NewCost is Cost + StepCost,
             heuristic(Child, H),
             F is NewCost + H),
            Children),
    add2frontier(Children, Rest, NewFrontier),
    search(NewFrontier, KB, Path, FinalCost).

% Ensures frontier is sorted based on f-value
add2frontier(Children, Frontier, NewFrontier) :-
    append(Children, Frontier, Combined),
    predsort(compare_nodes, Combined, NewFrontier).

compare_nodes(Order, [_, _, Cost1, F1], [_, _, Cost2, F2]) :-
    F1 =:= F2 -> (Cost1 =< Cost2 -> Order = (<) ; Order = (>));
    (F1 < F2 -> Order = (<) ; Order = (>)).