`include "processor.v"

module processor_tb ();
    reg clk;
    reg reset;
    wire zero_flag;

    processor processor_instance(clk,reset,zero_flag);

    initial 
    begin
        $dumpfile("output_wave.vcd");
        $dumpvars(0,processor_tb);        
    end

    initial
    begin
        clk = 0;
        forever 
        begin
            #20 clk = ~clk;            
        end
    end

    initial
    begin
        reset = 1;
        #50 reset = 0;
    end
    
    initial
    #300 $finish;
endmodule