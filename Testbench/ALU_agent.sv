`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_agent extends uvm_agent;

    ALU_driver drv;
    ALU_monitor mon;
    ALU_sequencer seqr;

    `uvm_component_utils(ALU_agent)

    function new(string name = "ALU_agent",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        drv = ALU_driver :: type_id :: create("drv",this);
        mon = ALU_monitor :: type_id :: create("mon",this);
        seqr = ALU_sequencer :: type_id :: create("seqr",this);
      
    endfunction

    function void connect_phase(uvm_phase phase);

        drv.seq_item_port.connect(seqr.seq_item_export);
      
    endfunction
  
endclass