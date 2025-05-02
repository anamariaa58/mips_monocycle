`timescale 1ns / 1ps
module MIPS #(parameter WIDTH = 32)(
    input Clk,
    input Rst,
    output [WIDTH-1:0] AluResult,
    output [WIDTH-1:0] PcOut,
    output [WIDTH-1:0] ReadData,//adr pt mem de date
    output [WIDTH-1:0] WriteData,//datele scrise in mem de date
    output [4:0] WriteReg//val care trebuie scrisa in registru
    );
    wire [31:0] AluOp1,AluOp2,DataAddr,InstrOut,nextPC,RegData1,RegData2,InstrExtended,PcPlus4,Pcp,PcBranch,Result,InstrExtendedShift, JumpAddr ;
    wire [5:0] Op,Funct;
    wire [2:0] AluCtrl,PcSel;
    wire IsBne,We,Zero,MemToReg, MemWr, Branch, AluSrc, RegDst, RegWr, PcSrc , co, SignExt, Jump;
    wire ci = 1'b0;
   
    PC PC(
        .Clk(Clk),
        .Rst(Rst),
        .nextPC(nextPC),
        .Pc(PcOut)
    );
    
    INSTR_MEM INSTR_MEM(
        .InstrAddr(PcOut),
        .InstrOut(InstrOut)
    );

    CTRL_UNIT CTRL_UNIT(
        .Op(InstrOut[31:26]),
        .Funct(InstrOut[5:0]),
        .MemToReg(MemToReg),
        .MemWr(MemWr),
        .Branch(Branch),
        .AluSrc(AluSrc),
        .RegDst(RegDst),
        .RegWr(RegWr),
        .AluCtrl(AluCtrl),
        .Jump(Jump),
        .SignExt(SignExt),
        .IsBne(IsBne)
    );
    
     SignExtend SignExtend(
        .Instr(InstrOut[15:0]),
        .SignExt(SignExt),
        .InstrExtended(InstrExtended)
    );
    
     MUX2x1 #(.WIDTH(5)) WR_REG(
    .in0(InstrOut[20:16]),
    .in1(InstrOut[15:11]),
    .sel(RegDst),
    .out(WriteReg)
    );
    
    REG_FILE REG_FILE(
        .RsAddr(InstrOut[25:21]),
        .RtAddr(InstrOut[20:16]),
        .Clk(Clk),
        .RegWriteEn(RegWr),
        .WriteData(Result),
        .RegData1(AluOp1),
        .RegData2(WriteData),
        .WriteReg(WriteReg)
    );
    
     MUX2x1 #(.WIDTH(32)) INALU (
        .in0(WriteData),
        .in1(InstrExtended),
        .sel(AluSrc),
        .out(AluOp2)
    );
    
    ALU ALU(
        .AluOp1(AluOp1),
        .AluOp2(AluOp2),
        .AluCtrl(AluCtrl),
        .Zero(Zero),
        .AluResult(AluResult)
    );
    
    DATA_MEM DATA_MEM(
        .Clk(Clk),
        .We(MemWr),
        .DataAddr(AluResult),
        .DataWriteIn(WriteData),
        .DataWriteOut(ReadData)
    );
    
    MUX2x1 OUTDM(
    .in0(AluResult),
    .in1(ReadData),
    .sel(MemToReg),
    .out(Result)
    );

    ADD PC_plus_4(
        .a(PcOut),
        .b(32'd4),
        .ci(ci),
        .co(co),
        .sum(PcPlus4)
     );
     
     assign InstrExtendedShift = InstrExtended <<2;
     
     ADD PC_Branch(
        .a(InstrExtendedShift),
        .b(PcPlus4),
        .ci(ci),
        .co(co),
        .sum(PcBranch)
     );
     
     assign PcSrc = (IsBne)? (Branch & ~Zero) : (Branch & Zero);
     assign PcSel = (Jump) ? 2'b10 : (PcSrc) ? 2'b01 : 2'b00;
     assign JumpAddr = {PcPlus4[31:28], InstrOut[25:0], 2'b00};//pastrez cei mai semnificativi 4 biti ai PC-ului,instructiunea codificata, aduaug 2 biti de 0 pt a alinia adresa la 4 bytes=shiftat la stanga cu 2
     
     MUX3x1 PC_SELECT(
         .in0(PcPlus4),
         .in1(PcBranch),
         .in2(JumpAddr),
         .sel(PcSel),
         .out(nextPC)
     );
endmodule
