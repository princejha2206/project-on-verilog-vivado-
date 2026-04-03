module alu_4bit (
    input  [3:0] A, B,
    input  [1:0] ALU_Sel,
    input        Cin,
    output [3:0] Result,
    output       Cout
);

    wire [3:0] sum;
    wire [3:0] carry;

  
    full_adder_sum   FA0(sum[0], A[0], B[0], Cin);
    full_adder_carry FC0(carry[0], A[0], B[0], Cin);

    full_adder_sum   FA1(sum[1], A[1], B[1], carry[0]);
    full_adder_carry FC1(carry[1], A[1], B[1], carry[0]);

    full_adder_sum   FA2(sum[2], A[2], B[2], carry[1]);
    full_adder_carry FC2(carry[2], A[2], B[2], carry[1]);

    full_adder_sum   FA3(sum[3], A[3], B[3], carry[2]);
    full_adder_carry FC3(carry[3], A[3], B[3], carry[2]);

    assign Cout = carry[3];

  
    assign Result = (ALU_Sel == 2'b00) ? sum :
                    (ALU_Sel == 2'b01) ? (A & B) :
                    (ALU_Sel == 2'b10) ? (A | B) :
                                         (A ^ B);

endmodule