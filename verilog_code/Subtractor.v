`timescale 1ns/1ps

module Sub_gate(
   input A,B,Bin,
   output D,Bout
      );
  wire AorB,notA,notB,notAB,notABin,BBin,Bout1;
  
  xor(AorB,A,B);
  xor(D,AorB,Bin);
  
  not(notA,A);
  not(notB,B);
  
  and(notAB,notA,B);
  and(notABin,notA,Bin);
  and(BBin,B,Bin);
  
  or(Bout1,notAB,notABin);
  or(Bout,Bout1,BBin);
 
 endmodule 
 
 module Sub_data(
     input A,B,Bin,
     output Bout,D
     );
     
  assign D=A^B^Bin;
  assign Bout=((~A)&B)|((~A)&Bin)|(B&Bin);
  
  endmodule 
  
  module Sub_beh(
     input wire  A,B,Bin,
     output reg Bout,
     output reg D 
       );
   always @(*) begin
     {Bout, D} = {1'b0, A} - {1'b0, B} - {1'b0, Bin};
  end
  endmodule 