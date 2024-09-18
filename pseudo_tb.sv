module tb_PseudoRandomNumberGenerator;
    // Parâmetros e sinais
    logic clk;
    logic rst;
    logic [15:0] rand_num;
    int erro;
    logic [15:0] prev_rand_num;

    // Instância do módulo que estamos testando
    RandomNumberGenerator uut (
        .clk(clk),
        .rst(rst),
        .rand_num(rand_num)
    );

    // Gera o clock com um período de 10 unidades de tempo
    always begin
        #5 clk = ~clk; // Inverte o clock a cada 5 unidades de tempo
    end

    // Teste inicial
    initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_RandomNumberGenerator);
        // Inicializa os sinais
        clk = 0;
        rst = 1;
        erro = 0;
        // Reseta o gerador de números
        #10;
        rst = 0;

        // Executa o LFSR por 20 ciclos de clock e imprime os resultados
        prev_rand_num = 16'bx; //iniciar com valor aleatório
        for (int i = 0; i < 20; i++) begin
            #10;
            if (rand_num == prev_rand_num)
                erro = 1;
            prev_rand_num = rand_num;

    if(erro)
        begin
            $display("Erro: valor repetido detectado!");
                
        end else begin
            $display("Sucesso: Nenhum erro detectado!");
        end
    end

        // Finaliza a simulação
        $finish;
    end

endmodule
