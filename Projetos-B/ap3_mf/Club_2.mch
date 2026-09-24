MACHINE
    Club_2
SEES 
    Club_2_ctx    
VARIABLES         
    member, waiting

INVARIANT         
    member <: NAME 
    & waiting <: NAME 
    & member /\ waiting = {}
    & member:FIN(member)
    & card(member) <= capacity
    & waiting:FIN(waiting)
    & card(waiting) <= total
                  
INITIALISATION    member := {} || waiting := {}

OPERATIONS

  join(nn) =
  PRE nn : NAME & nn : waiting & card(member) < capacity
  THEN member := member \/ {nn} || waiting := waiting - {nn} 
  END;

  join_queue(nn) =
  PRE nn : NAME & nn /: member & nn /: waiting
      & card(waiting) < total
  THEN waiting := waiting \/ {nn}
  END;

  remove(nn) = 
  PRE nn : NAME & nn : member
  THEN member := member - {nn}
  END;

ans <-- query_membership(nn) =
  PRE nn : NAME
  THEN 
    IF nn : member 
    THEN ans := yes
    ELSE ans := no
    END
  END

END


