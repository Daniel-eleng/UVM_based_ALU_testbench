`include "uvm_macros.svh"
import uvm_pkg::*;

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