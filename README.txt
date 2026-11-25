XEC706 EXPERIMENTS 1–6 – CORRECTED STARTER PACKAGE

Target FPGA:
  Part: xc7a35tcpg236-1
  Board assumption: Digilent Basys 3-compatible board
  FPGA tool: Xilinx Vivado
  HDL: Verilog

Contents:
  rtl/       Six synthesizable design modules
  testbench/ Simulation testbenches for experiments 2–6
  constraints/ Minimal Basys 3 clock XDC

IMPORTANT HARDWARE NOTES:
1. The Basys 3 has no onboard 16x2 character LCD. Experiment 1 assumes
   an external HD44780-compatible LCD in 4-bit mode. You must wire its
   RS, RW, E, D4-D7, power and contrast correctly. RW may be tied low;
   if so, do not use the lcd_rw output.
2. Do not use guessed LCD package pin assignments. The LCD connector/
   PMOD adapter and wiring determine the correct XDC pin names.
3. Basys 3 clock is 100 MHz. Set CLK_HZ=100000000 in Experiment 1 when
   using the board clock. The module default is 50 MHz.
4. Experiment 3 provides a half-adder design for the Vivado synthesis,
   implementation, placement and routing exercise. Place/route is a
   Vivado implementation flow, not an extra Verilog statement.
5. Experiment 5 is combinational ON/OFF control. It does not blink.
6. Experiment 6 uses a 100 MHz clock. The default parameter toggles the
   LED every 0.5 seconds (1 Hz full on/off cycle). A physical reset
   button or reset circuit must be assigned in the XDC.
7. The testbenches are simulation-only and must not be added as synthesis
   top modules.
8. These RTL modules are syntax-oriented corrected examples; they have
   not been physically tested on your specific board. Verify in Vivado
   and with your actual external wiring before hardware use.

Vivado basic workflow:
  Create Project -> RTL Project -> select xc7a35tcpg236-1
  Add the relevant rtl .v file as Design Source
  For experiments with testbenches, Add Sources -> Add Simulation Sources
  Run Simulation -> Run Behavioral Simulation
  Run Synthesis -> Run Implementation -> Generate Bitstream
  Assign the correct top module and board-specific XDC before programming.

Experiment 1 note:
  The LCD FSM is intended as a teaching implementation. For robust
  hardware operation, a production controller should use explicit
  microsecond timing and separate E setup/hold states. Verify timing
  against the LCD controller datasheet and your clock before use.
