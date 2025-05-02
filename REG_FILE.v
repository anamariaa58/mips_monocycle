`timescale 1ns / 1ps
module REG_FILE(
    input [4:0] RsAddr, RtAddr, WriteReg,
    input Clk, RegWriteEn,
    input [31:0] WriteData,//val care va fi scrisa
    output [31:0] RegData1, RegData2 //val citite din registri
    );
    reg [31:0] memr [0:31];
    assign RegData1 = memr [RsAddr];
    assign RegData2 = memr [RtAddr];
    
    always @(posedge Clk)
    begin
        if(RegWriteEn) begin
            memr [WriteReg] <= WriteData;
        end
    end
endmodule
