module alu_advanced #(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] A,
    input [DATA_WIDTH-1:0] B,
    input [3:0] ALU_Sel,
    output reg [DATA_WIDTH-1:0] ALU_Out,
    output reg CarryOut,
    output Zero,
    output Negative,
    output reg Overflow
);

    reg [DATA_WIDTH:0] tmp_result;

    always @(*) begin
        ALU_Out = 0;
        CarryOut = 0;
        Overflow = 0;
        tmp_result = 0;

        case(ALU_Sel)
            4'b0000: begin
                tmp_result = A + B;
                ALU_Out = tmp_result[DATA_WIDTH-1:0];
                CarryOut = tmp_result[DATA_WIDTH];
                Overflow = (A[DATA_WIDTH-1] & B[DATA_WIDTH-1] & ~ALU_Out[DATA_WIDTH-1]) |
                           (~A[DATA_WIDTH-1] & ~B[DATA_WIDTH-1] & ALU_Out[DATA_WIDTH-1]);
            end
            
            4'b0001: begin
                tmp_result = A - B;
                ALU_Out = tmp_result[DATA_WIDTH-1:0];
                CarryOut = tmp_result[DATA_WIDTH];
                Overflow = (A[DATA_WIDTH-1] & ~B[DATA_WIDTH-1] & ~ALU_Out[DATA_WIDTH-1]) |
                           (~A[DATA_WIDTH-1] & B[DATA_WIDTH-1] & ALU_Out[DATA_WIDTH-1]);
            end
            
            4'b0010: ALU_Out = A + 1;
            4'b0011: ALU_Out = A - 1;

            4'b0100: ALU_Out = A & B;
            4'b0101: ALU_Out = A | B;
            4'b0110: ALU_Out = A ^ B;
            4'b0111: ALU_Out = ~(A | B);
            
            4'b1000: ALU_Out = A << 1;
            4'b1001: ALU_Out = A >> 1;
            4'b1010: ALU_Out = A << B[4:0];
            4'b1011: ALU_Out = A >> B[4:0];

            4'b1100: ALU_Out = (A == B) ? 1 : 0;
            4'b1101: ALU_Out = (A > B) ? 1 : 0;

            default: ALU_Out = {DATA_WIDTH{1'b0}};
        endcase
    end

    assign Zero = ~(|ALU_Out);
    assign Negative = ALU_Out[DATA_WIDTH-1];

endmodule