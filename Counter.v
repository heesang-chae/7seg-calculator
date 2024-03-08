module Top(CLK, RST, seg1, seg10, seg100, seg1000);
input CLK, RST;
output [7:0] seg1, seg10, seg100, seg1000;

wire [13:0] count;
wire [3:0] BCD_1, BCD_10, BCD_100, BCD_1000;

counnter counter(CLK, RST, count);
BCD BCD(count, BCD_1, BCD_10, BCD_100, BCD_1000);
FND_decoder FND_decoder1(BCD_1, seg1);
FND_decoder FND_decoder2(BCD_10, seg10);
FND_decoder FND_decoder3(BCD_100, seg100);
FND_decoder FND_decoder4(BCD_1000, seg1000);
endmodule

module counnter(CLK, RST, count);

input CLK, RST;
output reg [13:0] count;

always @ (posedge CLK) begin
    if(RST) count <= 1'b0; 
    else begin
        if(count == 14'd9999) count <= 1'b0; 
        else count <= count + 1'b1;
    end
end

endmodule

module BCD (in, BCD_1, BCD_10, BCD_100, BCD_1000);
input [13:0]in;
output [3:0] BCD_1, BCD_10, BCD_100, BCD_1000;
wire [13:0] D1, D2, D3, D4;
wire [3:0] R1, R2, R3, R4;

//divide10 --> remainder<10
divider BCD1(in, 4'd10, D1, R1);
divider BCD2(D1, 4'd10, D2, R2);
divider BCD3(D2, 4'd10, D3, R3);
divider BCD4(D3, 4'd10, D4, R4);

assign BCD_1 = R1[3:0];
assign BCD_10 = R2[3:0];
assign BCD_100 = R3[3:0];
assign BCD_1000 = R4[3:0];
endmodule

module divider(A, B, D, R);
input [13:0] A; //dividend
input [3:0] B; //divisor

output [13:0] D; //quotient
output [3:0] R; //remainder

assign D = A/B;
assign R = A%B;
endmodule

module FND_decoder(BCD, seg);
input [3:0] BCD;
output reg [7:0] seg;

always @ (*) begin
    case (BCD)
        4'b0000 : seg = ~8'b01000000; // 0
        4'b0001 : seg = ~8'b01111001; // 1
        4'b0010 : seg = ~8'b00100100; // 2
        4'b0011 : seg = ~8'b00110000; // 3
        4'b0100 : seg = ~8'b00011001; // 4
        4'b0101 : seg = ~8'b00010010; // 5
        4'b0110 : seg = ~8'b00000010; // 6
        4'b0111 : seg = ~8'b01111000; // 7
        4'b1000 : seg = ~8'b00000000; // 8
        4'b1001 : seg = ~8'b00010000; // 9
        4'b1010 : seg = ~8'b00001000; // A
        4'b1011 : seg = ~8'b00000011; // b
        4'b1100 : seg = ~8'b01000110; // C
        4'b1101 : seg = ~8'b00100001; // d
        4'b1110 : seg = ~8'b00000110; // E
        4'b1111 : seg = ~8'b00001110; // F
    endcase
end
endmodule