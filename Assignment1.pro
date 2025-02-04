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

astar(Node,Path,Cost,KB)

% Sample skeleton 
search([Node|_]) :- goal(Node).

search([Node|More]) :- 
    findall(X,arc(Node,X),Children),
    add2frontier(Children,More,New),
    search(New).

less-than([[Node1|_],Cost1],[[Node2|_],Cost2]) :-
    heuristic(Node1,Hvalue1), heuristic(Node2,Hvalue2),
    F1 is Cost1+Hvalue1, F2 is Cost2+Hvalue2,
    F1 =< F2.