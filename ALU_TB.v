`timescale 1ns / 1ps
module ALU_TB();
reg [31:0] AluOp1,AluOp2;
reg [2:0] AluCtrl;
wire ZERO;
wire [31:0] AluResult;

ALU U1(
    .AluOp1(AluOp1),
    .AluOp2(AluOp2),
    .AluCtrl(AluCtrl),
    .Zero(Zero),
    .AluResult(AluResult)
);

initial
begin
    AluOp1=$random; AluOp2=$random; AluCtrl=3'b010; //adunare
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b001; //or
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b000; //and
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b001; //or
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b111; //slt
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b110; //scadere
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b110; //scadere
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b000; //and
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b111; //slt
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b001; //or
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b111; //default
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b110; //scadere
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b010; //adunare
    #10 AluOp1=$random; AluOp2=$random; AluCtrl=3'b111; //slt
end
endmodule