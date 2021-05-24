// Code your design here
// Entry Number : 2019CSB1095
// Lab 5: 1095 % 7 + 1 = 4
// 3 to 8 line decoder
// Lab 6: (1095%1)+1, (1095%1)+6, 4 = 1, 7, 4
// 3 to 8 line decoder + BCD Adder + Universal Shift Register

// logic_tile and switch_box_4x4 used directly from lab 4

module logic_tile(out, clock, in1, in2, in3, in4, in5);
  
  // mem is the configuration provided in testbench
  
  reg [32:0] mem;

  // for mux_control (mem[32]) and LUT (mem[31:0])
  
  input in1, in2, in3, in4, in5, clock;
  output out;
  
  // look up table
  
  reg lut_out;
  
  always @(in1, in2, in3, in4, in5, mem) begin
    case ({in5, in4, in3, in2, in1})
      5'b00000: lut_out = mem[0];
      5'b00001: lut_out = mem[1];
      5'b00010: lut_out = mem[2];
      5'b00011: lut_out = mem[3];
      5'b00100: lut_out = mem[4];
      5'b00101: lut_out = mem[5];
      5'b00110: lut_out = mem[6];
      5'b00111: lut_out = mem[7];
      5'b01000: lut_out = mem[8];
      5'b01001: lut_out = mem[9];
      5'b01010: lut_out = mem[10];
      5'b01011: lut_out = mem[11];
      5'b01100: lut_out = mem[12];
      5'b01101: lut_out = mem[13];
      5'b01110: lut_out = mem[14];
      5'b01111: lut_out = mem[15];
      5'b10000: lut_out = mem[16];
      5'b10001: lut_out = mem[17];
      5'b10010: lut_out = mem[18];
      5'b10011: lut_out = mem[19];
      5'b10100: lut_out = mem[20];
      5'b10101: lut_out = mem[21];
      5'b10110: lut_out = mem[22];
      5'b10111: lut_out = mem[23];
      5'b11000: lut_out = mem[24];
      5'b11001: lut_out = mem[25];
      5'b11010: lut_out = mem[26];
      5'b11011: lut_out = mem[27];
      5'b11100: lut_out = mem[28];
      5'b11101: lut_out = mem[29];
      5'b11110: lut_out = mem[30];
      5'b11111: lut_out = mem[31];
      default: lut_out = 1'bx;
    endcase
  end
  
  
  // flip flop
  
  reg flipflop_out;
  
  always @(posedge clock) begin
    flipflop_out <= lut_out;
  end
  

  // mux
  // 0 corresponds to combinational (without flip flop)
  // 1 corresponds to synchronous (with flip flop)
  
  reg out;
  
  always @(*) begin
    case ({mem[32]})
      1'b0: out = lut_out;
      1'b1: out = flipflop_out;
      default: out = 1'bx;
    endcase
  end
    
    
endmodule
        
  
  
module switch_box_4x4(out, in);
  
  input [3:0] in;
  output [3:0] out;

  // configure is the configuration provided in testbench

  
  reg [15:0] configure;
  
  assign out[0] = (in[0] & configure[0]) | (in[1] & configure[1]) | (in[2] & configure[2]) | (in[3] & configure[3]);

  assign out[1] = (in[0] & configure[4]) | (in[1] & configure[5]) | (in[2] & configure[6]) | (in[3] & configure[7]);

  assign out[2] = (in[0] & configure[8]) | (in[1] & configure[9]) | (in[2] & configure[10]) | (in[3] & configure[11]);

  assign out[3] = (in[0] & configure[12]) | (in[1] & configure[13]) | (in[2] & configure[14]) | (in[3] & configure[15]);


endmodule



module lab6(out, prev, in1, in2, in3, clock); //all out and in are 4 bits

  input [3:0] in1, in2, in3;
  input clock;
  input [7:0] prev;

  output [7:0] out;

//   reg [7:0] out;

  wire l0;
  wire t0, t1;

  assign t0 = 1'b0;
  assign t1 = 1'b0;

  wire [7:0] w1;

  wire [3:0] cs3;

//   logic_tile lt0a(.out(out[0]), .clock(clock), .in1(1'b0), .in2(in3[0]), .in3(in3[1]), .in4(in3[2]), .in5(1'b0));
  logic_tile lt0a(w1[0], clock, prev[0], in3[0], in3[1], in3[2], prev[1]);
  logic_tile lt1a(w1[1], clock, prev[1], prev[0], in3[1], in3[2], prev[2]);
  logic_tile lt2a(w1[2], clock, prev[2], prev[1], in3[1], in3[2], prev[3]);
  logic_tile lt3a(w1[3], clock, prev[3], prev[2], in3[1], in3[2], prev[4]);
  logic_tile lt4a(w1[4], clock, prev[4], prev[3], in3[1], in3[2], prev[5]);
  logic_tile lt5a(w1[5], clock, prev[5], prev[4], in3[1], in3[2], prev[6]);
  logic_tile lt6a(w1[6], clock, prev[6], prev[5], in3[1], in3[2], prev[7]);
  logic_tile lt7a(w1[7], clock, prev[7], prev[6], in3[1], in3[2], 1'b0);

  logic_tile lt0b(out[0], clock, in1[0], in1[1], w1[0], 1'b0, in3[3]);
  logic_tile lt1b(out[1], clock, in1[1], in1[0], w1[1], w1[0], in3[3]);
  logic_tile lt2b(cs3[0], clock, in1[2], in1[3], w1[2], 1'b0, in3[3]);
  logic_tile lt3b(out[3], clock, in1[3], in1[2], w1[3], w1[2], in3[3]);
  logic_tile lt4b(cs3[1], clock, in2[0], in2[1], w1[4], 1'b0, in3[3]);
  logic_tile lt5b(out[5], clock, in2[1], in2[0], w1[5], w1[4], in3[3]);
  logic_tile lt6b(cs3[2], clock, in2[2], in2[3], w1[6], 1'b0, in3[3]);
  logic_tile lt7b(cs3[3], clock, in2[3], in2[2], w1[7], w1[6], in3[3]);
  //assign out[0] = l0;
//   assign out[1] = l0;

  logic_tile s1(out[2], clock, 1'b0, cs3[0], cs3[1], cs3[2], cs3[3]);
  logic_tile s2(out[4], clock, 1'b0, cs3[0], cs3[1], cs3[2], cs3[3]);
  logic_tile s3(out[6], clock, 1'b0, cs3[0], cs3[1], cs3[2], cs3[3]);
  logic_tile co(out[7], clock, 1'b0, cs3[0], cs3[1], cs3[2], cs3[3]);


endmodule

