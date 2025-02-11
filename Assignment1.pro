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
    heuristic(Node, H),                                 % Calculate heuristic
    search([[Node, [], 0, H]], KB, Path, Cost).         % Path and cost initially unknown

% A* search that maintains a sorted frontier
search([[Node, RevPath, Cost, _]|_], _, Path, Cost) :-
    goal(Node),                                                 % Search succeeds when goal node reached
    reverse([[]|RevPath], Path).                                % Goal node included in the output result

search([[Node, RevPath, Cost, _]|Rest], KB, Path, FinalCost) :- 
    findall([Child, [Node|RevPath], NewCost, F],  % Find all children of current node
            (arc(Node, Child, StepCost, KB),      % Use arc to find valid steps
             \+ member(Child, RevPath),           % Avoid revisiting nodes
             NewCost is Cost + StepCost,          % Calculate new cost to reach the child
             heuristic(Child, H),                 % Child heuristic
             F is NewCost + H),                   % Compute f-value as sum of cost and heuristic
            Children),
    add2frontier(Children, Rest, NewFrontier),   % Add children to the frontier
    search(NewFrontier, KB, Path, FinalCost).    % Search with new KB

% Frontier is sorted based on f-value
add2frontier(Children, Frontier, NewFrontier) :-
    append(Children, Frontier, Combined),      		% Add children to the frontier
    predsort(compare_nodes, Combined, NewFrontier).  % Sort the frontier based on the f-value.

% Order nodes by f-value: prioritise lower f-values 
compare_nodes(Order, [_, _, Cost1, F1], [_, _, Cost2, F2]) :-
    F1 =:= F2 -> (Cost1 =< Cost2 -> Order = (<) ; Order = (>));  % If f-values are equal, sort by cost
    (F1 < F2 -> Order = (<) ; Order = (>)).  					% Else use f-value  