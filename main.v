module AES(
input clk,
input reset,

input [1:0] mode,
output reg isEqual,
output[6:0] HEX0,
output[6:0] HEX1,
output[6:0] HEX2
//,output[6:0] HEX3,
//output[6:0] HEX4,
//output[6:0] HEX5
);
reg enable128;
reg enable192;
reg enable256;
integer i = 0;
//1.1 128-KeyExpansion.
parameter NK_128 = 4; 
parameter NR_128 = 10;
wire [32*NK_128 - 1:0] key128 = 128'h000102030405060708090a0b0c0d0e0f;
wire [128*(NR_128 + 1) - 1:0] AllKeys128; 
KeyExpansion #(NK_128, NR_128) key_expander_128 (key128, AllKeys128);

//1.2 Cipher with 128_key.
wire [127:0] input_cipher128 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] expected_cipher128 = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
wire [127:0] cipher128;
AES_Cipher #(NR_128) cipher_128 (clk, input_cipher128, AllKeys128, reset, cipher128);

//1.3 deCipher with 128_key.
wire [127:0] input_decipher128;
wire [127:0] expected_decipher128 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] decipher128;
AES_DeCipher #(NR_128) decipher_128 (clk, input_decipher128, reset, enable128, AllKeys128, decipher128);

/////////////////////////////////////////////////////////////////////////////////////////////////

//2.1 192-KeyExpansion.
parameter NK_192 = 6;
parameter NR_192 = 12;
wire [32*NK_192 - 1:0] key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617 ;
wire [128*(NR_192 + 1) - 1:0] AllKeys192;
KeyExpansion #(NK_192, NR_192) key_expander_192 (key192, AllKeys192);

//2.2 Cipher with 192_key.
wire [127:0] input_cipher192 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] expected_cipher192 = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
wire [127:0] cipher192;
AES_Cipher #(NR_192) cipher_192 (clk, input_cipher192, AllKeys192, reset, cipher192);

//2.3 deCipher with 192_key.
wire [127:0] input_decipher192;
wire [127:0] expected_decipher192 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] decipher192;
AES_DeCipher #(NR_192) decipher_192 (clk, input_decipher192, reset, enable192, AllKeys192, decipher192);

/////////////////////////////////////////////////////////////////////////////////////////////////

//3.1 256-KeyExpansion.
parameter NK_256 = 8;
parameter NR_256 = 14;
wire [32*NK_256 - 1:0] key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
wire [128*(NR_256 + 1) - 1:0] AllKeys256;
KeyExpansion #(NK_256, NR_256) key_expander_256 (key256, AllKeys256);

//3.2 Cipher with 256_key.
wire [127:0] input_cipher256 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] expected_cipher256 = 128'h8ea2b7ca516745bfeafc49904b496089;
wire [127:0] cipher256;
AES_Cipher #(NR_256) cipher_256 (clk, input_cipher256, AllKeys256, reset, cipher256);

//3.3 deCipher with 256_key.
wire [127:0] input_decipher256;
wire [127:0] expected_decipher256 = 128'h00112233445566778899aabbccddeeff;
wire [127:0] decipher256;
AES_DeCipher #(NR_256) decipher_256 (clk, input_decipher256, reset, enable256, AllKeys256, decipher256);

/////////////////////////////////////////////////////////////////////////////////////////////////

