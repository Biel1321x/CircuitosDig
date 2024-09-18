module somador_serial(
  input logic A, B, clk, rst,
  output logic S, cout);

  logic carry_in, carry_out, sum;

  // Instanciação do somador completo
  somadorcompleto U1 (
    .a(A),
    .b(B),
    .c(carry_in),   // Carry-in vindo do flip-flop
    .s(sum),
    .cout(carry_out) // Carry-out gerado pelo somador completo
  );

  // Instanciação do flip-flop tipo D para armazenar o carry-out
  ffd U2 (
    .d(carry_out),   // O flip-flop armazena o carry-out
    .rst(rst),
    .clk(clk),
    .q(carry_in)     // A saída do flip-flop é usada como carry-in no próximo ciclo
  );

  // Atribuindo a soma e o carry-out às saídas
  assign S = sum;
  assign cout = carry_out;

endmodule

module somadorcompleto(
  input logic a, b, c,
  output logic s, cout);
  assign s = a ^ b ^ c;
  assign cout = (a & b) | (b & c) | (a & c);
endmodule

module ffd(
  input logic d, rst, clk,
  output logic q);
  always_ff @(posedge clk, posedge rst) begin
    if (rst)
      q <= 1'b0;  // Se reset for 1, zera a saída
    else
      q <= d;     // Caso contrário, armazena o valor de 'd'
  end
endmodule
