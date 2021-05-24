# FPGA
FPGA for BCD adder, Universal Shift Register, and 3 to 8 decoder

## Details
### Design consist of three files: FPGA.v, configure.mem, and testbench.v
In FPGA.v, only logic tile and switch box are used in verilog. Verilog code is structural, with no dataflow or behavior statements. No other logic or operator is used.\
Number of inputs and outputs in FPGA.v would be maximum of inputs required by your circuits and maximum of outputs required by your circuits. Clock will be additional input.\
Any circuit can be implemented just by changing configuration file. \
There are three separate configuration files.\
testbench.v: Testbench will read the configuration file, and will assign it to your verilog module. \
Testbench will have the testcases for testing circuit not the configurable logic.
