`timescale 1ns / 1ps
module MUX3x1 #(parameter WIDTH = 32)(
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input [WIDTH-1:0] in2,
    input [1:0] sel,
    output reg [WIDTH-1:0] out
    );
    
    always @(*) begin
        case(sel)
            2'b00: out = in0; // PC_PLUS_4
            2'b01: out = in1; // PC_BRANCH
            2'b10: out = in2; // JUMP
            default: out = {WIDTH{1'bz}};
        endcase
    end
endmodule
