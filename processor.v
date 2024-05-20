`include "control_block.v"
`include "datapath.v"
`include "inst_fetch_unit.v"

module processor(
    input clk,
    input reset,
    output zero_flag
);
wire [31:0] inst_code;
wire [3:0] alu_control;
wire write_on_register;

control_block(inst_code[31:25],inst_code[14:12],inst_code[6:0],alu_control,write_on_register);
datapath(inst_code[19:15], inst_code[24:20], inst_code[11:7], alu_control, write_on_register, clk, reset, zero_flag);
inst_fetch_unit(clk,reset,inst_code);

    
endmodule