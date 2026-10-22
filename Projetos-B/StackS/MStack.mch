/* MStack
 * Author: 
 * Creation date: 22/09/2026
 */
MACHINE
    MStack
VARIABLES
    stack
INVARIANT
    stack : seq(NATURAL)
INITIALISATION
    stack := []
OPERATIONS
    op_push(vv) =
    PRE
        vv : NATURAL
    THEN
        stack := stack <- vv
    END
    ;
    op_pop =
    BEGIN
        stack := front(stack)
    END
    ;
    vv <-- op_top =
    PRE
        size(stack) > 0
    THEN        
        vv := last(stack)
    END    
    ;
    ss <-- op_size =
    BEGIN
        ss := size(stack)
    END
    ;
    op_clear =
    BEGIN
        stack := []
    END    
END
