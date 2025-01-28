search(Node):-goal(Node).
search(Node):-move(Node,Next),search(Next).

ar(wa,nt). ar(nt,q). ar(q,nsw).
ar(nsw,v). ar(wa,sa). ar(sa,nsw).
ar(nt,sa). ar(sa,v). ar(sa,q).
arc(X,Y) :- ar(X,Y) ; ar(Y,X).

goal(v).
move(X,Y):- arc(X,Y);arc(Y,X).
    
search(Node,Path) :- path([Node], Path).
path([Node|T], [Node|T]) :- goal(Node).
path([Node|T], Path) :- move(Node, Next),path([Next,Node|T],Path).