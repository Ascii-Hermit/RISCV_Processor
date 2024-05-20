`include "inst_mem.v"

module inst_fetch_unit (
    input clk, reset,
    output [31:0] inst_code,
);

reg [31:0] pc = 32'b0;
inst_mem(pc,reset,inst_code);

always@(posedge clk or posedge reset)
begin
    if(reset == 1)
    begin
        pc <= 32'b0;
    else
        pc <= pc + 4;
    end
end

    
endmodule