//pt PC+4 si PCBranch
`timescale 1ns / 1ps
module ADD #(parameter WIDTH = 32) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input ci,
    output co,
    output [WIDTH-1:0] sum
    );
    assign {co, sum}= a + b + ci;
endmodule
