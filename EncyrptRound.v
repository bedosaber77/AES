module EncyrptRound( input [127:0] in ,input [127:0] key,output [127:0] out );

wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;
wire [127:0] afterMixColumns;
wire [127:0] afterAddroundKey;

SubBytes s_bytes(in,afterSubBytes);
ShiftRows s_rows(afterSubBytes,afterShiftRows);
MixColumns m_cols(afterShiftRows,afterMixColumns);
AddRoundKey r_key(afterMixColumns,key,afterAddroundKey);
assign out = afterAddroundKey;

endmodule
