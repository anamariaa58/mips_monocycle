`timescale 1ns / 1ps
module MUX2x1 #(parameter WIDTH = 32)(
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input sel,
    output reg [WIDTH-1:0] out
    );
   always @(*) begin
   case(sel)
   0: out = in0;
   1: out = in1;
   default : out = {WIDTH{1'bz}};
   endcase
   end
endmodule
