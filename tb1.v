module tb1 ();

reg CLK, RST;
wire [7:0] seg1, seg10, seg100, seg1000;
    
    Top Top(CLK, RST, seg1, seg10, seg100, seg1000);
    always #1 begin CLK = ~CLK; end //CLK generate

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb1);
        
        CLK = 1; RST = 1; //init value
        #1 RST = 0;
        #100000
        $finish;
        
    end

endmodule