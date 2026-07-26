import ALU_pkg::*;
import uvm_pkg::*;

module ALU_top;

    ALU_inf inf();

    ALU_Design dut(.A(inf.A),
                   .B(inf.B),
                   .Opcode(inf.Opcode),
                   .Result(inf.Result));

    initial begin

        uvm_config_db#(virtual ALU_inf)::set(null, "*", "inf", inf);
        run_test("ALU_test");
        //run_test("ALU_error_inject_test");

    end

endmodule