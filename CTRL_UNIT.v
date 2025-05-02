`timescale 1ns / 1ps
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
    6'b000000: begin //instr de tip R
            RegDst = 1;
            RegWr = 1;
        case(Funct)
            6'b100000: AluCtrl = 3'b010; // ADD
            6'b100010: AluCtrl = 3'b110; // SUB
            6'b100100: AluCtrl = 3'b000; // AND
            6'b100101: AluCtrl = 3'b001; // OR
            6'b101010: AluCtrl = 3'b111; // SLT
        endcase
     end
     6'b100011: begin //instr LW
            MemToReg = 1;
            RegDst = 1;
            AluSrc = 1; //foloseste un operand imediat
            RegWr = 1;
            AluCtrl = 3'b010; //pt calculul adresei efective = valoare($rs) + SignExtended
     end
     6'b101011: begin //instr SW
            MemWr = 1;
            AluSrc = 1; 
            AluCtrl = 3'b010;
            SignExt = 1;
            RegWr = 0;
     end
     6'b000100: begin //instr beq, foloseste doar registre
            Branch = 1;
            AluCtrl = 3'b110;
            SignExt = 1;
            RegWr = 0;
            IsBne = 0;
     end
     6'b000101: begin // BNE
                Branch = 1;
                AluCtrl = 3'b110;
                RegWr = 0;
                IsBne = 1;
     end
     6'b001000: begin //addi
                AluSrc = 1;
                RegWr = 1; 
                AluCtrl = 3'b010;
                SignExt = 1;
     end
     6'b001010: begin // SLTI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b111;
                SignExt = 1;
    end
    6'b001101: begin // ORI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b001;
                SignExt = 0;
    end
    6'b001100: begin // ANDI
                AluSrc = 1;
                RegWr = 1;
                AluCtrl = 3'b000;
                SignExt = 0;
    end
    6'b000010: begin // JUMP
                Jump = 1;
    end
    endcase
    end
endmodule
