`timescale 1ns / 1ps
module SignExtend(
    input [15:0] Instr,
    input SignExt, //1-semn, 0-zero
    output [31:0] InstrExtended
    );
     //assign INSTR_EXTENDED = {{16{INSTR[15]}}, INSTR};
   assign InstrExtended = (SignExt) ? {{16{Instr[15]}}, Instr} : {16'b0, Instr};//extinde semnul pe 16 biti
endmodule
