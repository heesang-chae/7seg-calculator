module top(A, B, op, seg1, seg2, seg3, seg4, seg5);
input [7:0] A, B;
input [2:0] op;
output [6:0] seg1, seg2, seg3, seg4, seg5;
wire [8:0] out_RCA, sign_sub;
wire [15:0] out_multi, result;
wire [7:0] out_div, out_mod, out_sub;
wire [3:0] BCD_1, BCD_10, BCD_100, BCD_1000, BCD_10000;
wire [3:0] F_in1, F_in2, F_in3, F_in4, F_in5;


RCA adder(A, B, out_RCA);
substractor sub(A, B, sign_sub);
assign out_sub = sign_sub[7:0];
multiplier multi(A, B, out_multi);
divider div(A, B, out_div, out_mod);
MUX5 M5({7'b0, out_RCA}, {8'b0, out_sub}, out_multi, {8'b0, out_div}, {8'b0, out_mod}, op, result); 
BCD BCD(result, BCD_1, BCD_10, BCD_100, BCD_1000, BCD_10000);
controller ctrl(BCD_1, BCD_10, BCD_100, BCD_1000, BCD_10000, op, sign_sub[8], F_in1, F_in2, F_in3, F_in4, F_in5);
FND_decoder F1(F_in1, seg1);
FND_decoder F10(F_in2, seg2);
FND_decoder F100(F_in3, seg3);
FND_decoder F1000(F_in4, seg4);
FND_decoder F10000(F_in5, seg5);
endmodule


module MUX5(in0, in1, in2, in3, in4, sel, out); //5input mux
input [15:0] in0, in1, in2, in3, in4;
input [2:0] sel;
output reg [15:0] out;

always @ (*) begin
    case(sel)
        3'd0 : out = in0;
        3'd1 : out = in1;
        3'd2 : out = in2;
        3'd3 : out = in3;
        3'd4 : out = in4;
    endcase
end

endmodule

module controller(in0, in1, in2, in3, in4, sel, sign, out0, out1, out2, out3, out4);
input [3:0] in0, in1, in2, in3, in4;
input [2:0] sel;
input sign; 
output reg [3:0]out0, out1, out2, out3, out4; 
wire [3:0] temp;

assign temp = {3'b101, ~sign}; //sign=1 --> temp = 1010 (minus bcd)
always @ (*) begin
    case(sel)
        3'd0 : begin out0 = in0; out1 = in1; out2 = in2; out3 = 4'd11; out4 = 4'd11; end //add
        3'd1 : begin out0 = in0; out1 = in1; out2 = in2; out3 = temp; out4 = 4'd11; end //sub
        3'd2 : begin out0 = in0; out1 = in1; out2 = in2; out3 = in3; out4 = in4; end //multi
        3'd3 : begin out0 = in0; out1 = in1; out2 = in2; out3 = 4'd11; out4 = 4'd11; end //div
        3'd4 : begin out0 = in0; out1 = in1; out2 = in2; out3 = 4'd11; out4 = 4'd11; end //mod
    endcase
end
endmodule
