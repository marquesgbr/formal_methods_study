/* M0
 * Author: gabri
 * Creation date: 03/09/2026
*/
MACHINE
    M0
SETS
    SS = {e0, e1, e2, e3}
CONSTANTS
    SS0, C0
PROPERTIES
    SS0 : SS &
    not(SS0 = e0) &
    C0 : NAT
VARIABLES
    xx, yy
INVARIANT
    xx : NAT &
    yy : SS &
    (yy = e0 => xx = 0)
INITIALISATION
    xx := C0 ||
    yy := SS0 
OPERATIONS
    op1 = 
    BEGIN
        xx :: NAT || yy := e2 
    END;
    
    op2 = 
    BEGIN
        xx := 0 
    END
END
