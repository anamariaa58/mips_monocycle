//PC tine evidenta adresei instr curente si trebuie actualizat la fiecare ciclu de ceas
`timescale 1ns / 1ps
module PC(
    input Clk,
    input Rst,
    input [31:0] nextPC,
    output reg [31:0] Pc
    );
    always @(posedge Clk or posedge Rst)
    begin
        if(Rst)
            Pc <= 32'b0;
        else
            Pc <= nextPC;
    end
endmodule
