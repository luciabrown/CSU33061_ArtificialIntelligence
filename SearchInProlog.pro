search(Node) :- goal(Node).
search(Node) :- arc(Node,Next), search(Next).

/*Goal Base Case*/
goal([Q,[]],Final) :- member(Q,Final).

/*Predicate to check for valid transitions*/
arc([Q,[H|T]],[Qn,T],Trans) :-member([Q,H,Qn],Trans).


/*Extension of search(1) to handle FSA parameters*/
search(Node,Final,_) :- goal(Node,Final).
search(Node,Final,Trans) :- arc(Node,Next,Trans),search(Next,Final,Trans).
accept(Trans,Final,Q0,S) :- search([Q0,S],Final,Trans).