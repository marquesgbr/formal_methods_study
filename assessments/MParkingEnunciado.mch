/*
 * UNIVERSIDADE FEDERAL DE PERNAMBUCO
 * CENTRO DE INFORMATICA
 * CIENCIA DA COMPUTACAO
 *
 * SISTEMAS CRITICOS 2019.1
 * EXERCICIO FINAL (08/07/2019)
 * PROFESSOR: GUSTAVO CARVALHO
 *
 * PONTUACAO
 * 1a questao  =  1,5 ponto
 * 2a questao  =  1,0 ponto 
 * 3a questao  =  0,5 ponto
 * 4a questao  =  0,5 ponto
 * 5a questao  =  1,0 ponto
 * 6a questao  =  2,0 ponto
 * 7a questao  =  1,0 ponto 
 * 8a questao  =  1,0 ponto
 * 9a questao  =  0,5 ponto
 * 10a questao =  1,0 ponto
 * ------total = 10,0 pontos
 */
 
// ALUNO: _____________________________________________________________________

// Especifique formalmente (em B) um sistema de controle de estacionamento, conforme orientacoes a seguir. A priori, nao ha necessidade de adicionar novas variaveis aa maquina. Nao mude a assinatura das operacoes. Sugestao: utilize o ProB para simular (validar) seu modelo, como tambem procurar por violacoes de invariantes.
MACHINE
    MParkingEnunciado
SETS
    CAR_PLATE ; // Identificador de placas de carros
    PLACE // Identificador de vagas do estacionamento
CONSTANTS
    STARTING_PRICE, // Valor cobrado pelas primeiras 2 horas
    PRICE_PER_HOUR, // Valor adicional cobrado por hora extra
    PLACES // Conjunto de vagas do estacionamento
PROPERTIES
    STARTING_PRICE : NATURAL
    & STARTING_PRICE = 5 // Definicao do valor cobrado pelas primeiras 2 horas
    & PRICE_PER_HOUR : NATURAL
    & PRICE_PER_HOUR = 3 // Definicao do valor cobrado por hora extra
    & PLACES <: PLACE // Definicao das vagas do estacionamento
VARIABLES
    reg_cars, // Carros registrados, que nao pagam estacionamento
    cars, // Carros dentro do estacionamento no momento
    time, // Horario de entrada de cada carro que se encontra no estacionamento no momento
    max_time, // Maior valor de tempo registrado pelo sistema (em entrada ou saida)
    parking, // Mapeamento dos carros (no estacionamento) na sua eventual vaga (nem todo carro esta estacionado)
    available, // Para cada vaga do estacionamento, a informacao se a mesma esta ocupada ou nao
    pay_history // Historico ordenado de pagamentos efetuados (o ultimo elemento consiste no ultimo pagamento)
INVARIANT
// 1a questao
// Defina adequadamente o tipo das variaveis declaradas anteriormente.
reg_cars <: CAR_PLATE &
cars <: CAR_PLATE &
time : cars --> NATURAL &
max_time : NATURAL &
parking : cars >+> PLACES &
available : PLACES --> BOOL &
pay_history : seq(NATURAL)
INITIALISATION
// 2a questao
// Inicialize as variaveis do sistema. Inicialmente, nao ha carros registrados, nao ha carros no estacionamento, nao ha informacao armazenada em time, max_time eh inicialmente 0, nao ha informacao armazenada em parking, todas as vagas do estacionamento estao disponiveis, e o historico do pagamento eh vazio.
reg_cars := {} || 
cars  := {} ||
time := {} ||
max_time := 0 ||
parking := {} ||
available := %pp.(pp : PLACES | TRUE) || // dava pra fazer PLACES * {TRUE}; esse jeito foi pelo treino
pay_history := []
OPERATIONS
// 3a questao
// Defina a operacao add_reg_car(cc). O parametro cc deve representar um carro que nao esta no conjunto de carros registrados. Alem disso, este carro nao pode estar no estacionamento no momento. A operacao adiciona este carro no conjunto de carros registrados.

// 4a questao
// Defina a operacao remove_reg_car(cc). O parametro cc deve ser a placa de um carro que esta no conjunto de carros registrados. Alem disso, este carro nao pode estar no estacionamento no momento. A operacao remove esta placa do conjunto de carros registrados.

