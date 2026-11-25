`timescale 1ns/1ps
module tb_exp5_combinational_led;
    reg sw0,sw1;
    wire led0,led1;
    exp5_combinational_led dut(.*);
    initial begin
        sw0=0; sw1=0; #10;
        sw0=0; sw1=1; #10;
        sw0=1; sw1=0; #10;
        sw0=1; sw1=1; #10;
        $finish;
    end
endmodule
