/* MBridge
 * Author: 
 * Creation date: 17/09/2026
 */
MACHINE
    MBridge2
SETS
    PESSOAS = {p1,p2,p3,p4} ;
    LADO = {esq,dir}
CONSTANTS
    TEMPTRAV,
    MAX_TIME
PROPERTIES
    TEMPTRAV : PESSOAS --> NATURAL
    & TEMPTRAV = {p1 |-> 5, p2 |-> 10,
                  p3 |-> 20, p4 |-> 25}
    & MAX_TIME : NATURAL
    & MAX_TIME = 60
VARIABLES
    pleft,
    pright,
    light,
    elapsed
INVARIANT
    pleft : POW(PESSOAS)
    & pright <: PESSOAS
    & light : LADO
    & elapsed : NATURAL
    & pleft /\ pright = {}
    & pleft \/ pright = PESSOAS
    & not(pleft = {} & pright = PESSOAS)
INITIALISATION
    pleft := PESSOAS
    || pright := {}
    || light := esq
    || elapsed := 0
OPERATIONS
    move(pp,dd) =
    PRE
        dd : LADO
        & (light = esq => dd = dir)
        & (light = dir => dd = esq)       
        & pp <: PESSOAS
        & (dd = esq => pp <: pright)
        & (dd = dir => pp <: pleft)
        & card(pp) <= 2
        & card(pp) > 0
        & elapsed + max(TEMPTRAV[pp]) <= MAX_TIME
    THEN
        IF dd = esq THEN
            pleft := pleft \/ pp
            || pright := pright - pp
            || light := esq
        ELSIF dd = dir THEN
            pleft := pleft - pp
            || pright := pright \/ pp
            || light := dir
        END
        ||
        elapsed := elapsed + max(TEMPTRAV[pp])
    END
END
