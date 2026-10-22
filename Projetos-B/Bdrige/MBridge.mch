/* MBridge
 * Author: 
 * Creation date: 17/09/2026
 */
MACHINE
    MBridge
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
    move_right(pp) =
    PRE
        pp <: PESSOAS
        & pp <: pleft
        & card(pp) <= 2
        & card(pp) > 0
        & light = esq
        & elapsed +
          max({tt | tt : NATURAL &
              (# xx . (xx : pp & TEMPTRAV(xx) = tt))})
          <= MAX_TIME
    THEN
        pleft := pleft - pp
        || pright := pright \/ pp
        || light := dir
        || elapsed := elapsed + max({tt | tt : NATURAL &
              (# xx . (xx : pp & TEMPTRAV(xx) = tt))})
    END
    ;
    move_left(pp) =
    PRE
        pp <: PESSOAS
        & pp <: pright
        & card(pp) <= 2
        & card(pp) > 0
        & light = dir
        & elapsed +
          max({tt | tt : NATURAL &
              (# xx . (xx : pp & TEMPTRAV(xx) = tt))})
          <= MAX_TIME
    THEN
        pleft := pleft \/ pp
        || pright := pright - pp
        || light := esq
        || elapsed := elapsed + max({tt | tt : NATURAL &
              (# xx . (xx : pp & TEMPTRAV(xx) = tt))})
    END    
END
