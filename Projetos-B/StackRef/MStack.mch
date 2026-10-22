/* MStack
 * Author: 
 * Creation date: 08/10/2026
 */
MACHINE
    MStack
CONSTANTS
    MAX_SIZE
PROPERTIES
    MAX_SIZE : NAT
    & MAX_SIZE > 0
VARIABLES    
    stack_data
INVARIANT
    stack_data : seq(NAT)
    & size(stack_data) <= MAX_SIZE
    // seq(E) = U n . (n : NAT | 1..n --> E)
INITIALISATION
    stack_data := {}
OPERATIONS
    stack_push(value) =
    PRE
        value : NAT
        & size(stack_data) < MAX_SIZE
    THEN
        stack_data := stack_data <- value
    END
    ;
    value <-- stack_top =
    PRE
        size(stack_data) > 0
    THEN
        value := stack_data(size(stack_data)) // last(stack_data)
    END
    ;
    stack_pop =
    PRE
        size(stack_data) > 0
    THEN
        stack_data := front(stack_data)
    END
    ;
    is_empty <-- stack_empty =
    BEGIN
        IF size(stack_data) = 0 THEN is_empty := TRUE
        ELSE is_empty := FALSE END
    END
END