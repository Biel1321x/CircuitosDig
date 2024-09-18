module breg(
  //criando nossas variáveis, clock, reset, enable(escrita)
  input logic clk, 
  input logic rst,
  input logic wr_en, 
 //endereço de leitura que iremos escolher para nossos leitores(rd)
  input logic [1:0] add_rd0,
  input logic [1:0] add_rd1,
  //endereço na qual será escrito o valor escolhido no nosso wr_data, ou seja, em qual registrador iremos escrever
  input logic [1:0] add_wr,  
// Nosso input de valor, aqui iremos inserir nosso valor de até 8 bits que iremos escolher em qual registrador armazenar
  input logic [7:0] wr_data,
  // aqui temos nossas duas saidas simultâneas(de até 8 bits), mais á frente ao codigo mostraremos como fazer elas escolherem quais registradores 
  //escolherão ler ao mesmo tempo  
  output logic [7:0] rd0,  
  output logic [7:0] rd1  
);
  //Criando nossos registradores e sua capacidade de dados(8 bits)
  logic [7:0] regist [3:0]; 
  
  always_ff @(posedge clk ,posedge rst)
//Instaciando nosso reset, caso reset for 1, independente do valor, todos os registradores terão sua memória limpa
    begin
      if (rst == 1'b1) begin   
        regist [0] <= 8'b0;
        regist [1] <= 8'b0;
        regist [2] <= 8'b0;
        regist [3] <= 8'b0;
      end
//Aqui instaciamos nosso enable, quando estiver ligado, o registrador escolhido pelo add_write, recebera o valor de dado do nosso wr_data, ou seja. 
//Se nosso registrador 1 for escolhido pelo nosso add_wr, ele recebera o valor de wr_data, isso para todos os registradores
      else if (wr_en == 1'b0)  
        begin
          regist[add_wr] <= wr_data;
        end
    end
  //aqui conectamos nossos leitores de dados, caso estejam ligados eles irão ler o registrador escolhido pelo nosso demultiplexador, e mostrar o resultado. 
 //Com capacidade de leitura de dois registradores simultâneos
  assign rd0 = regist[add_rd0]; 
  assign rd1 = regist[add_rd1]; 
  
endmodule
