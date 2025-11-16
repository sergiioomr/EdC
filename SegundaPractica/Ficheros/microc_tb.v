`timescale 1 ns / 10 ps
module microc_tb;

// declaración de variables
reg clk = 0;
reg reset = 1;
reg s_inc = 0;
reg s_inm = 0;
reg we3 = 0;
reg wez = 0;
reg [2:0] Op = 3'b000;

wire [5:0] Opcode;
wire z;


// instanciación del camino de datos
microc cpu(Opcode, z, clk, reset, s_inc, s_inm, we3, wez, Op);

// generación de reloj clk
always 
begin
  clk = 1'b1;
  #10;
  clk = 1'b0;
  #10;
end

// Reseteo y configuración de salidas del testbench
initial
begin
  $dumpfile("microc_tb.vcd");
  $dumpvars;

  reset = 1; 
  s_inc = 0;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;

  #15;
  reset = 0;
end


// Bloque simulación señales control por ciclo
initial
begin
  // retardos y señales para ejecutar primera instrucción (ciclo 1)
  #10
  s_inc = 0;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar segunda instrucción (ciclo 2)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar tercera instrucción (ciclo 3)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar cuarta instrucción (ciclo 4)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar quintaW instrucción (ciclo 5)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar sexta instrucción (ciclo 6)
  #10
  s_inc = 1;
  s_inm = 0;
  we3 = 1;
  wez = 1;
  Op = 3'b010;
  #10
  
  // retardos y señales para ejecutar séptima instrucción (ciclo 7)
  #10
  s_inc = 1;
  s_inm = 0;
  we3 = 1;
  wez = 1;
  Op = 3'b011;
  #10

  // retardos y señales para ejecutar octava instrucción (ciclo 8)
  #10
  s_inc = 0;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar novena instrucción (ciclo 9)
  #10
  s_inc = 1;
  s_inm = 0;
  we3 = 1;
  wez = 1;
  Op = 3'b010;
  #10

  // retardos y señales para ejecutar décima instrucción (ciclo 10)
  #10
  s_inc = 1;
  s_inm = 0;
  we3 = 1;
  wez = 1;
  Op = 3'b011;
  #10

  // retardos y señales para ejecutar undécima instrucción (ciclo 11)
  #10
  s_inc = 1;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar duodécima instrucción (ciclo 12)
  #10
  s_inc = 0;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar la instrucción número 13 (ciclo 13)
    #10
  s_inc = 0;
  s_inm = 0;
  we3 = 0;
  wez = 0;
  Op = 3'b000;
  #10

  $finish;
end

endmodule
