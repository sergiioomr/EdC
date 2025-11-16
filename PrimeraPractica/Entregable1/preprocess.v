module preprocess(output wire [3:0] AMod, output wire [3:0] BMod, input wire [3:0] A, input wire [3:0] B, input wire [2:0] Op);
    // Declarar los cables internos
    wire [3:0] out_mux1, out_mux2;
    wire add1, op1_A, op2_B, cpl;

    // Hacer una asignación continua a las señales de los multiplexores, calculadas reduciendo sus funciones
    assign add1 = 4'b0001;
    assign op1_A = Op[2] | (~Op[1] & ~Op[0]);
    assign op2_B = Op[2] | (~Op[1] & ~Op[0]) | (Op[1] & Op[0]);
    assign cpl = ~Op[2] & Op[1];


    // Implementar los multiplexores y el complementador
    mux2_4 mux1(out_mux1, 4'b0000, 4'b0001, add1);

    mux2_4 mux2(out_mux2, A, B, op2_B);

    mux2_4 mux3(AMod, out_mux1, A, op1_A);

    compl1 complementador(BMod, out_mux2, cpl);


endmodule