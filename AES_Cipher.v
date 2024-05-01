module AES_Cipher#(parameter NR = 10,parameter NK = 4)(input clk ,output [127:0] out);
wire [128*(NR+1)-1:0] ExpandedKeys;
wire [127:0] input_bytes = 128'h00112233445566778899aabbccddeeff;
reg  [127:0] state;
wire [127:0] afterfirstround;
wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;
wire [32*NK-1:0] input_key = 128'h000102030405060708090a0b0c0d0e0f;

KeyExpansion #(NK, NR) key_expander (input_key, ExpandedKeys);

integer i = 0;

AddRoundKey r(input_bytes, AllKeys128[1407-:128], afterfirstround);
always@*
state<=afterfirstround;
EncyrptRound enc_rnd(state, AllKeys128[(1407-i*128)-:128], out_state);

always @(posedge clk) begin
		if(i<NR) begin
			i = i+1;
			state<=out_state;
		end
		else if(i==NR)begin
			state<= afterlastround;
			i=i+1;
		end
end

SubBytes s_bytes(state,afterSubBytes);
ShiftRows s_rows(afterSubBytes,afterShiftRows);
AddRoundKey r_key(afterShiftRows,AllKeys128[127:0],afterlastround);
assign out = state;

endmodule
