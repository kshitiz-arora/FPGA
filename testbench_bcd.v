// Code your design here
// Entry Number : 2019CSB1095
// Lab 5: 1095 % 7 + 1 = 4
// 3 to 8 line decoder
// Lab 6: (1095%1)+1, (1095%1)+6, 4 = 1, 7, 4
// 3 to 8 line decoder + BCD Adder + Universal Shift Register

module lab6_tb();
  
  // initializing clock [T = 20] till t = 1000
  
  reg clock;
  
  initial
    clock = 1'b0;

  always
    #10 clock = !clock;

  initial
    #1000 $finish;
  
  
  // input form "configuration.mem" file
  
  reg [31:0]memory[42:0]; // array of size three, each entry of 32 bits
  initial begin
    $readmemh("conf_bcd.mem", memory);
  end

  reg [3:0] rin1, rin2, rin3;
  wire [7:0] wout;

  reg [7:0] retain;

  initial 
    retain = 8'b10110011;
  always
    #20 retain = wout;
    

  lab6 inst_l6(.out(wout), .prev(retain), .in1(rin1), .in2(rin2), .in3(rin3), .clock(clock));
    initial
      begin


        // inst_l6.sb1.configure = {memory[0][15:0]};
        // inst_l6.sb2.configure = {memory[1][15:0]};
        // inst_l6.sb3.configure = {memory[2][15:0]};

        // inst_l6.s1b.configure = {memory[1][15:0]};
        // inst_l6.s2b.configure = {memory[2][15:0]};
        
        inst_l6.lt0a.mem = {memory[4][0], memory[3][31:0]};
        inst_l6.lt1a.mem = {memory[6][0], memory[5][31:0]};
        inst_l6.lt2a.mem = {memory[8][0], memory[7][31:0]};
        inst_l6.lt3a.mem = {memory[10][0], memory[9][31:0]};
        inst_l6.lt4a.mem = {memory[12][0], memory[11][31:0]};
        inst_l6.lt5a.mem = {memory[14][0], memory[13][31:0]};
        inst_l6.lt6a.mem = {memory[16][0], memory[15][31:0]};
        inst_l6.lt7a.mem = {memory[18][0], memory[17][31:0]};
        

        inst_l6.lt0b.mem = {memory[20][0], memory[19][31:0]};
        inst_l6.lt1b.mem = {memory[22][0], memory[21][31:0]};
        inst_l6.lt2b.mem = {memory[24][0], memory[23][31:0]};
        inst_l6.lt3b.mem = {memory[26][0], memory[25][31:0]};
        inst_l6.lt4b.mem = {memory[28][0], memory[27][31:0]};
        inst_l6.lt5b.mem = {memory[30][0], memory[29][31:0]};
        inst_l6.lt6b.mem = {memory[32][0], memory[31][31:0]};
        inst_l6.lt7b.mem = {memory[34][0], memory[33][31:0]};
        

        inst_l6.s1.mem = {memory[36][0], memory[35][31:0]};
        inst_l6.s2.mem = {memory[38][0], memory[37][31:0]};
        inst_l6.s3.mem = {memory[40][0], memory[39][31:0]};
        inst_l6.co.mem = {memory[42][0], memory[41][31:0]};
        

        rin1 = 4'b0011; // {B1, A1, B0, A0} 
        rin2 = 4'b0011; // {B3, A3, B2, A2}
        rin3 = 4'b0000; // {0, 0, 0, cin}
        #25
        $display("A: %b%b%b%b  B: %b%b%b%b  Cin: %b", 
        rin2[2], rin2[0], rin1[2], rin1[0], 
        rin2[3], rin2[1], rin1[3], rin1[1],
        rin3[0]);
        $display("Carry: %b  Sum: %b%b%b%b",
        wout[7], wout[6], wout[4], wout[2], wout[0]);

        rin1 = 4'b0011; // {B1, A1, B0, A0} 
        rin2 = 4'b0000; // {B3, A3, B2, A2}
        rin3 = 4'b0000; // {0, 0, 0, cin}
        #25
        $display("A: %b%b%b%b  B: %b%b%b%b  Cin: %b", 
        rin2[2], rin2[0], rin1[2], rin1[0], 
        rin2[3], rin2[1], rin1[3], rin1[1],
        rin3[0]);
        $display("Carry: %b  Sum: %b%b%b%b",
        wout[7], wout[6], wout[4], wout[2], wout[0]);

        rin1 = 4'b1111; // {B1, A1, B0, A0} 
        rin2 = 4'b0011; // {B3, A3, B2, A2}
        rin3 = 4'b0001; // {0, 0, 0, cin}
        #25
        $display("A: %b%b%b%b  B: %b%b%b%b  Cin: %b", 
        rin2[2], rin2[0], rin1[2], rin1[0], 
        rin2[3], rin2[1], rin1[3], rin1[1],
        rin3[0]);
        $display("Carry: %b  Sum: %b%b%b%b",
        wout[7], wout[6], wout[4], wout[2], wout[0]);

        rin1 = 4'b0011; // {B1, A1, B0, A0} 
        rin2 = 4'b1100; // {B3, A3, B2, A2}
        rin3 = 4'b0001; // {0, 0, 0, cin}
        #25
        $display("A: %b%b%b%b  B: %b%b%b%b  Cin: %b", 
        rin2[2], rin2[0], rin1[2], rin1[0], 
        rin2[3], rin2[1], rin1[3], rin1[1],
        rin3[0]);
        $display("Carry: %b  Sum: %b%b%b%b",
        wout[7], wout[6], wout[4], wout[2], wout[0]);

      end
      
  initial
    begin
      $dumpfile("wave_l6_bcd.vcd");
      $dumpvars;
    end

endmodule