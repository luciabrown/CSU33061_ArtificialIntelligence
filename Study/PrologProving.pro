prove(Node) :- goal(Node) .
prove(Node) :- arc(Node,Next), prove(Next).

arc([H|T],N,KB) :- member([H|B],KB), append(B,T,N).
prove(Node,KB) :- goal(Node) ; arc(Node,Next,KB), prove(Next,KB).
KB = [[p,[q,r]], [q,[s]], [r,[]], [s,[]]].