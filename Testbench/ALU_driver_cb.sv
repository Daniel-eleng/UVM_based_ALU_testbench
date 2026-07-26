`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_driver_cb extends uvm_callback;

    `uvm_object_utils(ALU_driver_cb)

    function new(string name = "ALU_driver_cb");
 
        super.new(name);
 
    endfunction

    virtual task modify_pkt(ALU_seq_item seq_itm);
      
    endtask
  
endclass