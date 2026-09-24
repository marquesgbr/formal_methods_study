/* frog_puzzle_mch
 * Author: gabri
 * Creation date: 24/09/2026
 */
MACHINE
    frog_puzzle_mch
CONSTANTS
    right_frogs, left_frogs, rocks
PROPERTIES
    right_frogs : FIN(NATURAL) & left_frogs : FIN(NATURAL) & rocks : FIN(NATURAL) 
    & card(right_frogs)=3 & card(left_frogs)=3 & card(rocks)=7
    & rocks = 1..7 & left_frogs = 1..3 & right_frogs = 4..6
VARIABLES
    puddle
INVARIANT
    puddle : 1..6 >-> 1..7 
    // & puddle /= {4|->1, 5|->2, 6|->3, 3|->5, 2|->6, 1|->7}
INITIALISATION
    puddle := 
        {1|->1, 2|->2, 3|->3, 
        4|->5, 5|->6, 6|->7}
OPERATIONS
    move_right(l_frog)=
    PRE l_frog : 1..3 & puddle(l_frog)+1<=7 &
        (puddle(l_frog)+1) /: ran(puddle)
    THEN puddle := puddle <+ {l_frog|->puddle(l_frog)+1}
    END;
    skip_right(l_frog)=
    PRE l_frog : 1..3 & puddle(l_frog)+2<=7 &
        (puddle(l_frog)+2) /: ran(puddle)
    THEN puddle := puddle <+ {l_frog|->puddle(l_frog)+2}
    END;
    
    move_left(r_frog)=
    PRE r_frog : 4..6 & puddle(r_frog)-1>=1 &
        (puddle(r_frog)-1) /: ran(puddle)
    THEN puddle := puddle <+ {r_frog|->puddle(r_frog)-1}
    END;
    skip_left(r_frog)=
    PRE r_frog : 1..3 & puddle(r_frog)-2>=1 &
        (puddle(r_frog)-2) /: ran(puddle)
    THEN puddle := puddle <+ {r_frog|->puddle(r_frog)-2}
    END
END
