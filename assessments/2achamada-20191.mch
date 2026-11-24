/*
 * UNIVERSIDADE FEDERAL DE PERNAMBUCO
 * CENTRO DE INFORMATICA
 * CIENCIA DA COMPUTACAO
 *
 * SISTEMAS CRITICOS 2019.1
 * 2a CHAMADA (28/06/2019)
 * PROFESSOR: GUSTAVO CARVALHO
 *
 * PONTUACAO
 * 1a questao  =  1,5 ponto
 * 2a questao  =  0,5 ponto 
 * 3a questao  =  1,5 ponto
 * 4a questao  =  0,5 ponto
 * 5a questao  =  0,5 ponto
 * 6a questao  =  0,5 ponto
 * 7a questao  =  0,5 ponto
 * 8a questao  =  0,5 ponto
 * 9a questao  =  1,0 ponto
 * 10a questao =  1,5 ponto
 * 11a questao =  1,5 ponto 
 * ------total = 10,0 pontos
 */
 
// ALUNO: _____________________________________________________________________

// Especifique formalmente (em B) um sistema de controle de acesso, conforme orientacoes a seguir. A priori, nao ha necessidade de adicionar novas variaveis aa maquina. Nao mude a assinatura das operacoes. Sugestao: utilize o ProB para simular (validar) seu modelo, como tambem procurar por violacoes de invariantes.
MACHINE
    MAccessEnunciado
SETS
    USER_ID ; // Identificador de usuarios
    ROOM_ID ; // Identificador de salas
    CATEGORY = {lecturer, student, staff, none} // Categoria do usuario
VARIABLES
    users, // Usuarios registrados no sistema
    category, // Categoria dos usuarios (todo usuario tem exatemente 1 categoria)
    rooms, // Salas registradas no sistema
    permission_category, // Categoria autorizada a acessar uma sala (uma categoria autorizada por sala)
    permission_users, // Usuarios registrados autorizados a acessar uma sala (0 ou mais usuarios)
    num_access, // Quantidade de acessos a salas (independente de qual), para cada usuario
    total_time // Tempo total gasto em salas (independente de qual), para cada usuario
INVARIANT
// 1a questao
// Defina adequadamente o tipo das variaveis declaradas anteriormente.
INITIALISATION
    users, category := {}, {}
    || rooms, permission_category, permission_users := {}, {}, {}
    || num_access, total_time := {}, {}
OPERATIONS
// 2a questao  
// Defina a operacao add_users(uu,cc), que registra o usuario uu com a categoria cc. O usuario uu nao pode ja estar registrado no sistema. Adicionalmente, a categoria informada nao pode ser none. Ao registrar um novo usuario, a quantidade de acessos e o tempo total em salas deste usuario serao 0.

// 3a questao
// Defina a operacao remove_user(uu), onde uu precisa ser um usuario registrado. Ao remover um usuario, se ele tinha permissao para acessar uma certa sala, ele deve ter o seu acesso revogado.

// 4a questao
// Defina a operacao add_room(rr), que registra a sala rr no sistema. Para realizar esta operacao, rr nao pode ser uma sala ja registrada no sistema. Ao registrar uma nova sala, inicialmente, a categoria com permissao de acesso a esta sala sera none. Inicialmente, nenhum usuario tem acesso a uma nova sala.

// 5a questao
// Defina a operacao remove_room(rr), que remove do sistema a sala rr. Para realizar esta operacao, a sala rr precisa estar registrada no sistema.

// 6a questao
// Defina a operacao grant_permission_category(rr,cc), que atualiza a informacao de que, agora, a categoria cc tem acesso aa sala rr. A sala rr precisa estar registrada no sistema. A categoria cc pode ser qualquer uma em CATEGORY. Esta operacao so deve ser realizada se a categoria com acesso aa sala rr ja nao for a categoria cc.

// 7a questao
// Defina a operacao grant_permission_user(rr,uu), que atualiza a informacao de que, agora, o usuario uu tambem tem permissao de acesso aa sala rr, que precisa estar registrada no sistema, assim como o usuario uu. Esta operacao so deve ser realizada se uu ja nao for um usuario com acesso aa sala rr.

// 8a questao
// Defina a operacao revoke_permission_user(rr,uu), que retira do usuario uu a permissao de acessar a sala rr. Para executar esta operacao, uu e rr devem ser um usuario e uma sala registrados no sistema, respectivamente. Alem disto, o usuario uu deve ser um dos usuarios com acesso aa sala rr.

// 9a questao
// Defina a operacao register_user_access(uu,rr,dd). Esta operacao registra que o usuario uu, registrado no sistema, acessou a sala rr, tambem registrada no sistema, e permaneceu por dd minutos dentro desta. Para executar esta operacao, dd precisa ser maior do que 0. Adicionalmente, a categoria do usuario uu precisa ser a que tem acesso aa sala rr ou o usuario uu ser um dos que tem acesso aa sala rr. Ao executar esta operacao, a quantidade de acessos a sala do usuario uu eh incrementada de 1, e atualiza-se o tempo total do usuario uu dentro de salas gerenciados pelo sistema.

// 10a questao
// Defina a operacao avg <-- average_time, que retorna o tempo medio de permanencia em uma sala. Esta operacao so pode ser realizada se num_access possui alguma informacao armazenada, e ha pelo menos um usuario com a quantidade de acessos maior do que 0. Nesta operacao, deve-se calcular o somatorio do tempo total de acesso de todos os usuarios (sum_time), bem como o somatorio da quantidade de acessos de todos os usuarios (sum_accesses). Portanto, esta operacao deve retornar o valor (sum_time / sum_accesses).

// 11a questao
// Defina a operacao us <-- most_number_accesses que retorna os usuarios que mais acessaram salas gerenciadas pelo sistema. Se num_acess nao tiver alguma informacao armazenada, deve ser retornado um conjunto vazio.
END