module main(input clk,input enable , input reset ,input [1:0] mode,output isEqual,output[6:0] HEX0 , output[6:0] HEX1, output[6:0] HEX2, output[6:0] HEX3 );

// wire [127:0] expected128 =;
// wire [127:0] expected192= ;
// wire [127:0] expected256= ;


//1-Cipher with 128_key
parameter NK_128 = 4;
parameter NR_128 = 10;
wire [127:0] inputplain128 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] cipher128 ;
wire [32*NK_128-1:0] key128 = 128'h000102030405060708090a0b0c0d0e0f;
wire [128*(NR_128+1)-1:0] AllKeys128; 
KeyExpansion #(NK_128, NR_128) key_expander_128 (key128, AllKeys128);
AES_Cipher #(NR_128) cipher_128 (clk, inputplain128, AllKeys128, cipher128);
wire [11:0] outbcd;
BinarytoBCD b(cipher128[7:0],outbcd);
bcdto7seg d(outbcd,HEX0,HEX1,HEX2,HEX3,HEX4);

//2-deCipher with 128_key
wire [127:0] inputcipher128 = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
wire [127:0] decipher128 ;
AES_DeCipher #(NR_128) decipher_128 (clk, inputcipher128, AllKeys128, decipher128);

//3-Cipher with 192_key
parameter NK_192 = 6;
parameter NR_192 = 12;
wire [127:0] inputplain192 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] cipher192 ;
wire [32*NK_192-1:0] key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617 ;
wire [128*(NR_192+1)-1:0] AllKeys192;
KeyExpansion #(NK_192, NR_192) key_expander_192 (key192, AllKeys192);
AES_Cipher #(NR_192) cipher_192 (clk, inputplain192, AllKeys192, cipher192);

//4-deCipher with 192_key
wire [127:0] inputcipher192 = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
wire [127:0] decipher192 ;

AES_DeCipher #(NR_192) decipher_192 (clk, inputcipher192, AllKeys192, decipher192);

//5-Cipher with 256_key
parameter NK_256 = 8;
parameter NR_256 = 14;
wire [127:0] inputplain256 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] cipher256 ;
wire [32*NK_256-1:0] key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [128*(NR_256+1)-1:0] AllKeys256;
KeyExpansion #(NK_256, NR_256) key_expander_256 (key256, AllKeys256);
AES_Cipher #(NR_256) cipher_256 (clk, inputplain256, AllKeys256, cipher256);

//6-deCipher with 256_key
wire [127:0] inputcipher256 = 128'h8ea2b7ca516745bfeafc49904b496089;
wire [127:0] decipher256 ;

AES_DeCipher #(NR_256) decipher_256 (clk, inputcipher256, AllKeys256, decipher256);

endmodule



module bcdto7seg (
input [11:0] bcd,
output[6:0] HEX0
, output[6:0] HEX1
, output[6:0] HEX2
, output[6:0] HEX3
, output[6:0] HEX4
);
    case (bcd[3:0])
        4'b0000: HEX0 = 7'b1000000;
        4'b0001: HEX0 = 7'b1111001;
        4'b0010: HEX0 = 7'b0100100;
        4'b0011: HEX0 = 7'b0110000;
        4'b0100: HEX0 = 7'b0011001;
        4'b0101: HEX0 = 7'b0010010;
        4'b0110: HEX0 = 7'b0000010;
        4'b0111: HEX0 = 7'b1111000;
        4'b1000: HEX0 = 7'b0000000;
        4'b1001: HEX0 = 7'b0010000;
        default: HEX0 = 7'b1111111;
    endcase
    case (bcd[7:4])
        4'b0000: HEX1 = 7'b1000000;
        4'b0001: HEX1 = 7'b1111001;
        4'b0010: HEX1 = 7'b0100100;
        4'b0011: HEX1 = 7'b0110000;
        4'b0100: HEX1 = 7'b0011001;
        4'b0101: HEX1 = 7'b0010010;
        4'b0110: HEX1 = 7'b0000010;
        4'b0111: HEX1 = 7'b1111000;
        4'b1000: HEX1 = 7'b0000000;
        4'b1001: HEX1 = 7'b0010000;
        default: HEX1 = 7'b1111111;
    endcase
    case (bcd[11:8])
        4'b0000: HEX2 = 7'b1000000;
        4'b0001: HEX2 = 7'b1111001;
        4'b0010: HEX2 = 7'b0100100;
        4'b0011: HEX2 = 7'b0110000;
        4'b0100: HEX2 = 7'b0011001;
        4'b0101: HEX2 = 7'b0010010;
        4'b0110: HEX2 = 7'b0000010;
        4'b0111: HEX2 = 7'b1111000;
        4'b1000: HEX2 = 7'b0000000;
        4'b1001: HEX2 = 7'b0010000;
        default: HEX2 = 7'b1111111;
    endcase
assign HEX3=7'b1111111;
assign HEX4=7'b1111111;

endmodule