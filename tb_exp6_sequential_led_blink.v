`timescale 1ns/1ps
module tb_exp6_sequential_led_blink;
    reg clk=0, reset=1, enable=0;
    wire led;
    always #5 clk=~clk;
    // Small count for a quick simulation.
    exp6_sequential_led_blink #(.TOGGLE_PERIOD_COUNT(4)) dut(.*);
    initial begin
        #20 reset=0; enable=1;
        #100 enable=0;
        #20 $finish;
    end
endmodule
