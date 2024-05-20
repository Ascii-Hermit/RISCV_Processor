// Implementation of the data flow between the register block and the ALU unit
`include "ALU/alu.v"
`include "Register/register_block.v"

module datapath (
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [3:0] alu_control,
    input write_on_register,
    input clk,
    input reset,
    output zero_flag
);
//these wires carry the data
wire [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

register_block register_block_instance(
    clk,
    write_on_register,
    reset,
    read_reg1,
    read_reg2,
    write_reg,
    write_data,
    read_data1,
    read_data2
);
ALU alu_instance(read_data1,read_data2,alu_control,write_data,zero_flag);
    
endmodule