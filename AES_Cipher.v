module AES_Cipher#(parameter NR = 10,parameter NK = 4)(clk,input_bytes,ExpandedKeys,reset ,out);
input clk;
input [127:0] input_bytes;
input [128*(NR+1)-1:0] ExpandedKeys;
input reset;
output [127:0] out;
reg  [127:0] state;
wire [127:0] afterfirstround;
wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;

integer i = 0;

AddRoundKey r(input_bytes, ExpandedKeys[((NR+1)*128-1)-:128], afterfirstround);


EncyrptRound enc_rnd(state, ExpandedKeys[(((NR+1)*128-1)-i*128)-:128], out_state);

always @(posedge clk or posedge reset) begin
	if(reset)
		state<=afterfirstround;
	else if (i==0) begin
	state<=afterfirstround;
	i=i+1;
	end
	else if(i<NR) begin
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
AddRoundKey r_key(afterShiftRows,ExpandedKeys[127:0],afterlastround);
assign out = state;

endmodule
