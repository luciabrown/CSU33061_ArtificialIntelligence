% frontier search

arc(N,M,Seed) :- M is N*Seed.
arc(N,M,Seed) :- M is N*Seed +1.

goal(N,Target) :- 0 is N mod Target

search(Start,Found,Seed,Target) :- fs([Start],Found,Seed,Target).

fs([Node|_ ],Node,_,Target) :-print(Node), goal(Node,Target).
