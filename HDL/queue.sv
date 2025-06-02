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
    output logic [7:0] len_out // sinal de 8 bits
);

typedef enum logic [1:0] {
    IDLE,
    ENQ,
    DEQ
    }state_t;

    state_t state;

    full = (len_out == 8);
    empty = (len_out == 0);

   logic [7:0] queue [0:7];
   logic [2:0] head, tail;



always @(posedge clock or posedge reset) begin
    if (reset) begin
    data_in     <= 0;
    enq_in      <= 0;
    deq_in      <= 0;
    data_out    <= 0;
    len_out     <= 0;
    end else begin
        case(state) 

               
            IDLE: begin  
                $display("Entrei no estado IDLE");
               if (enq_in && !full) // Se o sinal enq_in estiver alto e a fila não estiver cheia vai para o estado enqueue
                   state <= ENQ; 
                else if (deq_in && !empty) // Se o sinal deq_in estiver alto e a fila estiver vazia vai apra o estado dequeue
                    state <= DEQ;
                else
                    state <= IDLE; // Se não estiver alto nenhum dos dois sinais repete IDLE
            end

            ENQ: begin
                $display("Entrei no estado ENQ");
                queue[tail] <= data_in; // insere dado na posição aonde tail indica
                tail <= (tail + 1) % 8;    // incrementa circularmente
                len_out <= len_out + 1;
                state <= IDLE;
            end  

            DEQ: begin 
                $display("Entrei no estado DEQ");
                data_out <= queue[head]; // retira dado da posição aonde head indica
                head <= (head + 1) % 8;    // incrementa circularmente
                len_out <= len_out - 1;
                state <= IDLE;
            end

    end

endmodule