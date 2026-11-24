/* MRestaurante
 * Author: ghpc
 * Creation date: 21/09/23
 */
MACHINE
    MRestaurante
SETS
    NOME_ITEM ; PASSO_ITEM ;
    ID_ITEM ; ID_MESA
VARIABLES
    mesas,
    itens,
    nome,
    preco,
    passos,
    pedidos
INVARIANT
    mesas : FIN(ID_MESA)
    & itens : FIN(ID_ITEM)
    & nome : itens >-> NOME_ITEM
    & preco : itens --> NAT1
    & passos : itens --> seq1(PASSO_ITEM)
    & pedidos : mesas --> seq(itens)
INITIALISATION
    mesas := {}
    || itens := {}
    || nome := {}
    || preco := {} 
    || passos := {}
    || pedidos := {}
OPERATIONS
    adicionar_mesa(id_mesa) =
    PRE
        id_mesa : ID_MESA
        & id_mesa /: mesas
    THEN
        mesas := mesas \/ {id_mesa}
        || pedidos(id_mesa) := []
    END
    ;
    remover_mesa(id_mesa) =
    PRE
        id_mesa : ID_MESA
        & id_mesa : mesas
        & pedidos(id_mesa) = []
    THEN
        mesas := mesas - {id_mesa}
        || pedidos := {id_mesa} <<| pedidos
    END
    ;
    adicionar_item(id_item, nome_item, preco_item, passos_item) =
    PRE
        id_item : ID_ITEM
        & id_item /: itens
        & nome_item : NOME_ITEM
        & nome_item /: ran(nome)
        & preco_item : NAT1
        & passos_item : seq1(PASSO_ITEM)
    THEN
        itens := itens \/ {id_item}
        || nome(id_item) := nome_item
        || preco(id_item) := preco_item
        || passos(id_item) := passos_item
    END
    ;
    atualizar_item(id_item, nome_item, preco_item, passos_item) =
    PRE
        id_item : ID_ITEM
        & id_item : itens
        & nome_item : NOME_ITEM
        & preco_item : NAT1
        & passos_item : seq1(PASSO_ITEM)
        & (nome(id_item) /= nome_item or preco(id_item) /= preco_item or passos(id_item) /= passos_item)
        & (nome(id_item) /= nome_item => nome_item /: ran(nome))
        & ! pedido . (pedido : ran(pedidos) => id_item /: ran(pedido))
    THEN
        nome(id_item) := nome_item
        || preco(id_item) := preco_item
        || passos(id_item) := passos_item
    END
    ;
    apagar_item(id_item) =
    PRE
        id_item : ID_ITEM
        & id_item : itens
        & not(# pedido . (pedido : ran(pedidos) & id_item : ran(pedido)))
    THEN
        itens := itens - {id_item}
        || nome := {id_item} <<| nome
        || preco := {id_item} <<| preco
        || passos := {id_item} <<| passos
    END
    ;
    anotar_pedido(id_mesa, pedido) =
    PRE
        id_mesa : ID_MESA
        & id_mesa : mesas
        & pedido : seq1(itens)
    THEN
        pedidos(id_mesa) := pedidos(id_mesa) ^ pedido
    END
    ;
    total <-- fechar_conta(id_mesa) =
    PRE
        id_mesa : ID_MESA
        & id_mesa : mesas
        & pedidos(id_mesa) /= []
    THEN
        total := SIGMA ii . (ii : pedidos(id_mesa) | preco(prj2(NATURAL,ID_ITEM)(ii)))
        || pedidos(id_mesa) := []
    END
END