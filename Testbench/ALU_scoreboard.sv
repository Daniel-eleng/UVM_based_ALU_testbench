`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(ALU_scoreboard)

    int pass_count,fail_count;

    ALU_ref_model ref_model;

    uvm_analysis_imp#(ALU_seq_item, ALU_scoreboard) imp;

    function new(string name = "ALU_scoreboard",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        ref_model = new();

        imp = new("imp",this);
      
    endfunction

    function void write(ALU_seq_item seq_itm);

        bit [7:0] expected;
        expected = ref_model.ALU_calc(seq_itm.A, seq_itm.B, seq_itm.Op);

        if(expected == seq_itm.Res) begin
            `uvm_info(get_type_name(),$sformatf("PASS [%0s] : A = %0d | B = %0d -> Res = %0d",seq_itm.Op.name(),seq_itm.A,seq_itm.B,seq_itm.Res),UVM_LOW)
            pass_count++;
        end
        else begin
            `uvm_error(get_type_name(),$sformatf("FAIL [%0s] : A = %0d | B = %0d -> Res = %0d | Expected : %0d",seq_itm.Op.name(),seq_itm.A,seq_itm.B,seq_itm.Res,expected))
            fail_count++;
        end

    endfunction

    function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(), $sformatf("========== SUMMARY =========="), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Tranasctions: %0d", pass_count + fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("PASS: %0d", pass_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("FAIL: %0d", fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("=================================="), UVM_LOW)
      
    endfunction
  
endclass