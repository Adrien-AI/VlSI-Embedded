// Experiment 5: Combinational switch-controlled LED.
// This is ON/OFF control, not periodic blinking.
module exp5_combinational_led(
    input  wire sw0,
    input  wire sw1,
    output wire led0,
    output wire led1
);
    assign led0 = sw0;
    assign led1 = sw1;
endmodule
