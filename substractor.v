module substractor(A, B, out);
input [7:0] A, B; //no sign
output [8:0] out; //sign and mag, msb = sign bit
wire [8:0] minus_B, Y0, Y1;
wire [8:0] A1, B1; //msb = sign bit

assign A1 = {1'b0, A}; //msb-sign padding
assign B1 = {1'b0, B}; //msb-sign padding

RCA9 RCA_twos(~B1, 9'b1, minus_B); //2's complement 
RCA9 RCA_minus(A1, minus_B, Y0);
RCA9 RCA_signmag(~Y0, 9'b1, Y1); 
MUX2 M0(Y0, {1'b1, Y1[7:0]}, Y0[8], out);
endmodule

module RCA9 (A, B, Y); //9-bits RCA
input [8:0] A, B;
output [8:0] Y; 
wire [8:0] carry;

FA FullAdder1(.a(A[0]), .b(B[0]), .cin(1'b0), .y(Y[0]), .cout(carry[0])); 
FA FullAdder2(.a(A[1]), .b(B[1]), .cin(carry[0]), .y(Y[1]), .cout(carry[1])); 
FA FullAdder3(.a(A[2]), .b(B[2]), .cin(carry[1]), .y(Y[2]), .cout(carry[2])); 
FA FullAdder4(.a(A[3]), .b(B[3]), .cin(carry[2]), .y(Y[3]), .cout(carry[3])); 
FA FullAdder5(.a(A[4]), .b(B[4]), .cin(carry[3]), .y(Y[4]), .cout(carry[4])); 
FA FullAdder6(.a(A[5]), .b(B[5]), .cin(carry[4]), .y(Y[5]), .cout(carry[5])); 
FA FullAdder7(.a(A[6]), .b(B[6]), .cin(carry[5]), .y(Y[6]), .cout(carry[6])); 
FA FullAdder8(.a(A[7]), .b(B[7]), .cin(carry[6]), .y(Y[7]), .cout(carry[7])); 
FA FullAdder9(.a(A[8]), .b(B[8]), .cin(carry[7]), .y(Y[8]), .cout(carry[8])); 
endmodule

module MUX2(in0, in1, sel, out);
input [8:0] in0, in1;
input sel;
output [8:0] out;
wire [8:0] sel8;

assign sel8 = {sel, sel, sel, sel, sel, sel, sel, sel, sel};
assign out = (sel8 & in1) | (~sel8 & in0);
endmodule
