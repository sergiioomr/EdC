module microc(output wire [5:0] Opcode, output wire z, input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] Op);
  //Microcontrolador sin memoria de datos de un solo ciclo

  // Construir el PC con sus respectivos cables
  wire [9:0] nuevo_pc, pc_actual;
  registro #(10) PC(pc_actual, clk, reset, nuevo_pc);

  // Memoria de programa, con sus cables de entrada y salida
  wire [15:0] salida_mem_programa;
  memprog memoria_programa(salida_mem_programa, clk, pc_actual);

  // Mux que elige el nuevo PC
  wire [9:0] dir_salto = salida_mem_programa[9:0];
  wire [9:0] salida_sumador;
  mux2 #(10) mux_nuevo_pc(nuevo_pc, dir_salto, salida_sumador, s_inc);

  // Sumador simple que incrementa el PC
  sum sumador(salida_sumador,pc_actual, 10'b0000000001);

  // Banco de registros
  wire [3:0] RA1 = salida_mem_programa[11:8];
  wire [3:0] RA2 = salida_mem_programa[7:4];
  wire [3:0] WA3 = salida_mem_programa[3:0];
  wire [7:0] RD1, RD2, WD3;
  regfile banco_registros(RD1, RD2, clk, we3, RA1, RA2, WA3, WD3);

  // Alu
  wire [7:0] salida_alu;
  wire flag_zero;
  wire [2:0] op_alu = Opcode[2:0];
  alu Alu(salida_alu, flag_zero, RD1, RD2, op_alu);


  // Multiplexor para que decide el dato que entra al banco de registros
  wire [7:0] inmediato = salida_mem_programa[11:4];
  mux2 #(8) multiplexor_derecha(WD3, inmediato, salida_alu, s_inm);

  // Flip Flop que guarda el flag de zero
  ffd ffz(clk, reset, flag_zero, wez, z);
  
  assign Opcode = salida_mem_programa[15:10];
endmodule
