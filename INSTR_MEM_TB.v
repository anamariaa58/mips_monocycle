`timescale 1ns / 1ps
module INSTR_MEM_TB();
reg [31:0] InstrAddr;
wire [31:0] InstrOut;

INSTR_MEM DUT(
    .InstrAddr(InstrAddr),
    .InstrOut(InstrOut)
);
initial
begin
    InstrAddr = 0;
    #10
    InstrAddr = 4;
    #10
    InstrAddr = 8;
end
endmodule
