`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_error_inject_test extends ALU_test;

    `uvm_component_utils(ALU_error_inject_test)

    ALU_error_inject_cb err_cb;

    function new(string name = "ALU_error_inject_test", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        err_cb = ALU_error_inject_cb :: type_id :: create("err_cb");

        uvm_callbacks#(ALU_driver,ALU_driver_cb)::add(envir.agn.drv,err_cb);
      
    endfunction
  
endclass