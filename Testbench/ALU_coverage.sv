
class ALU_coverage extends uvm_subscriber#(ALU_seq_item);

    `uvm_component_utils(ALU_coverage)

    ALU_seq_item seq_itm;

    function new(string name = "ALU_coverage",uvm_component parent);
 
        super.new(name,parent);

        ALU_cg = new();
 
    endfunction

    covergroup ALU_cg;
        Op_cp : coverpoint seq_itm.Op{
            illegal_bins invalid = {[4'b1100:4'b1111]};
        }
        A_cp : coverpoint seq_itm.A{
            bins zero = {0};
            bins max = {15};
            bins mid = {[1 : 14]};
        }
        B_cp : coverpoint seq_itm.B{
            bins zero = {0};
            bins max = {15};
            bins mid = {[1 : 14]};
        }
        op_a_cross : cross Op_cp , A_cp;
        op_b_cross : cross Op_cp , B_cp {
            ignore_bins logic_op = binsof(Op_cp) intersect {LOGIC_NOT};
        }
    endgroup

    function void write(ALU_seq_item seq_itm);

        this.seq_itm = seq_itm;
        ALU_cg.sample();
      
    endfunction

    function void report_phase(uvm_phase phase);

        `uvm_info(get_type_name(),$sformatf("Total coverage:%0.2f",ALU_cg.get_coverage()),UVM_LOW)
      
    endfunction
  
endclass