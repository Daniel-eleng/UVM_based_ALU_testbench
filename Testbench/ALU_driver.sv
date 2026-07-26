`include "uvm_macros.svh"
import uvm_pkg::*;

class ALU_driver extends uvm_driver #(ALU_seq_item);

    virtual ALU_inf inf;

    `uvm_component_utils(ALU_driver)
    `uvm_register_cb(ALU_driver,ALU_driver_cb)

    function new(string name = "ALU_driver",uvm_component parent);
 
        super.new(name,parent);
 
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

        if(!uvm_config_db#(virtual ALU_inf) :: get(this,"*","inf",inf))

            `uvm_fatal("NOVIF","Interface not found")
      
    endfunction

    task run_phase(uvm_phase phase);

        ALU_seq_item sq_itm;

        forever begin
            
            seq_item_port.get_next_item(sq_itm);

            `uvm_do_callbacks(ALU_driver,ALU_driver_cb,modify_pkt(seq_itm))

            inf.A = sq_itm.A;
            inf.B = sq_itm.B;
            inf.Opcode = sq_itm.Op; 

            #1;

            seq_item_port.item_done();

            `uvm_info(get_type_name(),$sformatf("A = %0d | B = %0d | Op = %0d",inf.A,inf.B,inf.Opcode),UVM_HIGH)
        end
      
    endtask
  
endclass