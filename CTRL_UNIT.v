`timescale 1ns / 1ps
`include "CTRL_def.vh"
`include "ALU_def.vh"
module CTRL_UNIT(
    input [5:0] Op,
    input [5:0] Funct,
    output reg MemToReg, MemWr, Branch, AluSrc, RegDst, RegWr, SignExt, Jump,IsBne,
    output reg [2:0] AluCtrl
    );
    always @(*)
    begin
    MemToReg = 0;
    MemWr = 0; 
    Branch = 0;
    AluSrc = 0;
    RegDst = 0;
    RegWr = 0;
    AluCtrl = 3'b0;
    SignExt = 1;
    Jump = 0;
    IsBne = 0;
    case(Op)
    `OP_R : begin //instr de tip R
            RegDst = 1;
            RegWr = 1;
        case(Funct)
            `FUNCT_ADD: AluCtrl = `ALU_ADD; // ADD
            `FUNCT_SUB: AluCtrl = `ALU_SUB; // SUB
            `FUNCT_AND: AluCtrl = `ALU_AND; // AND
            `FUNCT_OR: AluCtrl = `ALU_OR; // OR
            `FUNCT_SLT: AluCtrl = `ALU_SLT; // SLT
        endcase
     end
     `OP_LW : begin //instr LW
            MemToReg = 1;
            RegDst = 1;
            AluSrc = 1; //foloseste un operand imediat
            RegWr = 1;
            AluCtrl = 3'b010; //pt calculul adresei efective = valoare($rs) + SignExtended
     end
     `OP_SW : begin //instr SW
            MemWr = 1;
            AluSrc = 1; 
            AluCtrl = 3'b010;
            SignExt = 1;
            RegWr = 0;
     end
     `OP_BEQ : begin //instr beq, foloseste doar registre
            Branch = 1;
            AluCtrl = 3'b110;
            SignExt = 1;
            RegWr = 0;
            IsBne = 0;
     end
     `OP_BNE : begin // BNE
                Branch = 1;
                AluCtrl = 3'b110;
                RegWr = 0;
                IsBne = 1;
     end
     `OP_ADDI : begin //addi
                AluSrc = 1;
                RegWr = 1; 
                AluCtrl = 3'b010;
                SignExt = 1;
     end
     `OP_SLTI : begin // SLTI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b111;
                SignExt = 1;
    end
    `OP_ORI : begin // ORI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b001;
                SignExt = 0;
    end
    `OP_ANDI : begin // ANDI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b000;
                SignExt = 0;
    end
    `OP_J : begin // JUMP
                Jump = 1;
    end
    endcase
    end
endmodule
