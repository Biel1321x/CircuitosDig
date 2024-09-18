module PseudoRandomNumberGenerator (
    input logic clk,
    input logic rst,
    output logic [15:0] rand_num
);

    logic [15:0] seed;
    logic [15:0] next_seed;

    // Lógica de atualização da seed
    always_comb begin
        // Realimentação LFSR para calcular o próximo valor da seed
        next_seed = {seed[14:0], seed[0] ^ seed[5] ^ seed[12] ^ seed[15]};
    end

    // Flip-flop para atualizar a seed no ciclo de clock
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            seed <= 16'b0000111100001111; // Inicializa a seed com um valor constante de 16 bits
        else
            seed <= next_seed; // Atualiza a seed com o valor calculado no ciclo anterior
    end

    // Atribui o valor atualizado da seed ao rand_num
    assign rand_num = seed;

endmodule
