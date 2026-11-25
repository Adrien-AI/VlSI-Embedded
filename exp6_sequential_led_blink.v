// Experiment 6: Sequential LED blinking.
// For Basys 3 100 MHz clock, toggle_period_count=50_000_000
// gives a 0.5 second toggle interval (1 Hz complete blink cycle).
module exp6_sequential_led_blink #(
    parameter integer TOGGLE_PERIOD_COUNT = 50_000_000
)(
    input  wire clk,
    input  wire reset,
    input  wire enable,
    output reg  led
);
    reg [31:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            led <= 1'b0;
        end else if (!enable) begin
            counter <= 0;
            led <= 1'b0;
        end else if (counter == TOGGLE_PERIOD_COUNT - 1) begin
            counter <= 0;
            led <= ~led;
        end else begin
            counter <= counter + 1'b1;
        end
    end
endmodule
