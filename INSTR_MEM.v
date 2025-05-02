`timescale 1ns / 1ps
module INSTR_MEM(
    input [31:0] InstrAddr,
    output reg [31:0] InstrOut
    );
    
    reg [31:0] memi [0:255];

    always @(*) begin
        InstrOut = memi[InstrAddr[31:2]];
    end
endmodule
