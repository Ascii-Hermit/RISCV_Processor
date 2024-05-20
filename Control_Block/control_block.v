module control_block(
    // the naming and the bits assigned are done in accordance with the base intruction formats
    input [6:0] func7,
    input [2:0] func3,
    input [6:0] opcode,
    output [] reg alu_control,
    output reg write_on_register
);
always@(func7 or func3 or opcode)
begin
    //for all R-type instrcutions, this is the opcode
    // refer the doc for all the mappings
    if(opcode = 7'011011)
    begin
        case(func3)
            0: if(func7=0)
            begin
                alu_control = 4'b0100;
            else if(func7=32)
                alu_control = 4'b0101;
            end

            1: alu_control = 4'b0001;
            2: alu_control = 4'b1010;
            3: alu_control = 4'b1001;
            4: alu_control = 4'b1000;
            5: if(func7=0)
            begin 
                alu_control = 4'b0010;
            else if(func7 = 32)
                alu_control = 4'b0011;
            end

            6: alu_control = 4'b0111;
            7: alu_control = 4'b0110;


        endcase
        
    end
end

    
endmodule