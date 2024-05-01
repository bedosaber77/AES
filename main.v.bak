module main(input clk);

wire [127:0] input_bytes = 128'h3243f6a8885a308d313198a2e0370734;
wire [127:0] output_bytes;
reg [127:0] out;

parameter NK = 4;
parameter NR = 10;
wire [32*NK-1:0] key128 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
wire [128*(NR+1)-1:0] AllKeys128; 
KeyExpansion #(NK, NR) key_expander (key128, AllKeys128);
AES_Cipher #(NR) cipher (clk, input_bytes, AllKeys128, output_bytes);

/*

parameter NK = 6;
parameter NR = 12;
wire [32*NK-1:0] key192;
wire [128*(NR+1)-1:0] AllKeys192;
KeyExpansion #(NK, NR) key_expander (key192, AllKeys192);


parameter NK = 8;
parameter NR = 14;
wire [32*NK-1:0] key256;
wire [128*(NR+1)-1:0] AllKeys256;
KeyExpansion #(NK, NR) key_expander (key256, AllKeys256);

*/
endmodule
