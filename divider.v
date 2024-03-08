module divider(A, B, D, remainder);
input [7:0] A, B;
output [7:0] D, remainder;
wire [7:0] Bout, Dout0, Dout1, Dout2, Dout3, Dout4, Dout5, Dout6, Dout7;

CSM8_line D_line0(.A({8'b0, A[7]}), .B(B), .Bout(Bout[0]), .D(Dout0));
CSM8_line D_line1(.A({Dout0, A[6]}), .B(B), .Bout(Bout[1]), .D(Dout1));
CSM8_line D_line2(.A({Dout1, A[5]}), .B(B), .Bout(Bout[2]), .D(Dout2));
CSM8_line D_line3(.A({Dout2, A[4]}), .B(B), .Bout(Bout[3]), .D(Dout3));
CSM8_line D_line4(.A({Dout3, A[3]}), .B(B), .Bout(Bout[4]), .D(Dout4));
CSM8_line D_line5(.A({Dout4, A[2]}), .B(B), .Bout(Bout[5]), .D(Dout5));
CSM8_line D_line6(.A({Dout5, A[1]}), .B(B), .Bout(Bout[6]), .D(Dout6));
CSM8_line D_line7(.A({Dout6, A[0]}), .B(B), .Bout(Bout[7]), .D(Dout7));

assign D = {~Bout[0], ~Bout[1], ~Bout[2], ~Bout[3], ~Bout[4], ~Bout[5], ~Bout[6], ~Bout[7]};
assign remainder = Dout7;
endmodule

module CSM8_line (A, B, Bout, D); //Controlled Substract-Multiplexer 8bit serial line
input [8:0] A;
input [7:0] B;
output Bout;
output [7:0] D;
wire [8:0] D_temp, BO;

FS FS0(.a(A[0]), .b(B[0]), .bin(1'b0), .y(D_temp[0]), .bout(BO[0]));
FS FS1(.a(A[1]), .b(B[1]), .bin(BO[0]), .y(D_temp[1]), .bout(BO[1]));
FS FS2(.a(A[2]), .b(B[2]), .bin(BO[1]), .y(D_temp[2]), .bout(BO[2]));
FS FS3(.a(A[3]), .b(B[3]), .bin(BO[2]), .y(D_temp[3]), .bout(BO[3]));
FS FS4(.a(A[4]), .b(B[4]), .bin(BO[3]), .y(D_temp[4]), .bout(BO[4]));
FS FS5(.a(A[5]), .b(B[5]), .bin(BO[4]), .y(D_temp[5]), .bout(BO[5]));
FS FS6(.a(A[6]), .b(B[6]), .bin(BO[5]), .y(D_temp[6]), .bout(BO[6]));
FS FS7(.a(A[7]), .b(B[7]), .bin(BO[6]), .y(D_temp[7]), .bout(BO[7]));
FS FS8(.a(A[8]), .b(1'b0), .bin(BO[7]), .y(D_temp[8]), .bout(BO[8]));

MUX MUX0(D_temp[0], A[0], BO[8], D[0]);
MUX MUX1(D_temp[1], A[1], BO[8], D[1]);
MUX MUX2(D_temp[2], A[2], BO[8], D[2]);
MUX MUX3(D_temp[3], A[3], BO[8], D[3]);
MUX MUX4(D_temp[4], A[4], BO[8], D[4]);
MUX MUX5(D_temp[5], A[5], BO[8], D[5]);
MUX MUX6(D_temp[6], A[6], BO[8], D[6]);
MUX MUX7(D_temp[7], A[7], BO[8], D[7]);
assign Bout = BO[8];
endmodule


module FS (a, b, bin, y, bout); //full substractor
input a, b, bin; //input
output y, bout; //output
wire a_not, xor1, and1, and2, and3; 

// y = a^b^bin
xor(xor1, a, b); 
xor(y, xor1, bin); 

// bout = ~AB+~ABin+BBin
not(a_not, a);
and(and1, a_not, bin);
and(and2, b, bin);
and(and3, a_not, b);
or(bout, and1, and2, and3);

endmodule

module MUX(A, B, sel, out); //2input multiplexer
input A, B, sel;
output out;
wire and1, and2;

and (and1, A, ~sel);
and (and2, B, sel);
or (out, and1, and2);
endmodule 