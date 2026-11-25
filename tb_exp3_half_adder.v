`timescale 1ns/1ps
module tb_exp3_half_adder;
    reg a,b;
    wire sum,carry;
    exp3_half_adder dut(.*);
    initial begin
        {a,b}=2'b00; #10;
        {a,b}=2'b01; #10;
        {a,b}=2'b10; #10;
        {a,b}=2'b11; #10;
        $finish;
    end
endmodule
