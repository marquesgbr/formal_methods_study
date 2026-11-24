/*
 * UNIVERSIDADE FEDERAL DE PERNAMBUCO
 * CENTRO DE INFORMÁTICA
 * CIÊNCIA DA COMPUTAÇÃO
 *
 * SISTEMAS CRÍTICOS 2023.1
 * EXERCICIO ESCOLAR (22/09/2023)
 * PROFESSOR: GUSTAVO CARVALHO
 *
 * PONTUAÇÃO
 * 1a Questão  =  2,0
 * 2a Questão  =  0,5
 * 3a Questão  =  0,5
 * 4a Questão  =  1,0
 * 5a Questão  =  1,0
 * 6a Questão  =  2,0
 * 7a Questão  =  1,0
 * 8a Questão  =  0,5
 * 9a Questão  =  1,5
 * ------total = 10,0 pontos
 */

// --------------------------------------------------------------------------------------
// ALUNO: _____________________________________________________________________
// --------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
// Especifique formalmente (em B) um sistema de pedidos de um restaurante.
// - Não adicione variáveis à máquina.
// - Não mude a assinatura das operações.
// Sugestão: use o ProB para simular seu modelo e procurar por violação de invariantes
// --------------------------------------------------------------------------------------
MACHINE
    MRestauranteEnunciado
SETS
    // NOME_ITEM representa os nomes de itens do cardápio (e.g., "carbonara").
    NOME_ITEM ;
    // PASSO_ITEM representa passos para a preparação de itens (e.g., "quebre o ovo").    
    PASSO_ITEM ;
    // ID_ITEM representa códigos de itens do cardápio (e.g., ID001).
    ID_ITEM ;
    // ID_MESA representa códigos de mesas (e.g., M001).
    ID_MESA
VARIABLES
    // Conjunto de mesas que o restaurante possui (e.g., {M001,M002}).
    // O restaurante possui uma quantidade finita de mesas.
    mesas,
    // Conjunto de itens que o restaurante pode servir (e.g., {ID001,ID002}).
    // O restaurante possui uma quantidade finita de itens.
    itens,
    // Associa todo item do restaurante a um nome (e.g., {(ID001, "carbonara"),...}).
    // Itens distintos devem ter nomes diferentes.
    nome,
    // Associa todo item do restaurante a um preço (e.g., {(ID001, 55),...}).
    // O preço de um item é um número natural positivo.
    preco,
    // Associa todo item do restaurante a uma sequência não vazia de passos
    // (e.g., {(ID001,[...,"quebre o ovo",...]),...}).    
    passos,
    // Associa toda mesa do restaurante a um pedido, que é uma sequência de itens
    // (e.g., {(M001,[ID001,ID001,...]),...}).
    pedidos
INVARIANT
// 1a Questão
// Defina adequadamente o tipo das variáveis declaradas em VARIABLES.
// Capture também as restrições associadas, descritas de forma textual.

INITIALISATION
// 2a Questão
// Inicialmente, não há itens, nem mesas, registrados no restaurante.

OPERATIONS
// 3a Questão
// Defina a operação: adicionar_mesa(id_mesa).
// - Não é possível adicionar uma mesa já registrada no restaurante.

// 4a Questão
// Defina a operação: remover_mesa(id_mesa).
// - A mesa a ser removida deve ser uma mesa do restaurante.
// - Só é possível remover uma mesa se o pedido atual dela for vazio.

// 5a Questão
// Defina a operação: adicionar_item(id_item, nome_item, preco_item, passos_item).
// - Não é possível adicionar um item já registrado no restaurante.

// 6a Questão
// Defina a operação: atualizar_item(id_item, nome_item, preco_item, passos_item).
// - Só é possível atualizar itens que já estejam registrados no restaurante.
// - A operação precisa mudar pelo menos um dos seguintes valores:
//   nome do item, preço do item ou passos para preparar o item.
// - A operação não pode ocorrer se o item fizer parte do pedido de alguma mesa.

// 7a Questão
// Defina a operação: apagar_item(id_item).
// - Só é possível apagar itens registrados no restaurante.
// - A operação não pode ocorrer se o item fizer parte do pedido de alguma mesa.

// 8a Questão
// Defina a operação: anotar_pedido(id_mesa, pedido).
// - A operação atualiza o pedido da mesa adicionando os novos itens solicitados.

// 9a Questão
// Defina a operação: total <-- fechar_conta(id_mesa).
// - A operação só pode ocorrer se a mesa tiver pedido pelo menos um item do cardápio.
// - A operação retorna o valor total a ser pago pela mesa.
// - A operação também fecha o pedido da mesa, associando a mesa a um pedido vazio.
// - Dica: talvez você precise utilizar "SIGMA" (pp. 43) e "prj2" (pp. 56).
END