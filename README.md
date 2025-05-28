# DESERIALIZADOR

#### Deserializador: 
- recebe uma sequência de 8 bits pelo data_in;
- escreve palavras de 8 bits no data_out;
- o sinal status_out indica se o serealizador pode receber dados;
- o sinal write_in indica que o dado deve ser interpretado pelo deserializador;
- o fio data_out possui 8 bits e é a saída de dados do deserializador;
- os dados estão prontos para consumo quando o sinal data_ready está alto;
- para confirmar o dado recebido o sinal ack_in é escrito.

### fila:
- é um container limitado do tipo FIFO de 8 bits;
- elementos são inserdos através do data_in e enqueue_in;
- elementos são removidos através do data_out e dequeue_in;
- o sinal len_out de 8 bits que indica o nº de elementos da fila;
- quando o sinal dequeue_in sobe, o 1º dado a ser retirado deve aparecer em data_out no próximo ciclo SE o nº de elementos (len_out) for maior que 0.

### regras:
- (2,5) Construção do deserializador, com tb, observando as seguintes regras: 
     - O serializador deve receber 1 bit pelo data_in;
     - Se o sinal write_in estiver alto, o bit recebido deverá ser guardado; 
     - Quando houver 8 bits guardados, o sinal data_ready deverá estar alto e os bits guardados deverão aparecer em data_out, ou seja, existem dados para transmitir;
     - Os valores de data_out e data_ready deverão se manter até o sinal ack_in ficar alto, ou seja, que os dados foram recebidos;
     - Enquanto o deserializador não conseguir enviar os dados, deverá manter o sinal de status_out alto, ou seja, está ocupado;
     - Este módulo deverá funcionar a 100KHz. 

- (2,5) Construção do módulo fila (queue), com tb, observando as seguintes regras: 
     - A fila possui um tamanho fixo de 8 espaços, cada com 8 bits;
     - O sinal len_out deve informar o número de espaços utilizados;
     - Para colocar um elemento na fila, o elemento deverá aparecer no sinal data_in e o sinal enqueue_in deverá estar alto; 
     - Para remover um elemento da fila, o sinal dequeue_in deve ser levantado e, no ciclo subsequente, o dado removido deverá aparecer no sinal data_out; 
     - Este módulo deverá funcionar a 10KHz.

- (2,0) Conexões dos módulos e criação de um módulo top:
     - A cada 8 bits recebidos pelo deserializador, uma palavra de 8 bits deverá ser colocada na pilha;
     - O módulo top deverá receber um sinal de clock de 1MHz;
     - Dois processos internos deverão utilizar o sinal de 1MHz para gerar dois sinais de clock diferentes: um de 100KHz e outro de 10KHz, alimentando os módulos anteriores.

- (1,0) O TB deverá demonstrar que o deserializador trava (ocupado, status_out alto) quando a fila fica cheia (caso ruim).

- (1,0) O TB deverá demonstrar exercitar um cenário onde dados são inseridos no serializador e removidos da fila de forma que a taxa de inserção (e remoção) não cause travamento no deserializador (caso bom) 

- (1,0) Construção do README.md contendo instruções de como executar o projeto e resultados obtidos.
