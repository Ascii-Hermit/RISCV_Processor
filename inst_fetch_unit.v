`include "inst_mem.v"

module inst_fetch_unit (
    input clk, 
    input reset,
    output reg [31:0] inst_code
);

reg [31:0] pc = 32'b0;

// Declare a wire to connect inst_mem output to the register inst_code
wire [31:0] inst_mem_output;

inst_mem inst_mem_instance(pc, reset, inst_mem_output);

always @(posedge clk or posedge reset) begin
    if (reset == 1'b1)
        pc <= 32'b0;
    else
        pc <= pc + 32'b100; // Increment by 4 (assuming 4-byte instructions)
end

// Assign the value of inst_mem_output to inst_code
always @(*) begin
    inst_code = inst_mem_output;
end

endmodule

