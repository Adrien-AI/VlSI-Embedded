// Experiment 3: Half-adder design for synthesis, implementation,
// placement and routing. The implementation flow is performed in Vivado.
module exp3_half_adder(
    input  wire a, b,
    output wire sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
