

module AES_Cipher(input clk ,input [127:0]input_bytes, output [127:0] out);


wire [127:0]input_key;
wire [1407:0] expandedKeys;
reg  [127:0] state;
wire [127:0] out_state;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;


integer i ;
KeyExpansion key(input_key,expandedKeys);
AddRoundKey r(input_bytes,expandedKeys[127:0],out_state);
EncyrptRound enc_rnd(state, expandedKeys[((i+1)*128)-:128],out_state);

initial begin

for(i=1; i<10 ;i=i+1)begin
	state<=out_state;
end
end
SubBytes s_bytes(state,afterSubBytes);
ShiftRows s_rows(afterSubBytes,afterShiftRows);
AddRoundKey r_key(afterShiftRows,expandedKeys[1407-:128],out_state);
assign out =out_state;
endmodule