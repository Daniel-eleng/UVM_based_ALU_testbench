`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_env extends uvm_env;

    `uvm_component_utils(ALU_env)

    ALU_agent agn;

    ALU_scoreboard scrb;

    ALU_coverage cov;

    function new(string name = "ALU_env",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        agn = ALU_agent :: type_id :: create("agn",this);

        scrb = ALU_scoreboard :: type_id :: create("scrb",this);

        cov = ALU_coverage :: type_id :: create("cov",this);
      
    endfunction

    function void connect_phase(uvm_phase phase);

        super.connect_phase(phase);

        agn.mon.mon_ap.connect(scrb.imp);

        agn.mon.mon_ap.connect(cov.analysis_export);
      
    endfunction
  
endclass