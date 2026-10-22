/* exp_eval
 * Author: gabriel
 * Creation date: 22/10/2026
 */
MACHINE
    exp_eval
VARIABLES
    stack
INVARIANT
    stack : seq(REAL)
INITIALISATION
    stack := [] 
OPERATIONS
    push(vv) =
    PRE
        vv : REAL
    THEN
        stack := stack <- vv
    END
    ;
    add =
    PRE size(stack)>=2
    THEN
        LET n1, n2 BE
            n1 = last(stack) &
            n2 = last(front(stack))
        IN
            stack := (front(front(stack))) <- (n1 + n2)
        END
    END;
    
    
    sub =
    PRE size(stack)>=2 
    THEN
        LET n1, n2 BE
            n1 = last(stack) &
            n2 = last(front(stack))
        IN
            stack := (front(front(stack))) <- (n1 - n2)
        END
    END;
    
    mul =
    PRE size(stack)>=2
    THEN
        LET n1, n2 BE
            n1 = last(stack) &
            n2 = last(front(stack))
        IN
            stack := (front(front(stack))) <- (n1 * n2)
        END
    END;
    
    div =
    PRE size(stack)>=2 &
        last(stack) + last(front(stack)) : REAL
    THEN
        LET n1, n2 BE
            n1 = last(stack) &
            n2 = last(front(stack))
        IN
            IF n2 /= 0.0
            THEN
                stack := (front(front(stack))) <- (n1 / n2)
            END
        END
    END
END
