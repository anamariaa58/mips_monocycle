`timescale 1ns / 1ps
module DATA_MEM(
    input Clk,
    input We,
    input [31:0] DataAddr, DataWriteIn,
    output reg [31:0] DataWriteOut
    );
    reg [31:0] memd [0:255]; 
    always @(posedge Clk)
    begin
        if(We) begin
            memd [DataAddr] <= DataWriteIn;
       end
    end
    always @(*) begin
        DataWriteOut <= memd [DataAddr];
    end
endmodule
