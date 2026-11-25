`timescale 1ns/1ps
module tb_exp2_logic_gates;
    reg a, b;
    wire y_and, y_or, y_nand, y_nor, y_xor, y_xnor;
    exp2_logic_gates dut(.*);
    initial begin
        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;
        $finish;
    end
endmodule
