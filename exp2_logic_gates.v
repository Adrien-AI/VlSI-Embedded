// Experiment 2: Six basic logic gates.
module exp2_logic_gates(
    input  wire a, b,
    output wire y_and, y_or, y_nand, y_nor, y_xor, y_xnor
);
    assign y_and  = a & b;
    assign y_or   = a | b;
    assign y_nand = ~(a & b);
    assign y_nor  = ~(a | b);
    assign y_xor  = a ^ b;
    assign y_xnor = ~(a ^ b);
endmodule
