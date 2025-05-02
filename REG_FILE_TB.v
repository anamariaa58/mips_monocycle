`timescale 1ns / 1ps

module REG_FILE_TB;
    reg [4:0] RsAddr, RtAddr, WriteReg;
    reg Clk, RegWriteEn;
    reg [31:0] WriteData;
    wire [31:0] RegData1, RegData2;
    
    REG_FILE dut (
        .RsAddr(RsAddr),
        .RtAddr(RtAddr),
        .WriteReg(WriteReg),
        .Clk(Clk),
        .RegWriteEn(RegWriteEn),
        .WriteData(WriteData),
        .RegData1(RegData1),
        .RegData2(RegData2)
    );

    initial begin
        Clk = 0;
        forever #10 Clk = ~Clk;
    end

    initial begin
        // Ini?ializare semnale
        RegWriteEn = 0;
        WriteData = 32'hA5A5A5A5;//aceasta valoare o scriu la adr 5
        WriteReg = 5'd5;//scriu la adresa 5
        RsAddr = 5'd5;//vreau sa citesc ce este la adresa 5
        RtAddr = 5'd0;

        // Scrierea în registrul 5
        #10 RegWriteEn = 1;
        #10 RegWriteEn = 0;

    end
endmodule
