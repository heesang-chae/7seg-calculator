module BCD (in, BCD_1, BCD_10, BCD_100, BCD_1000, BCD_10000);
input [15:0]in;
output [3:0] BCD_1, BCD_10, BCD_100, BCD_1000, BCD_10000;
wire [15:0] D1, D2, D3, D4, D5;
wire [7:0] R1, R2, R3, R4, R5;

//divide10 --> remainder<10
divider16bit BCD1(in, 8'd10, D1, R1);
divider16bit BCD2(D1, 8'd10, D2, R2);
divider16bit BCD3(D2, 8'd10, D3, R3);
divider16bit BCD4(D3, 8'd10, D4, R4);
divider16bit BCD5(D4, 8'd10, D5, R5);

assign BCD_1 = R1[3:0];
assign BCD_10 = R2[3:0];
assign BCD_100 = R3[3:0];
assign BCD_1000 = R4[3:0];
assign BCD_10000 = R5[3:0];
endmodule


module divider16bit(A, B, D, remainder); //16:8 divider
input [15:0] A;
input [7:0] B;
output [15:0] D;
output [7:0] remainder;
wire [7:0] Dout0, Dout1, Dout2, Dout3, Dout4, Dout5, Dout6, Dout7,
           Dout8, Dout9, Dout10, Dout11, Dout12, Dout13, Dout14, Dout15;
wire [15:0] Bout;

CSM8_line D_line0(.A({8'b0, A[15]}), .B(B), .Bout(Bout[0]), .D(Dout0));
CSM8_line D_line1(.A({Dout0, A[14]}), .B(B), .Bout(Bout[1]), .D(Dout1));
CSM8_line D_line2(.A({Dout1, A[13]}), .B(B), .Bout(Bout[2]), .D(Dout2));
CSM8_line D_line3(.A({Dout2, A[12]}), .B(B), .Bout(Bout[3]), .D(Dout3));
CSM8_line D_line4(.A({Dout3, A[11]}), .B(B), .Bout(Bout[4]), .D(Dout4));
CSM8_line D_line5(.A({Dout4, A[10]}), .B(B), .Bout(Bout[5]), .D(Dout5));
CSM8_line D_line6(.A({Dout5, A[9]}), .B(B), .Bout(Bout[6]), .D(Dout6));
CSM8_line D_line7(.A({Dout6, A[8]}), .B(B), .Bout(Bout[7]), .D(Dout7));

CSM8_line D_line8(.A({Dout7, A[7]}), .B(B), .Bout(Bout[8]), .D(Dout8));
CSM8_line D_line9(.A({Dout8, A[6]}), .B(B), .Bout(Bout[9]), .D(Dout9));
CSM8_line D_line10(.A({Dout9, A[5]}), .B(B), .Bout(Bout[10]), .D(Dout10));
CSM8_line D_line11(.A({Dout10, A[4]}), .B(B), .Bout(Bout[11]), .D(Dout11));
CSM8_line D_line12(.A({Dout11, A[3]}), .B(B), .Bout(Bout[12]), .D(Dout12));
CSM8_line D_line13(.A({Dout12, A[2]}), .B(B), .Bout(Bout[13]), .D(Dout13));
CSM8_line D_line14(.A({Dout13, A[1]}), .B(B), .Bout(Bout[14]), .D(Dout14));
CSM8_line D_line15(.A({Dout14, A[0]}), .B(B), .Bout(Bout[15]), .D(Dout15));

assign D = {~Bout[0], ~Bout[1], ~Bout[2], ~Bout[3], ~Bout[4], ~Bout[5], ~Bout[6], ~Bout[7],
            ~Bout[8], ~Bout[9], ~Bout[10], ~Bout[11], ~Bout[12], ~Bout[13], ~Bout[14], ~Bout[15]};
assign remainder = Dout15;
endmodule