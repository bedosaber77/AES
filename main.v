module main(input clk);

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
