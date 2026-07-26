`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_error_inject_cb extends ALU_driver_cb;

    `uvm_object_utils(ALU_error_inject_cb)

    function new(string name = "ALU_error_inject_cb");
 
        super.new(name);
 
    endfunction

    virtual task modify_pkt(ALU_seq_item seq_itm);

        if($urandom_range(0,9) == 0)
            seq_itm.A = $urandom_range(0,15);
        
        if($urandom_range(0,10) == 0)
            seq_itm.Op = alu_op_e'(4'b1100);
      
    endtask
  
endclass