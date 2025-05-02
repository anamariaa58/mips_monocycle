`timescale 1ns / 1ps
module ALU(
    input [31:0] AluOp1,//primul operaand,rs
    input [31:0] AluOp2,//al doilea operand,rt
    input [2:0] AluCtrl,
    output Zero,
    output reg [31:0] AluResult
    );
    always @ (*) begin
    case(AluCtrl)
        3'b000: AluResult = AluOp1 & AluOp2; //and
        3'b001: AluResult = AluOp1 | AluOp2; //or
        3'b010: AluResult = AluOp1 + AluOp2; //adunare
        3'b110: AluResult = AluOp1 - AluOp2; //scadere
        3'b111: AluResult = ($signed(AluOp1) < $signed(AluOp2)) ? 1 : 0; //slt
        default: AluResult=32'bz;
    endcase
    end
    assign Zero = (AluResult == 0) ? 1 : 0;
endmodule
