`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_test extends uvm_test;

    `uvm_component_utils(ALU_test)

    ALU_env envir;

    ALU_seq seq;

    function new(string name = "ALU_test",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        envir = ALU_env :: type_id :: create("envir",this);
      
    endfunction

    task run_phase(uvm_phase phase);

        phase.raise_objection(this);

        seq = ALU_seq :: type_id :: create("seq");

        seq.start(envir.agn.seqr);

        #10;

        phase.drop_objection(this);
      
    endtask
  
endclass