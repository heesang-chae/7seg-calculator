module FA (a, b, cin, y, cout);
input a, b, cin; //input
output y, cout; //output
wire xor1, and1, and2, and3; 

// y = a^b^cin
xor(xor1, a, b); 
xor(y, xor1, cin); 

// cout = AB+ACin+BCin
and(and1, a, cin);
and(and2, b, cin);
and(and3, a, b);
or(cout, and1, and2, and3);

endmodule
