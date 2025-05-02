`timescale 1ns / 1ps
module PC_TB;
    reg Clk, Rst;
    reg [31:0] nextPC;
    wire [31:0] Pc;

    PC dut (
        .Clk(Clk),
        .Rst(Rst),
        .nextPC(nextPC),
        .Pc(Pc)
    );

    always #5 Clk = ~Clk;

    initial begin
        Clk = 0; Rst = 1; nextPC = 32'd0;
        #10 Rst = 0;
        nextPC = 32'd4;
        #10 nextPC = 32'd8;
        #10 nextPC = 32'd12;
        #10 $finish;
    end
endmodule
