`timescale 1ns/1ps

module adder_gate(
     input A,B,Cin,
     output Sum,Cout
        );
 wire A1,B1,B2,B3,C1;
  
  xor(A1,A,B);
  xor(Sum,A1,Cin);
  
  and(B1,A,B);
  and(B2,B,Cin);
  and(B3,Cin,A);
  
  or(C1,B1,B2);
  or(Cout,C1,B3);
  
endmodule

module adder_data(
    input A,B,Cin,
    output Sum,Cout
      );
      
 assign Sum=A^B^Cin;
 assign Cout=(A&B)|(B&Cin)|(A&Cin);   
  
 endmodule 
  
module adder_beh(
   input A,B,Cin,
   output reg Cout,
   output reg Sum
       );
       
  always @(*) begin
    {Cout,Sum}=A+B+Cin;
   end 
 endmodule 