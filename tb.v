module tb ();
reg [7:0] A, B;
reg [2:0]op;
wire [7:0] out, rm;
wire [6:0] seg1, seg2, seg3, seg4, seg5;
    top top(A, B, op, seg1, seg2, seg3, seg4, seg5);

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb);
        
        A = 8'd10; B = 8'd2; op = 3'd0;
        #10
        A = 8'd10; B = 8'd12; op = 3'd1;
        #10
        A = 8'd111; B = 8'd2; op = 3'd2;
        #10
        A = 8'd0; B = 8'd200; op = 3'd3;
        #10
        A = 8'd201; B = 8'd202; op = 3'd4;
        
    end

endmodule