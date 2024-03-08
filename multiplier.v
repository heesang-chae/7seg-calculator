module multiplier (A, B, P);
input [7:0] A, B;
output [15:0] P; //product
wire [7:0] Cout, Sout0, Sout1, Sout2, Sout3, Sout4, Sout5, Sout6, Sout7; 


MA8_line line0(.A(A), .B(B[0]), .Sin(8'b0), .Cout(Cout[0]), .Sout(Sout0));
MA8_line line1(.A(A), .B(B[1]), .Sin({Cout[0], Sout0[7:1]}), .Cout(Cout[1]), .Sout(Sout1));
MA8_line line2(.A(A), .B(B[2]), .Sin({Cout[1], Sout1[7:1]}), .Cout(Cout[2]), .Sout(Sout2));
MA8_line line3(.A(A), .B(B[3]), .Sin({Cout[2], Sout2[7:1]}), .Cout(Cout[3]), .Sout(Sout3));
MA8_line line4(.A(A), .B(B[4]), .Sin({Cout[3], Sout3[7:1]}), .Cout(Cout[4]), .Sout(Sout4));
MA8_line line5(.A(A), .B(B[5]), .Sin({Cout[4], Sout4[7:1]}), .Cout(Cout[5]), .Sout(Sout5));
MA8_line line6(.A(A), .B(B[6]), .Sin({Cout[5], Sout5[7:1]}), .Cout(Cout[6]), .Sout(Sout6));
MA8_line line7(.A(A), .B(B[7]), .Sin({Cout[6], Sout6[7:1]}), .Cout(Cout[7]), .Sout(Sout7));

assign P = {Cout[7], Sout7, Sout6[0], Sout5[0], Sout4[0], Sout3[0], Sout2[0], Sout1[0], Sout0[0]};
endmodule

module MA8_line(A, B, Sin, Cout, Sout);
input [7:0] A, Sin;
input B;
output [7:0] Sout;
output Cout;
wire [6:0] C;

MA MA0(.in1(A[0]), .in2(B), .cin(1'b0), .sin(Sin[0]), .cout(C[0]), .sout(Sout[0]));
MA MA1(.in1(A[1]), .in2(B), .cin(C[0]), .sin(Sin[1]), .cout(C[1]), .sout(Sout[1]));
MA MA2(.in1(A[2]), .in2(B), .cin(C[1]), .sin(Sin[2]), .cout(C[2]), .sout(Sout[2]));
MA MA3(.in1(A[3]), .in2(B), .cin(C[2]), .sin(Sin[3]), .cout(C[3]), .sout(Sout[3]));
MA MA4(.in1(A[4]), .in2(B), .cin(C[3]), .sin(Sin[4]), .cout(C[4]), .sout(Sout[4]));
MA MA5(.in1(A[5]), .in2(B), .cin(C[4]), .sin(Sin[5]), .cout(C[5]), .sout(Sout[5]));
MA MA6(.in1(A[6]), .in2(B), .cin(C[5]), .sin(Sin[6]), .cout(C[6]), .sout(Sout[6]));
MA MA7(.in1(A[7]), .in2(B), .cin(C[6]), .sin(Sin[7]), .cout(Cout), .sout(Sout[7]));
endmodule

module MA(in1, in2, cin, sin, cout, sout); //1bit multiply adder
input in1, in2, cin, sin;
output cout, sout;
wire and1;

and(and1, in1, in2);
FA FA(sin, and1, cin, sout, cout);

endmodule

