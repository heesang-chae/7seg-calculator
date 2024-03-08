module RCA (A, B, Y);
input [7:0] A, B; 
output [8:0] Y; 
wire [6:0]Carry;

FA FullAdder1(.a(A[0]), .b(B[0]), .cin(1'b0), .y(Y[0]), .cout(Carry[0])); 
FA FullAdder2(.a(A[1]), .b(B[1]), .cin(Carry[0]), .y(Y[1]), .cout(Carry[1])); 
FA FullAdder3(.a(A[2]), .b(B[2]), .cin(Carry[1]), .y(Y[2]), .cout(Carry[2])); 
FA FullAdder4(.a(A[3]), .b(B[3]), .cin(Carry[2]), .y(Y[3]), .cout(Carry[3])); 
FA FullAdder5(.a(A[4]), .b(B[4]), .cin(Carry[3]), .y(Y[4]), .cout(Carry[4])); 
FA FullAdder6(.a(A[5]), .b(B[5]), .cin(Carry[4]), .y(Y[5]), .cout(Carry[5])); 
FA FullAdder7(.a(A[6]), .b(B[6]), .cin(Carry[5]), .y(Y[6]), .cout(Carry[6])); 
FA FullAdder8(.a(A[7]), .b(B[7]), .cin(Carry[6]), .y(Y[7]), .cout(Y[8])); 
endmodule 

