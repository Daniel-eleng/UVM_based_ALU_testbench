typedef enum logic [3:0] {
  ADD          = 4'b0000,
  SUB          = 4'b0001,
  MUL          = 4'b0010,
  COMPARE      = 4'b0011,
  BIN_TO_GRAY  = 4'b0100,
  GRAY_TO_BIN  = 4'b0101,
  SHIFT_L      = 4'b0110,
  SHIFT_R      = 4'b0111,
  LOGIC_NAND    = 4'b1000,
  LOGIC_NOR     = 4'b1001,
  LOGIC_XNOR    = 4'b1010,
  LOGIC_NOT    = 4'b1011
} ALU_op_e;

class ALU_ref_model;

    function bit[7:0] ALU_calc(bit[3:0] a, bit[3:0] b, ALU_op_e op);

        bit[7:0] res;
        bit [3:0] gray_bin_temp;

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
            SHIFT_L : res = (a << b[1:0]);
            SHIFT_R : res = (a >> b[1:0]);
            LOGIC_NAND : res = ~(a & b);
            LOGIC_NOR : res = ~(a | b);
            LOGIC_XNOR : res = ~(a ^ b);
            LOGIC_NOT : res = ~a;
            default: res = 8'd0;
        endcase

        return res;
      
    endfunction
  
endclass