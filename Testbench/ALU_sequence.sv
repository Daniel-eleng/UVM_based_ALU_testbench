`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_seq extends uvm_sequence #(ALU_seq_item);

    `uvm_object_utils(ALU_seq)

    function new(string name = "ALU_seq");
 
        super.new(name);
 
    endfunction

    task body();

        ALU_seq_item req;

        repeat(1000) begin
            
            req = ALU_seq_item :: type_id :: create("req");

            start_item(req);

            assert(req.randomize());

            finish_item(req);

            `uvm_info(get_type_name(),$sformatf("Check: correctness of the randomization | A = %0d | B = %0d | Op = %0d",req.A,req.B,req.Op),UVM_HIGH)
        end
      
    endtask
  
endclass