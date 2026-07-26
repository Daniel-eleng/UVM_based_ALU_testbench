class ALU_ref_model;

    function bit[7:0] ALU_calc(bit[3:0] a, bit[3:0] b, ALU_op_e op);

        bit[7:0] res;
        bit [3:0] gray_bin_temp;
        bit [4:0] sub_temp;
        bit [3:0] logic_res;
        bit [3:0] shift_res;

        case (op)
            ADD : res = a + b;
            SUB : begin
                sub_temp = {1'b0,a} + {1'b0,~b} + 5'b1;
                res = {3'b000, sub_temp[4], sub_temp[3:0]};
            end
            MUL : res = a * b;
            COMPARE : res = {5'd0,(a<b),(a==b),(a>b)};
            BIN_TO_GRAY : res = {4'd0,a ^ (a>>1)};
            GRAY_TO_BIN : begin
                gray_bin_temp[3] = a[3];
                gray_bin_temp[2] = gray_bin_temp[3] ^ a[2];
                gray_bin_temp[1] = gray_bin_temp[2] ^ a[1];
                gray_bin_temp[0] = gray_bin_temp[1] ^ a[0];
                res = {4'd0,gray_bin_temp};
            end
            SHIFT_L : begin
                shift_res = (a << b[1:0]);
                res = {4'd0, shift_res};
            end
            SHIFT_R : res = (a >> b[1:0]);
            LOGIC_NAND : begin
                logic_res = ~(a & b);
                res = {4'd0, logic_res};
            end
            LOGIC_NOR : begin
                logic_res = ~(a | b);
                res = {4'd0, logic_res};
            end
            LOGIC_XNOR : begin
                logic_res = ~(a ^ b);
                res = {4'd0, logic_res};
            end
            LOGIC_NOT : begin
                logic_res = ~a;
                res = {4'd0, logic_res};
            end
            default: res = 8'd0;
        endcase

        return res;
      
    endfunction
  
endclass