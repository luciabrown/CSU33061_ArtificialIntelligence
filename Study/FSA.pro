/*FSA that checks whether a given sequence of inputs is accepted by the automaton.*/

/*accepts an empty list if the current state is a member of the list of final states*/
accept(_,Final,Q,[]) :- member(Q,Final).
/*checks whether there's a transition in the transition list that the automaton can move from state Q to state Qn on input H.*/
accept(Trans,Final,Q,[H|T]):- member([Q,H,Qn],Trans),accept(Trans,Final,Qn,T).

member(X,[X|_]).
member(X,[_|L]):-member(X,L).