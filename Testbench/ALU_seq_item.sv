`include "uvm_macros.svh"
import uvm_pkg::*;

typedef enum logic [3:0] {
  ADD          = 4'b0000,
  SUB          = 4'b0001,
  MUL          = 4'b0010,
  COMPARE      = 4'b0011,
  BIN_TO_GRAY  = 4'b0100,
  GRAY_TO_BIN  = 4'b0101,
  SHIFT_L      = 4'b0110,
  SHIFT_R      = 4'b0111,
  LOGIC_NAND    = 4'b1000,
  LOGIC_NOR     = 4'b1001,
  LOGIC_XNOR    = 4'b1010,
  LOGIC_NOT    = 4'b1011
} ALU_op_e;

class ALU_seq_item extends uvm_sequence_item;

    rand logic [3:0] A;
    rand logic [3:0] B;
    rand ALU_op_e Op;
    logic [7:0] Res;

    `uvm_object_utils(ALU_seq_item)

    function new(string name = "ALU_seq_item");
 
        super.new(name);
 
    endfunction

    constraint valid_opcode {
        Op inside {[4'b0000:4'b1011]};
    }

    constraint input_dist{
        
        A dist {
            4'h0 := 20,
            4'hF := 20,
            [4'h1:4'hE] :/ 60
        };

        B dist {
            4'h0 := 20,
            4'hF := 20,
            [4'h1:4'hE] :/ 60
        };
    }
  
endclass