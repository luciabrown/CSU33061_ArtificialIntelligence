% IMPLEMETING A PREDICATE ACCEPT AS SEARCH IN PROLOG

% ARC/4 PREDICATE SPECIFIES VALID TRANSITIONS
arc(Transitions, CurrentState, InputSymbol, NextState) :-
    member([CurrentState, InputSymbol, NextState], Transitions).

% ACCEPT/4 BASE CASE - THE CURRENT STATE IS IN AN ACCEPTING STATE
% Note: The remainder of the inputs do not matter if CurrentState is an Accepting State. Therefore leave the list of future inputs blank

accept(Transitions, AcceptingStates, CurrentState, []):-
    member(CurrentState, AcceptingStates).

% ACCEPT/4 RECUSRIVE CASE - USE ARC TO MOVE TO THE NEXT STATE AND  CHECK AGAIN

accept(Transitions, AcceptingStates, CurrentState. [HeadOfInput | UnseenInputs]) :-
    arc(Transitions, CurrentState, HeadOfInput, NextState),
    accept(Transitions, AcceptingStates, NextState, UnseenInputs).

% Notes: if arc can find a valid NextState by using the CurrentState and the first input symbol read
% Then the valid NextState can be passed as a parameter to accept/4