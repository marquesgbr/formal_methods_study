
MACHINE
    triagem_1
SETS
    PROD_ID;
    CODIGO     
VARIABLES
    clientes, 
    cod_barras,
    carrinhos,
    produtos
INVARIANT
    clientes : FIN(NAT) &
    produtos : FIN(PROD_ID) &
    cod_barras : produtos >-> CODIGO &
    carrinhos : clientes --> seq(PROD_ID) &
    !cc.(cc : dom(carrinhos) => (ran(carrinhos(cc)) <: produtos) )
INITIALISATION
    clientes := {} ||
    produtos := {} ||
    cod_barras := {} ||
    carrinhos := {}
END
