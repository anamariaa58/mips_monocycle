`timescale 1ns / 1ps

module MIPS_TB;
    reg Clk;
    reg Rst;
    
    wire [31:0] AluResult;
    wire [31:0] WriteData;
    wire [31:0] ReadData;
    wire [4:0]  WriteReg;
    wire [31:0] PcOut;

    // Instan?ierea MIPS
    MIPS dut (
        .Clk(Clk),
        .Rst(Rst),
        .AluResult(AluResult),
        .WriteData(WriteData),
        .ReadData(ReadData),
        .WriteReg(WriteReg),
        .PcOut(PcOut)
    );


    always #5 Clk = ~Clk;

    initial begin
        Clk = 0;
        Rst = 1;
        #10 Rst = 0;
        $readmemb("instr.mem", dut.INSTR_MEM.memi);
        $readmemb("data_mem.mem", dut.DATA_MEM.memd);
        dut.REG_FILE.memr[8] = 7; // $t0
        dut.REG_FILE.memr[9] = 7; // $t1
        $monitor("PC=%0d | Instr=%h | RegDst=%b | RegWr=%b | AluSrc=%b | ALUOp=%b | ALURes=%d | WriteReg=%d | WriteData=%d | ReadData=%d | Zero=%b | PcSrc=%b | Jump=%b",  
         dut.PcOut, 
         dut.InstrOut, 
         dut.RegDst, 
         dut.RegWr, 
         dut.AluSrc, 
         dut.AluCtrl, 
         dut.AluResult, 
         dut.WriteReg, 
         dut.WriteData, 
         dut.ReadData, 
         dut.Zero, 
         dut.PcSrc, 
         dut.Jump);

        #500;
        $finish;
        end
endmodule
