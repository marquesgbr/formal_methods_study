/* MHanoi
 * Author: 
 * Creation date: 10/09/2026
 */
MACHINE
    MHanoi
SETS
    PINOS = {p1,p2,p3}
CONSTANTS
    BLOCOS
PROPERTIES
    BLOCOS = {1,2,3}
VARIABLES
    estado
INVARIANT
    estado : PINOS <-> BLOCOS
    & card(estado) = 3
    & ran(estado) = BLOCOS
    //& not(estado = {p3|->1, p3|->2, p3|->3})
INITIALISATION
    estado := {p1|->1, p1|->2, p1|->3}
OPERATIONS
    move(pp_origem, pp_destino) =
    PRE
        pp_origem : PINOS
        & pp_destino : PINOS
        & pp_origem /= pp_destino
        & estado[{pp_origem}] /= {}
        & (estado[{pp_destino}] /= {}
           => min(estado[{pp_origem}]) < min(estado[{pp_destino}]))
    THEN
        estado := (estado - {pp_origem |-> min(estado[{pp_origem}])})
                  \/ {pp_destino |-> min(estado[{pp_origem}])}
    END
END
