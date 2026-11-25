// Experiment 4: Half adder, full adder, half subtractor, full subtractor.
module half_adder(
    input wire a, b,
    output wire sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule

module full_adder(
    input wire a, b, cin,
    output wire sum, cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module half_subtractor(
    input wire a, b,
    output wire diff, borrow
);
    assign diff   = a ^ b;
    assign borrow = (~a) & b;
endmodule

module full_subtractor(
    input wire a, b, bin,
    output wire diff, bout
);
    assign diff = a ^ b ^ bin;
    assign bout = ((~a) & b) | ((~a) & bin) | (b & bin);
endmodule
