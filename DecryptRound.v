module DecyrptRound( input [127:0] in ,input [127:0] key,output [127:0] out );

wire [127:0] afterinvSubBytes;
wire [127:0] afterinvShiftRows;
wire [127:0] afterinvMixColumns;
wire [127:0] afterAddroundKey;

InvShiftRows s_rows(in,afterinvShiftRows);
InvSubBytes s_bytes(afterinvShiftRows,afterinvSubBytes);
AddRoundKey r_key(afterinvSubBytes,key,afterAddroundKey);
InvMixColumns m_cols(afterAddroundKey,afterinvMixColumns);
assign out = afterinvMixColumns;

endmodule
