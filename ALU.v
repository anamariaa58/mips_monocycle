`timescale 1ns / 1ps
`include "ALU_def.vh"

module ALU(
    input [31:0] AluOp1,//primul operaand,rs
    input [31:0] AluOp2,//al doilea operand,rt
    input [2:0] AluCtrl,
    output Zero,
    output reg [31:0] AluResult
    );
    always @ (*) begin
    case(AluCtrl)
        `ALU_AND: AluResult = AluOp1 & AluOp2; //and
        `ALU_OR: AluResult = AluOp1 | AluOp2; //or
        `ALU_ADD: AluResult = AluOp1 + AluOp2; //adunare
        `ALU_SUB: AluResult = AluOp1 - AluOp2; //scadere
        `ALU_SLT: AluResult = ($signed(AluOp1) < $signed(AluOp2)) ? 1 : 0; //slt
        default: AluResult=32'bx;
    endcase
    end
    assign Zero = (AluResult == 0) ? 1 : 0;
endmodule
