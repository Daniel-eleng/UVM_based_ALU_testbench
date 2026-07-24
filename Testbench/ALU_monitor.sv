`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_monitor extends uvm_monitor #(ALU_seq_item) mon_ap;

    `uvm_component_utils(ALU_monitor)

    virtual ALU_inf inf;

    function new(string name = "ALU_monitor", uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        mon_ap = new("mon_ap",this);

        if(!uvm_config_db#(virtual ALU_inf) :: get(this,"*","inf",inf))

            `uvm_fatal("NOVIF","Interface not found")
      
    endfunction

    task run_phase(uvm_phase phase);

        super.run_phase(phase);

        ALU_seq_item seq_itm;

        forever begin
            
            @(inf.A or inf.B or inf.Opcode);
            
            #1;

            seq_itm = ALU_seq_item :: type_id :: create("seq_itm",this);

            seq_itm.A = inf.A;
            seq_itm.B = inf.B;
            seq_itm.Op = inf.Opcode;
            seq_itm.Res = inf.Result;

            mon_ap.write(seq_itm);
        end
      
    endtask
  
endclass