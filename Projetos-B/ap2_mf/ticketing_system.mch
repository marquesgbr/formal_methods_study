/* ticketing_system
 * Author: gabri
 * Creation date: 15/09/2026
 */
MACHINE
    ticketing_system
VARIABLES
    serve, next
INVARIANT
    serve: NATURAL & next: NATURAL & serve <= next
INITIALISATION
    serve, next := 0, 0
OPERATIONS

ss <-- serve_next = 
        PRE serve < next
        THEN ss, serve := serve+1, serve+1
        END;
        
tt <-- take_ticket =
       tt, next := next, next+1
END
