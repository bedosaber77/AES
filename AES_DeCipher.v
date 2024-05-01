module AES_DeCipher#(parameter NR = 10)(input clk ,input [127:0]input_bytes, input[128*(NR+1)-1:0] ExpandedKeys, output [127:0] out);
//input[128*(NR+1)-1:0] ExpandedKeys;
//wire [127:0]input_key;
reg  [127:0] state;
wire  [127:0] afterfirstround;
wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;


integer i = 1;

AddRoundKey r(input_bytes, ExpandedKeys[127:0], afterfirstround);
initial
state <= afterfirstround;
DecyrptRound dec_rnd(state, ExpandedKeys[(i*128)+:128], out_state);

always @(posedge clk) begin
	if(i<NR) begin
		i = i+1;
		state<=out_state;
	end 
end

InvSubBytes s_bytes(state,afterSubBytes);
InvShiftRows s_rows(afterSubBytes,afterShiftRows);
AddRoundKey r_key(afterShiftRows,ExpandedKeys[1407-:128],afterlastround);
assign out = afterlastround;

endmodule