module DecyrptRound( input [127:0] in ,input [127:0] key,output [127:0] out );

wire [127:0] afterinvSubBytes;
wire [127:0] afterinvShiftRows;
wire [127:0] afterinvMixColumns;
wire [127:0] afterAddroundKey;

InvSubBytes s_bytes(in,afterinvSubBytes);
InvShiftRows s_rows(afterinvSubBytes,afterinvShiftRows);
InvMixColumns m_cols(afterinvShiftRows,afterinvMixColumns);
AddRoundKey r_key(afterinvMixColumns,key,afterAddroundKey);
assign out = afterAddroundKey;

endmodule
