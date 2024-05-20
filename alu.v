`include "alu_defs.v"
module ALU (
    input [31:0] inp1, 
    input [31:0] inp2,
    input [3:0] alu_control,
    output reg [31:0] alu_result,
    output reg zero_flag
);
always @(*) begin
    case(alu_control)
        `ALU_SHIFTL: 
        begin
            if(inp2[0] == 1'b1)
                alu_result = {inp1[30:0],1'b0};
            else if(inp2[1] == 1'b1)
                alu_result = {inp1[29:0],2'b00};
            else if(inp2[2] == 1'b1)
                alu_result = {inp1[27:0],4'b0000};
            else if(inp2[3] == 1'b1)
                alu_result = {inp1[23:0],8'b00000000};
            else if(inp2[4] == 1'b1)
                alu_result = {inp1[15:0],16'b0000000000000000};
            else
                alu_result = inp1;
        end

        `ALU_SHIFTR: //this is the one that does not add the 1 in the MSB
        begin
            if(inp2[0] == 1'b1)
                alu_result = {1'b0,inp1[31:1]};
            else if(inp2[1] == 1'b1)
                alu_result = {2'b00,inp1[31:2]};
            else if(inp2[2] == 1'b1)
                alu_result = {4'b0000,inp1[31:4]};
            else if(inp2[3] == 1'b1)
                alu_result = {8'b00000000,inp1[31:8]};
            else if(inp2[4] == 1'b1)
                alu_result = {16'b0000000000000000,inp1[31:16]};
            else
                alu_result = inp1;
        end

        `ALU_SHIFTR_ARITH: //this is the one that adds the 1 in the MSB
        begin
            if(inp2[0] == 1'b1)
                alu_result = {1'b1,inp1[31:1]};
            else if(inp2[1] == 1'b1)
                alu_result = {2'b11,inp1[31:2]};
            else if(inp2[2] == 1'b1)
                alu_result = {4'b1111,inp1[31:4]};
            else if(inp2[3] == 1'b1)
                alu_result = {8'b11111111,inp1[31:8]};
            else if(inp2[4] == 1'b1)
                alu_result = {16'b1111111111111111,inp1[31:16]};
            else
                alu_result = inp1;
        end
        `ALU_ADD: alu_result = inp1 + inp2;
        `ALU_SUB: alu_result = inp1 - inp2;
        `ALU_AND: alu_result = inp1 & inp2;
        `ALU_OR: alu_result = inp1 | inp2;
        `ALU_XOR: alu_result = inp1 ^ inp2;
        `ALU_LESS_THAN: alu_result = (inp1 < inp2)?32'b1:32'b0;
        `ALU_LESS_THAN_SIGNED: 
        begin
            if (inp1[31] != inp2[31])
                alu_result  = inp1[31] ? 32'h1 : 32'h0;
            else
                alu_result  = (inp1 - inp2) ? 32'h1 : 32'h0;            
        end
         default: alu_result = inp1;

    endcase
    begin
    if(alu_result == 0)
        zero_flag = 1'b1;
    else 
        zero_flag = 1'b0;
    end    
end  
endmodule