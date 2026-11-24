/* MCorrida
 * Author: ghpc
 * Creation date: 17/10/22
 */
MACHINE
    MCorrida
SETS
    MODALIDADES = {CINCO, DEZ, MEIA, MARATONA}
    ; STATUS_CORRIDA = {NAO_INICIADA, INICIADA, ENCERRADA}
    ; CPF
CONSTANTS
    VALOR
PROPERTIES
    VALOR : MODALIDADES --> NAT
    & VALOR = {CINCO |-> 2, DEZ |-> 2, MEIA |-> 4, MARATONA |-> 6}
VARIABLES
    inscricoes,
    inscricoes_pagas,
    inscricoes_confirmadas,    
    inscricoes_abertas,
    inscricoes_processadas,
    valor_arrecadado,
    status_corrida,
    tempo_largada,
    tempo_chegada
INVARIANT
    inscricoes : CPF +-> MODALIDADES
    & inscricoes_pagas : dom(inscricoes) --> BOOL
    & inscricoes_confirmadas <: dom(inscricoes)
    & inscricoes_abertas : BOOL
    & inscricoes_processadas : BOOL
    & valor_arrecadado : NAT
    & status_corrida : STATUS_CORRIDA
    & tempo_largada : inscricoes_confirmadas --> INT
    & tempo_chegada : inscricoes_confirmadas --> INT
    & ! vv . ((vv : INT & (vv : ran(tempo_largada) or vv : ran(tempo_chegada))) => (vv >= -1))   
    & ! cpf . ((cpf : CPF & cpf : inscricoes_confirmadas & tempo_chegada(cpf) /= -1) =>
            (tempo_largada(cpf) /= -1 & tempo_chegada(cpf) > tempo_largada(cpf)))
INITIALISATION
    inscricoes := {}
    || inscricoes_pagas := {}
    || inscricoes_confirmadas := {}
    || inscricoes_abertas := FALSE
    || inscricoes_processadas := FALSE
    || valor_arrecadado := 0
    || status_corrida := NAO_INICIADA
    || tempo_largada := {}
    || tempo_chegada := {}
OPERATIONS
    abrir_inscricoes =
    PRE
        inscricoes_abertas = FALSE
        & inscricoes_processadas = FALSE
    THEN
        inscricoes_abertas := TRUE
    END
    ;
    fechar_inscricoes =
    PRE
        inscricoes_abertas = TRUE
    THEN
        inscricoes_abertas := FALSE
    END
    ;
    realizar_inscricao(cpf, modalidade) =
    PRE
        cpf : CPF
        & cpf /: dom(inscricoes)
        & modalidade : MODALIDADES
        & inscricoes_abertas = TRUE
    THEN
        inscricoes := inscricoes \/ {cpf |-> modalidade}
        || inscricoes_pagas := inscricoes_pagas \/ {cpf |-> FALSE}
    END
    ;
    pagar_inscricao(cpf) =
    PRE
        cpf : CPF
        & cpf : dom(inscricoes)
        & inscricoes_pagas(cpf) = FALSE
        & inscricoes_processadas = FALSE
    THEN
        inscricoes_pagas(cpf) := TRUE
        || valor_arrecadado := valor_arrecadado + VALOR(inscricoes(cpf))
    END
    ;
    cancelar_inscricao(cpf) =
    PRE
        cpf : CPF
        & cpf : dom(inscricoes)
        & inscricoes_processadas = FALSE
    THEN
        inscricoes := {cpf} <<| inscricoes
        ||
        IF inscricoes_pagas(cpf) = TRUE THEN
            valor_arrecadado := valor_arrecadado - (VALOR(inscricoes(cpf)) / 2)
        END
        ||
        inscricoes_pagas := {cpf} <<| inscricoes_pagas
    END
    ;
    processar_inscricoes =
    PRE
        inscricoes_abertas = FALSE
        & inscricoes_processadas = FALSE
        & card(inscricoes_pagas |>> {FALSE}) > 0
    THEN
        LET confirmadas BE
            confirmadas = { cpf | cpf : dom(inscricoes) & inscricoes_pagas(cpf) = TRUE }
        IN
            inscricoes_processadas := TRUE
            || inscricoes_confirmadas := confirmadas
            || tempo_largada := confirmadas * {-1}
            || tempo_chegada := confirmadas * {-1}
        END
    END
    ;
    iniciar_corrida =
    PRE
        inscricoes_processadas = TRUE
        & status_corrida = NAO_INICIADA
    THEN
        status_corrida := INICIADA
    END
    ;
    registrar_tempo_largada(cpf, vv) =
    PRE
        status_corrida = INICIADA
        & cpf : inscricoes_confirmadas
        & tempo_largada(cpf) = -1
        & vv : NAT
    THEN
        tempo_largada(cpf) := vv
    END        
    ;
    registrar_tempo_chegada(cpf, vv) =
    PRE
        status_corrida = INICIADA
        & cpf : inscricoes_confirmadas
        & tempo_largada(cpf) > -1
        & tempo_chegada(cpf) = -1
        & vv : NAT
        & vv > tempo_largada(cpf)
    THEN
        tempo_chegada(cpf) := vv
    END
    ;
    encerrar_corrida =
    PRE
        status_corrida = INICIADA
    THEN
        status_corrida := ENCERRADA
    END
    ;
    arrecadacao <-- obter_arrecadacao =
    BEGIN
        arrecadacao := valor_arrecadado
    END    
    ;
    total <-- obter_total_concluites =
    PRE
        status_corrida = ENCERRADA
    THEN
        total := card(tempo_chegada |>> {-1})
    END
    ;
    retorno <-- obter_concluintes_por_modalidade =
    PRE
        status_corrida = ENCERRADA
    THEN
       LET concluintes BE
           concluintes = tempo_chegada |>> {-1}
       IN
           retorno := {CINCO    |-> card({cpf | cpf : dom(concluintes) & inscricoes(cpf) = CINCO}),
                       DEZ      |-> card({cpf | cpf : dom(concluintes) & inscricoes(cpf) = DEZ}),
                       MEIA     |-> card({cpf | cpf : dom(concluintes) & inscricoes(cpf) = MEIA}),
                       MARATONA |-> card({cpf | cpf : dom(concluintes) & inscricoes(cpf) = MARATONA})}           
       END
    END
END
