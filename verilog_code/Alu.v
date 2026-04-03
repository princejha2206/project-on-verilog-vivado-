`timescale 1ns/1ps

module alu_gate_1bit(
   input a,b,sel,
   output out);
  wire w_and,w_or,sel_not,mux_1,mux_2;
  
  and g1(w_and,a,b);
  or g2(w_or,a,b);
  
  not g3(sel_not,sel);
  and g4(mux_1,w_and,sel_not);
  and g5(mux_2,w_or,sel);
  or g6(out,mux_1,mux_2);
  
  endmodule 
  
  module alu_dataflow(
         input [3:0]A,
         input [3:0]B,
         input [1:0]sel,
         output [3:0]result );
         
    assign result=(sel==2'b00)?(A+B):
                  (sel==2'b01)?(A-B):
                  (sel==2'b10)?(A&B):(A|B);
   endmodule 
   
   module alu_behavioral(
      input [3:0]A,
      input [3:0]B,
      input [1:0]sel,
      output reg [3:0]result);
      
      always @(*) begin
        case(sel)
         2'b00:result=A+B;
         2'b01:result=A-B;
         2'b10:result=A&B;
         2'b11:result=A|B;
         default :result =4'b0000;
        endcase 
      end 
      endmodule 