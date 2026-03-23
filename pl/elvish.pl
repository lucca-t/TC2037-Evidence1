% Author: Lucca Traslosheros Abascal (A01713944)
% Course: TC2037 Implementation of Computational Methods

% Title: Elvish (Sindarin) Lexical Analyzer DFA

% Description of the Regular Language:
% Accepted Words: Thang, Thangail, Tar, Taur, Tauriel
% Alphabet: {T, a, e, g, h, i, l, n, r, u}

% Knowledge Base: Transitions
% move(CurrentState, NextState, Symbol)

% Initial transition
move(q0, q1, 'T').

% Path 1: "Thang" and "Thangail"
move(q1, q2, 'h').
move(q2, q3, 'a').
move(q3, q4, 'n').
move(q4, q5, 'g').
move(q5, q6, 'a').
move(q6, q7, 'i').
move(q7, q8, 'l').

% Path 2: "Tar", "Taur", and "Tauriel"
move(q1, q9, 'a').
move(q9, q10, 'r').
move(q9, q11, 'u').
move(q11, q12, 'r').
move(q12, q13, 'i').
move(q13, q14, 'e').
move(q14, q15, 'l').

% Accepting States
accepting_state(q5).  % Accepts 'Thang'
accepting_state(q8).  % Accepts 'Thangail'
accepting_state(q10). % Accepts 'Tar'
accepting_state(q12). % Accepts 'Taur'
accepting_state(q15). % Accepts 'Tauriel'

% Traverse Method
parseDFA(InputString) :-
    % Convert the input word into a list of characters
    atom_chars(InputString, List),
    % Start the automaton at state q0
    (parseDFAHelper(List, q0) -> true ; write('Rejected \n')).

parseDFAHelper([], CurrentState) :-
    accepting_state(CurrentState),
    write('Accepted'), nl.

parseDFAHelper([Symbol|Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    parseDFAHelper(Rest, NextState).