// 5a questao
// Defina a operacao enter(cc,tt), que representa a entrada no estacionamento do carro cc no tempo tt. Este carro nao pode estar no estacionamento. O parametro tt eh um numero natural entre 0 e 24 e precisa ser maior ou igual ao valor de max_time. Alem disso, so eh permitida a entrada de um carro no estacionamento se a quantidade de carros no estacionamento for menor do que a quantidade total de vagas existentes no estacionamento. Esta operacao atualiza o conjunto de carros no estacionamento, e registra o horario de entrada do carro cc. Adicionamente, se tt for maior do que max_time, max_time deve ser atualizado para o valor de tt.
enter(cc, tt) = 
PRE
    cc : CAR_PLATE &
    tt : NATURAL &
    cc /: cars &
    tt : 0..24 & tt >= max_time &
    card(cars) < card(PLACES) 
THEN
   cars := cars \/ {cc} ||
   time := time \/ {cc |-> tt} ||
   max_time := max({tt, max_time})
END;
// 6a questao
// Defina a operacao leave(cc,tt), que representa a saida do estacionamento do carro cc no tempo tt. Este carro deve estar no estacionamento, mas nao deve estar ocupando uma vaga. Assim como na operacao anterior, o parametro tt eh um numero natural entre 0 e 24 e precisa ser maior ou igual ao valor de max_time. Se tt for maior do que max_time, max_time deve ser atualizado para o valor de tt. Se cc for um carro registrado, ele nao precisa pagar estacionamento (deve-se registrar no historico um pagamento de valor igual a 0). Contudo, se cc nao for um carro registrado, ele deve pagar pelo estacionamento. Se o tempo de permanencia for menor ou igual a 2 horas, ele paga o preco base (STARTING_PRICE). Se o tempo for maior do que 2 horas, ele paga o preco base (STARTING_PRICE) mais o preco por hora extra (PRICE_PER_HOUR) para cada hora excedente. Por exemplo, suponha que um carro passou 9h no estacionamento. Ele devera pagar STARTING_PRICE + (9 - 2)*PRICE_PER_HOUR; ou seja, 5 + 7*3 = R$ 26. O valor pago eh adicionado no historico.

leave(cc, tt) =
PRE
    cc : cars &
    cc /: dom(parking) &
    tt : NATURAL &
    tt <= 24 & tt >= 0 &
    tt >= max_time
THEN
   max_time := max({tt,max_time}) ||
   IF cc : reg_cars THEN
       pay_history := pay_history <- 0
   ELSIF tt - time(cc) <= 2 THEN
       pay_history := pay_history <- STARTING_PRICE
   ELSE
       pay_history := pay_history <- (STARTING_PRICE + (tt - time(cc) - 2)*PRICE_PER_HOUR)
   END ||
   time := {cc} <<| time ||
   cars := cars - {cc} 
END;

// 7a questao
// Defina a operacao park(cc), que representa o carro cc estacionando em alguma vaga do estacionamento. Para esta operacao ser realizada, cc deve ser um carro dentro do estacionamento; contudo, que ainda nao estacionou em uma vaga. A vaga na qual o carro cc ira estacionar deve ser escolhida de forma nao-deterministica dentre as vagas que se encontram disponiveis. Esta operacao deve marcar a vaga escolhida como ocupada e atualizar a informacao de que o carro cc agora se encontra estacionado na vaga escolhida.
park(cc) = 
PRE
    cc : CAR_PLATE &
    cc : cars &
    cc /: dom(parking) &
    TRUE : ran(available)
THEN
    ANY pp WHERE pp : PLACES & available(pp) = TRUE THEN 
        available(pp) := FALSE ||
        parking := parking <+ { cc |-> pp } // "\/" tbm daria no mesmo resultado ja que a precondicao exige que cc /: parking
    END 
END;
// 8a questao
// Defina a operacao free(cc), que representa o carro cc liberando a vaga na qual estava estacionado. Logo, para esta operacao ser realizada, o carro cc deve estar ocupando uma vaga do estacionamento no momento. Esta operacao deve marcar a vaga liberada como disponivel.
free(cc) =
PRE
    cc : CAR_PLATE &
    cc : cars &
    cc : dom(parking) &
    available(parking(cc)) = FALSE
THEN
    available := available <+ {parking(cc) |-> TRUE} ||
    parking := {cc} <<| parking
END;
// 9a questao
// Defina a operacao vv <-- get_vacancies que retorna a quantidade de vagas disponiveis no estacionamento.
vv <-- get_vacancies =
BEGIN
    vv := card(available|>{TRUE}) // outras maneiras: card(available~[{TRUE}]) ou card(available|>>{FALSE}). Nao pensei em formas sem usar card()
END;
// 10a questao
// Defina a operacao pp <-- get_total_paid que retorna o somatorio de todos os valores pagos ate o momento.
pp <-- get_total_paid =
BEGIN
    pp := SIGMA ii . ( ii : 1..size(pay_history) | pay_history(ii) )
END
END