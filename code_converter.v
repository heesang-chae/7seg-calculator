`timescale 1ns/1ns
module code_converter(in_2421, out_ex3);
input [3:0] in_2421; //input in_2421[3]=A, in_2421[2]=B, in_2421[1]=C, in_2421[0]=D
output [3:0] out_ex3; //output out_ex3[3]=X, out_ex3[3]=Y, out_ex3[3]=W, out_ex3[3]=Z

assign out_ex3[3] = (in_2421[3] & in_2421[1]) | (in_2421[3] & in_2421[2]);
assign out_ex3[2] = (in_2421[2] & in_2421[1] & in_2421[0]) | (~in_2421[3] & in_2421[2]) | (~in_2421[3] & in_2421[0]) | (~in_2421[3] & in_2421[1]);
assign out_ex3[1] = (~in_2421[3] & ~in_2421[1] & ~in_2421[0]) | (~in_2421[3] & in_2421[1] & in_2421[0]) | (in_2421[3] & ~in_2421[1] & in_2421[0]) | (in_2421[3] & in_2421[1] & ~in_2421[0]);
assign out_ex3[0] = ~in_2421[0];
endmodule

