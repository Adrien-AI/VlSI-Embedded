// Experiment 1: 16x2 LCD controller, 4-bit interface.
// Assumes 50 MHz input clock and an external HD44780-compatible LCD.
// lcd_data[3:0] connects to LCD D4-D7 respectively.
module exp1_lcd_16x2 #(
    parameter integer CLK_HZ = 50_000_000
)(
    input  wire       clk,
    input  wire       reset,
    output reg        lcd_rs,
    output reg        lcd_rw,
    output reg        lcd_e,
    output reg [3:0]  lcd_data
);
    localparam integer T_1MS = CLK_HZ / 1000;
    reg [31:0] wait_count;
    reg [5:0] step;
    reg [3:0] nibble;
    reg       rs_value;
    reg       busy;

    // State sequence sends initialization commands and two text lines:
    // "VLSI LAB" and "ARTIX-7 FPGA".
    // Each byte is sent as high nibble then low nibble.
    reg [7:0] char_byte;
    reg [5:0] char_index;
    reg [1:0] phase;
    reg [31:0] delay_ticks;

    function [7:0] message_byte;
        input [5:0] idx;
        begin
            case (idx)
                0: message_byte="V"; 1: message_byte="L";
                2: message_byte="S"; 3: message_byte="I";
                4: message_byte=" "; 5: message_byte="L";
                6: message_byte="A"; 7: message_byte="B";
                8: message_byte=8'hC0; // DDRAM second line address
                9: message_byte="A"; 10: message_byte="R";
                11: message_byte="T"; 12: message_byte="I";
                13: message_byte="X"; 14: message_byte="-";
                15: message_byte="7"; 16: message_byte=" ";
                17: message_byte="F"; 18: message_byte="P";
                19: message_byte="G"; 20: message_byte="A";
                default: message_byte=8'h20;
            endcase
        end
    endfunction

    // Waits are counted in CLK_HZ/1000 ticks per millisecond.
    // LCD E is pulsed for one clock interval after each nibble is placed.
    always @(posedge clk) begin
        if (reset) begin
            wait_count <= 0;
            step <= 0;
            char_index <= 0;
            phase <= 0;
            lcd_rs <= 0;
            lcd_rw <= 0;
            lcd_e <= 0;
            lcd_data <= 0;
            busy <= 1;
        end else begin
            if (wait_count != 0) begin
                wait_count <= wait_count - 1;
                lcd_e <= 0;
            end else begin
                case (step)
                    // HD44780 4-bit initialization sequence
                    0: begin lcd_rs<=0; lcd_data<=4'h3; lcd_e<=1; wait_count<=T_1MS*5; step<=1; end
                    1: begin lcd_data<=4'h3; lcd_e<=1; wait_count<=T_1MS; step<=2; end
                    2: begin lcd_data<=4'h3; lcd_e<=1; wait_count<=T_1MS; step<=3; end
                    3: begin lcd_data<=4'h2; lcd_e<=1; wait_count<=T_1MS; step<=4; end
                    4: begin lcd_data<=4'h2; lcd_e<=1; wait_count<=T_1MS; step<=5; end
                    5: begin lcd_data<=4'h8; lcd_e<=1; wait_count<=T_1MS; step<=6; end // 2-line, 5x8
                    6: begin lcd_data<=4'h0; lcd_e<=1; wait_count<=T_1MS; step<=7; end
                    7: begin lcd_data<=4'hC; lcd_e<=1; wait_count<=T_1MS; step<=8; end // display on
                    8: begin lcd_data<=4'h0; lcd_e<=1; wait_count<=T_1MS; step<=9; end
                    9: begin lcd_data<=4'h1; lcd_e<=1; wait_count<=T_1MS*2; step<=10; end // clear
                    10: begin
                        if (char_index < 21) begin
                            char_byte <= message_byte(char_index);
                            phase <= 0;
                            step <= 11;
                        end else begin
                            step <= 12;
                        end
                    end
                    11: begin
                        if (char_index == 8) begin
                            lcd_rs <= 0;
                            lcd_data <= 4'hC;
                            lcd_e <= 1;
                            wait_count <= T_1MS;
                            char_index <= char_index + 1;
                            step <= 10;
                        end else if (phase == 0) begin
                            lcd_rs <= 1;
                            lcd_data <= char_byte[7:4];
                            lcd_e <= 1;
                            wait_count <= T_1MS;
                            phase <= 1;
                        end else begin
                            lcd_rs <= 1;
                            lcd_data <= char_byte[3:0];
                            lcd_e <= 1;
                            wait_count <= T_1MS;
                            char_index <= char_index + 1;
                            step <= 10;
                        end
                    end
                    12: begin
                        lcd_e <= 0;
                        busy <= 0;
                    end
                    default: begin lcd_e<=0; step<=0; end
                endcase
            end
        end
    end
endmodule
