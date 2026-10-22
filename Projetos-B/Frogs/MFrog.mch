/* MFrog
 * Author: 
 * Creation date: 24/09/2026
 */
MACHINE
    MFrog
SETS
    FROG = {ee, b1,b2,b3,r1,r2,r3}
CONSTANTS
    STONE,
    BLUE,
    RED
PROPERTIES
    STONE = 1..7
    & BLUE = {b1,b2,b3}
    & RED = {r1,r2,r3}
VARIABLES
    state
INVARIANT
    state : FROG >+> STONE
//    & not(state = {r1 |-> 1, r2 |-> 2, r3 |-> 3,
//                   b1 |-> 5, b2 |-> 6, b3 |-> 7})
INITIALISATION
    state := {b1 |-> 1, b2 |-> 2, b3 |-> 3,
              r1 |-> 5, r2 |-> 6, r3 |-> 7}
OPERATIONS
    move(frog,pos) =
    PRE
        frog : FROG
        & pos : STONE
        & (frog : BLUE => pos : {state(frog)+1, state(frog)+2})
        & (frog : RED => pos : {state(frog)-1, state(frog)-2})
        & pos /: ran(state)
    THEN
        state := state <+ {frog |-> pos}
    END
END    