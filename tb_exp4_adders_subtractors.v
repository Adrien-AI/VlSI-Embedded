`timescale 1ns/1ps
module tb_exp4_adders_subtractors;
    reg a,b,cin,bin;
    wire hs,hc,fs,fc,hd,hb,fd,fb;
    half_adder ha(a,b,hs,hc);
    full_adder fa(a,b,cin,fs,fc);
    half_subtractor hs0(a,b,hd,hb);
    full_subtractor fs0(a,b,bin,fd,fb);
    integer i;
    initial begin
        for (i=0;i<8;i=i+1) begin
            {a,b,cin}=i[2:0];
            bin=i[0];
            #10;
        end
        $finish;
    end
endmodule
