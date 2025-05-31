/*

fila:
        - é um container limitado do tipo FIFO de 8 bits;
        - elementos são inserdos através do data_in e enqueue_in;
        - elementos são removidos através do data_out e dequeue_in;
        - o sinal len_out de 8 bits que indica o nº de elementos da fila;
        - quando o sinal dequeue_in sobe, o 1º dado a ser retirado deve aparecer em data_out no próximo ciclo SE o nº de elementos (len_out) for maior que 0.

regras: 
        - A fila possui um tamanho fixo de 8 espaços, cada com 8 bits;
        - O sinal len_out deve informar o número de espaços utilizados;
        - Para colocar um elemento na fila, o elemento deverá aparecer no sinal data_in e o sinal enqueue_in deverá estar alto; 
        - Para remover um elemento da fila, o sinal dequeue_in deve ser levantado e, no ciclo subsequente, o dado removido deverá aparecer no sinal data_out; 
        - Este módulo deverá funcionar a 10KHz.


*/


module queue(
    input logic clock_10, // clock 10KHZ
    input logic reset,

    input logic data_in,
    input logic enq_in,
    input logic deq_in,

    output logic data_out,
    output logic len_out
);

typedef enum logic [1:0] {ENQ, DEQ}


always @(posedge clock or posedge reset) begin
    if (reset) begin
    data_in     <= 0;
    enq_in      <= 0;
    deq_in      <= 0;
    data_out    <= 0;
    len_out     <= 0;
    end else begin
           
            




end


endmodule