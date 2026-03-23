% Consult the file where the DFA is programmed
:- consult('elvish.pl').

% Helper rule to test a word.
% Converts the atom to a list of characters, then checks if it is accepted.
% The '->' acts as an if-else statement.
try(Word) :-
    write(Word), write(': '),
    atom_chars(Word, List),
    ( check_validity(List, q0) -> write('Valid (Accepted)') ; write('Invalid (Rejected)') ), nl.

% Silent traversal to avoid double-printing from the original elvish.pl file
check_validity([], CurrentState) :-
    accepting_state(CurrentState).
check_validity([Symbol|Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    check_validity(Rest, NextState).

% All test cases mapped from the README
test_dfa :-
    write('--- THESE SHOULD WORK (VALID WORDS) ---'), nl,
    try('Thang'),
    try('Thangail'),
    try('Tar'),
    try('Taur'),
    try('Tauriel'),
    nl,
    write('--- THESE SHOULD FAIL (REJECTED WORDS) ---'), nl,
    try('Thangiel'),    % Mixed suffixes (Path conflation)
    try('Tarail'),      % Mixed suffixes (Path conflation)
    try('Tau'),         % Incomplete word (stops at intermediate state q11)
    try('Tha'),         % Incomplete word (stops at intermediate state q3)
    try('Sauron'),      % Invalid prefix ('S' is not in the alphabet)
    try('tauriel'),     % Case sensitive (lowercase 't' is invalid)
    try('Tauriels'),    % Trailing characters beyond the final accepting state
    try('T').           % Incomplete word (stops at intermediate state q1)