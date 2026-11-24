/*
 * UNIVERSIDADE FEDERAL DE PERNAMBUCO
 * CENTRO DE INFORMATICA
 * CIENCIA DA COMPUTACAO
 *
 * SISTEMAS CRITICOS 2019.1
 * EXERCICIO ESCOLAR (17/06/2019)
 * PROFESSOR: GUSTAVO CARVALHO
 *
 * PONTUACAO
 * 1a questao  =  1,0 ponto
 * 2a questao  =  1,0 ponto
 * 3a questao  =  1,0 ponto
 * 4a questao  =  0,5 ponto
 * 5a questao  =  0,5 ponto
 * 6a questao  =  1,0 ponto
 * 7a questao  =  1,0 ponto
 * 8a questao  =  1,5 ponto
 * 9a questao  =  0,5 ponto
 * 10a questao =  2,0 pontos
 * ------total = 10,0 pontos
 */
 
// ALUNO: _____________________________________________________________________

// Especifique formalmente (em B) um sistema de streaming, conforme orientacoes a seguir. A priori, nao ha necessidade de adicionar novas variaveis a maquina. Nao mude a assinatura das operacoes. Sugestao: utilize o ProB para simular (validar) seu modelo, como tambem procurar por violacoes de invariantes.
MACHINE
    MStreamingEnunciado
SETS
    USER_ID ;     // Identificador de usuarios
    FILM_ID       // Identificador de filmes
VARIABLES
    users,        // Usuarios registrados no sistema
    subscription, // Informacao se a inscricao do usuario esta ativa (TRUE = ativa | FALSE = inativa)
    films,        // Filmes registrados no sistema
    views,        // Quantidade de visualizacoes de cada filme registrado no sistema
    history,      // Historico de visualizacao (sequencia de filmes que cada usuario viu)
    wish_list     // Filmes de interesse de cada usuario
INVARIANT
// 1a questao
// Defina adequadamente o tipo das variaveis declaradas anteriormente

// 2a questao
// Defina as seguintes invariantes:
// - Todo filme no historico de visualizacao de qualquer usuario eh um filme registrado no sistema
// - Todo filme na lista de interesse de qualquer usuario eh um filme registrado no sistema
// - Para todo usuario, nao existe filme na sua lista de interesse que ja foi visto pelo mesmo
INITIALISATION
    users, subscription, history, wish_list := {}, {}, {}, {}
    || films, views := {}, {}
OPERATIONS
// 3a questao
// Defina a operacao add_user(uu) que registra o usuario uu no sistema. O usuario uu nao pode fazer parte dos usuarios ja registrados no sistema. Ao registrar um novo usuario, sua inscricao estara inicialmente ativa (TRUE). Seu historico e sua lista de interesse serao inicialmente vazios.

// 4a questao
// Defina a operacao remove_user(uu) que remove um usuario do sistema.

// 5a questao
// Defina as operacoes expire_subscription(uu) e renew_subscription(uu) que expira e renova, respectivamente, a inscricao de um usuario. Cada operacao so deve ser realizada se alterar o status atual da inscricao do usuario; por exemplo, so se pode expirar a inscricao de um usuario que se encontra ativa.

// 6a questao
// Defina as operacoes add_film(ff) e remove_filme(ff). Um filme so pode ser removido se nao ter sido assistido por algum usuario (ou seja, se nao estiver no historico de algum usuario). Contudo, um filme, que ainda nao foi assistido por algum usuario, pode ser removido mesmo que esteja na lista de interesse de algum usuario.

// 7a questao
// Defina as operacoes add_wish_list(uu,ff) e remove_wish_list(uu,ff) que adiciona e remove, respectivamente, um filme ff na lista de interesse do usuario uu. Um filme so pode ser adicionado na lista de interesse se ja nao estiver presente nesta. Alem disso, nao eh possivel adicionar na lista de interesse um filme que o usuario ja assistiu.

// 8a questao
// Defina a operacao view_film(uu,ff) que indica que o usuario uu viu o filme ff. O usuario uu so pode ver o filme ff se estiver com sua inscricao ativa. Esta operacao deve incrementar a quantidade de visualizacoes do filme ff e atualizar o historico do usuario (um usuario pode ver o mesmo filme quantas vezes quiser). Se o filme ff estiver na lista de interesse do usuario uu, ele deve ser removido desta lista.

// 9a questao
// Defina a operacao view_random_film(uu) que eh similar a operacao view_filme. Contudo, aqui o filme a ser visto eh escolhido de forma aleatoria (nao-deterministica) pelo sistema.

// 10a questao
// Defina as operacoes most_viewed, greatest_viewer e last_three_filmes(uu). A primeira retorna o(s) filme(s) com a maior quantidade de visualizacoes. A segunda retorna o usuario que mais assistiu filmes (o usuario deve ter assistido pelo menos um filme e nao sao admitidos empates -- so deve existir um usuario com a maior quantidade de visualizacoes). Se houver empate, retorne um conjunto vazio. Por fim, a ultima operacao retorna os ultimos 3 filmes vistos pelo usuario uu. Esta operacao so pode ser realizada se o usuario ja viu pelo menos 3 filmes.