wire [7:0] bcdinput; //set in the always block
assign bcdinput = 
(mode==2'b00 && i<=12) ? cipher128[7:0] :
(mode==2'b00 &&  i>12) ? decipher128[7:0] :
(mode==2'b01 && i<=14) ? cipher192[7:0] :
(mode==2'b01 &&  i>14) ? decipher192[7:0] :
(mode==2'b10 && i<=16) ? cipher256[7:0] :
(mode==2'b10 &&  i>16) ? decipher256[7:0] :
cipher128[7:0];
always @ (posedge clk or posedge reset)
begin
    if(reset)begin
        i=0;
        enable128 =0;
        enable192 =0;
        enable256 =0;
        isEqual = 0;
    end
    
    else begin
    i=i+1;
    if(i>=12) enable128=1;
    else enable128=0;
    if(i>=14) enable192=1;
    else enable192=0;
    if(i>=16) enable256 =1;
    else enable256=0;    
    if(i==0) isEqual=0;
    if(decipher128==input_cipher128 && mode==2'b00)
        isEqual=1;
    if(decipher192==input_cipher192 && mode==2'b01)
        isEqual=1;
    if(decipher256==input_cipher256 && mode==2'b10)
        isEqual=1;
    end
end
assign input_decipher128 = (enable128 && mode ==2'b00) ? cipher128 :128'bx;
assign input_decipher192 = (enable192 && mode ==2'b01) ? cipher192 :128'bx;
assign input_decipher256 = (enable256 && mode ==2'b10) ? cipher256 :128'bx;

// always@(negedge reset)
// begin
//     i=0;
// end
// always @(posedge clk)
// begin
//     i=i+1;
//     case (mode)
//         2'b00:begin
//             if(enable)begin
//                 bcdinput = decipher128[7:0];
//                 if(decipher128 == expected_decipher128)
//                     isEqual=1;
//             end
//             else begin
//                 bcdinput = cipher128[7:0];
//                 if(cipher128 == expected_cipher128)
//                     isEqual=1;
//             end
//         end
//         2'b01:begin
//             if(enable)begin
//                 bcdinput = decipher192[7:0];
//                 if(decipher192 == expected_decipher192)
//                     isEqual=1;
//             end
//             else begin
//                 bcdinput = cipher192[7:0];
//                 if(cipher192 == expected_cipher192)
//                     isEqual=1;
//             end
//         end
//         2'b10:begin
//             if(enable)begin
//                 bcdinput = decipher256[7:0];
//                 if(decipher256 == expected_decipher256)
//                     isEqual=1;
//             end
//             else begin
//                 bcdinput = cipher256[7:0];
//                 if(cipher256 == expected_cipher256)
//                     isEqual=1;
//             end
//         end
//         default: bcdinput = 0;
//     endcase
// end

//Binary to 7-segment.
wire [11:0] outbcd;

BinarytoBCD b(bcdinput,outbcd);
//bcdto7seg d(outbcd,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
bcdto7seg d(outbcd,HEX0,HEX1,HEX2);

endmodule

module bcdto7seg (
input [11:0] bcd,
output [6:0] HEX0
, output [6:0] HEX1
, output [6:0] HEX2
//, output[6:0] HEX3
//, output[6:0] HEX4
//,output [6:0] HEX5
);
reg [6:0]HEX0reg;
reg [6:0]HEX1reg;
reg [6:0]HEX2reg;

always@*
begin
    case (bcd[3:0])
        4'b0000: HEX0reg = 7'b1000000;
        4'b0001: HEX0reg = 7'b1111001;
        4'b0010: HEX0reg = 7'b0100100;
        4'b0011: HEX0reg = 7'b0110000;
        4'b0100: HEX0reg = 7'b0011001;
        4'b0101: HEX0reg = 7'b0010010;
        4'b0110: HEX0reg = 7'b0000010;
        4'b0111: HEX0reg = 7'b1111000;
        4'b1000: HEX0reg = 7'b0000000;
        4'b1001: HEX0reg = 7'b0010000;
        default: HEX0reg = 7'b1111111;
    endcase
    case (bcd[7:4])
        4'b0000: HEX1reg = 7'b1000000;
        4'b0001: HEX1reg = 7'b1111001;
        4'b0010: HEX1reg = 7'b0100100;
        4'b0011: HEX1reg = 7'b0110000;
        4'b0100: HEX1reg = 7'b0011001;
        4'b0101: HEX1reg = 7'b0010010;
        4'b0110: HEX1reg = 7'b0000010;
        4'b0111: HEX1reg = 7'b1111000;
        4'b1000: HEX1reg = 7'b0000000;
        4'b1001: HEX1reg = 7'b0010000;
        default: HEX1reg = 7'b1111111;
    endcase
    case (bcd[11:8])
        4'b0000: HEX2reg = 7'b1000000;
        4'b0001: HEX2reg = 7'b1111001;
        4'b0010: HEX2reg = 7'b0100100;
        4'b0011: HEX2reg = 7'b0110000;
        4'b0100: HEX2reg = 7'b0011001;
        4'b0101: HEX2reg = 7'b0010010;
        4'b0110: HEX2reg = 7'b0000010;
        4'b0111: HEX2reg = 7'b1111000;
        4'b1000: HEX2reg = 7'b0000000;
        4'b1001: HEX2reg = 7'b0010000;
        default: HEX2reg = 7'b1111111;
    endcase
end
assign HEX0=HEX0reg;
assign HEX1=HEX1reg;
assign HEX2=HEX2reg;
//assign HEX3=7'b1111111;
//assign HEX4=7'b1111111;
//assign HEX5=7'b1111111;
endmodule