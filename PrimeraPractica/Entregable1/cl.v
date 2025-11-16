module cl(output wire out, input wire a, b, input wire [1:0] S);
    wire sa, so, sx, sn;

    and and1(sa, a, b);
    or or1(so, a, b);
    xor xor1(sx, a, b);
    not not1(sn, a);
    mux4_1 mux(out, sa, so, sx, sn, S);

endmodule
