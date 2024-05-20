module control_block(
    // the naming and the bits assigned are done in accordance with the base intruction formats
    input [6:0] func7,
    input [2:0] func3,
    input [6:0] opcode,
    output reg [3:0] alu_control,
    output reg write_on_register
);
always@(func7 or func3 or opcode)
begin
    //for all R-type instrcutions, this is the opcode
    // refer the doc for all the values of the parameters
    if(opcode == 7'b011011)
    begin
        case(func3)
            3'b000: begin // func3 == 000
                if (func7 == 7'b0000000) // func7 == 0
                    alu_control = 4'b0100;
                else if (func7 == 7'b1000000) // func7 == 32
                    alu_control = 4'b0101;
            end

            3'b001: alu_control = 4'b0001;
            3'b010: alu_control = 4'b1010;
            3'b011: alu_control = 4'b1001;
            3'b100: alu_control = 4'b1000;
            3'b101: begin // func3 == 101
                if (func7 == 7'b0000000) // func7 == 0
                    alu_control = 4'b0010;
                else if (func7 == 7'b1000000) // func7 == 32
                    alu_control = 4'b0011;
            end

            3'b110: alu_control = 4'b0111;
            3'b111: alu_control = 4'b0110;
        endcase
        
    end
end

    
endmodule