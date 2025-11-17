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
  // retardos y señales para ejecutar primera instrucción (ciclo 1) (j start)
  #10
  s_inc = 0; // Al ser una instrucción j, hay que hacer un salto con una dirección absoluta
  s_inm = 0; // No importa, no se va a escribir nada en el banco
  we3 = 0; // No se escribe nada, no hay que activarlo
  wez = 0; // No hay que escribir el flag de zero
  Op = 3'b000; // No hay operacion
  #10

  // retardos y señales para ejecutar segunda instrucción (ciclo 2) (li #0 R2)
  #10
  s_inc = 1; // No se usan saltos, la siguiente dirección del PC es PC + 1
  s_inm = 1; // Hay que usar un inmediato
  we3 = 1; // Se necesita usar el banco, hay que habilitarlo
  wez = 0; // No se usa el flag de zero
  Op = 3'b000; // No se hay operación 
  #10

  // retardos y señales para ejecutar tercera instrucción (ciclo 3) (li #2 R1)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar cuarta instrucción (ciclo 4) (li #4 R3)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar quintaW instrucción (ciclo 5) (li #1 R4)
  #10
  s_inc = 1;
  s_inm = 1;
  we3 = 1;
  wez = 0;
  Op = 3'b000;
  #10

  // retardos y señales para ejecutar sexta instrucción (ciclo 6) (add R2 R3 R2)
  #10
  s_inc = 1; // Pc + 1
  s_inm = 0; // se usa el resultado de la ALU
  we3 = 1; // Hay que habilitar el banco
  wez = 1; // Actualizamos el flag de zero tras la operación hecha
  Op = 3'b010; // Opcode de add
  #10
  
  // retardos y señales para ejecutar séptima instrucción (ciclo 7) ()
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
