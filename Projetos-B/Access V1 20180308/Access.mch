MACHINE Access

SETS
    PRINTER; 
    OPTION; 
    PERMISSION = {ok, no}

VARIABLES 
    options

INVARIANT
    options : PRINTER <-> OPTION 

INITIALISATION    options := {}

OPERATIONS

  add(pp,oo) =
  PRE pp : PRINTER & oo:OPTION
  THEN options := options \/ {pp |-> oo}
  END;

  remove(pp,oo) =
  PRE pp : PRINTER & oo:OPTION
  THEN options := options - {pp |-> oo}
  END;

  ans <-- optionquery(pp,oo) =
  PRE pp : PRINTER & oo:OPTION
  THEN IF pp |-> oo : options
       THEN ans := ok
       ELSE ans := no
       END
  END

END




