module AES_DeCipher#(parameter NR = 10,parameter NK = 4)(input clk , output [127:0] out);
wire [128*(NR+1)-1:0] ExpandedKeys;
wire [127:0] input_bytes = 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
reg  [127:0] state;
wire [127:0] afterfirstround;
wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;
wire [32*NK-1:0] input_key = 128'h000102030405060708090a0b0c0d0e0f;

KeyExpansion #(NK, NR) key_expander (input_key, ExpandedKeys);
integer i = NR;

AddRoundKey r(input_bytes, ExpandedKeys[127-:128], afterfirstround);
always@*
state <= afterfirstround;
DecyrptRound dec_rnd(state, ExpandedKeys[(1407-(i)*128)-:128], out_state);

always @(posedge clk) begin
	if(i>0) begin
		i = i-1;
		state<=out_state;
	end 
	else if(i==0)begin
			state<= afterlastround;
			i=i-1;
		end
end

InvShiftRows s_rows(state,afterShiftRows);
InvSubBytes s_bytes(afterShiftRows,afterSubBytes);
AddRoundKey r_key(afterSubBytes,  ExpandedKeys[1407-:128],afterlastround);
assign out = state;

endmodule