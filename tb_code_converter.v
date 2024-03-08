`timescale 1ns/1ns
module tb_code_converter();
reg [3:0] in_2421; //input in_2421[3]=A, in_2421[2]=B, in_2421[1]=C, in_2421[0]=D
wire [3:0] out_ex3; //output out_ex3[3]=X, out_ex3[3]=Y, out_ex3[3]=W, out_ex3[3]=Z

code_converter code_converter(in_2421, out_ex3);
initial begin
    $dumpfile("test.vcd");
        $dumpvars(0, tb_code_converter);
    in_2421 = 4'b0000; //decimal 0
    #1
    in_2421 = 4'b0001; //decimal 1
    #1
    in_2421 = 4'b0010; //decimal 2
    #1
    in_2421 = 4'b0011; //decimal 3
    #1
    in_2421 = 4'b0100; //decimal 4
    #1
    in_2421 = 4'b1011; //decimal 5
    #1
    in_2421 = 4'b1100; //decimal 6
    #1
    in_2421 = 4'b1101; //decimal 7
    #1
    in_2421 = 4'b1110; //decimal 8
    #1
    in_2421 = 4'b1111; //decimal 9
end
endmodule

