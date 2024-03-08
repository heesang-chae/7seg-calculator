module FND_decoder(bcd, seg);
input [3:0] bcd;
output reg [6:0] seg;

always @ (bcd) begin
    case(bcd)
    4'd0 : seg = 7'b1000_000;
    4'd1 : seg = 7'b1111_001;
    4'd2 : seg = 7'b0100_100;
    4'd3 : seg = 7'b0110_000;
    4'd4 : seg = 7'b0011_001;
    4'd5 : seg = 7'b0010_010;
    4'd6 : seg = 7'b0000_010;
    4'd7 : seg = 7'b1011_000;
    4'd8 : seg = 7'b0000_000;
    4'd9 : seg = 7'b0010_000;
    4'd10 : seg = 7'b0111_111; //minus sign
    4'd11 : seg = 7'b1111_111; //led off
    default : seg = 7'bxxxxxxx;
    endcase
end
endmodule