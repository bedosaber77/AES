module AES_DeCipher#(parameter NR = 10,parameter NK = 4)(clk,input_bytes,reset,enable,ExpandedKeys ,out);
input clk;
input reset;
input enable;
input [127:0] input_bytes;
input [128*(NR+1)-1:0] ExpandedKeys;
output [127:0] out;
reg  [127:0] state;
wire [127:0] afterfirstround;
wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;


integer i = NR+1;

AddRoundKey r(input_bytes, ExpandedKeys[127-:128], afterfirstround);

DecyrptRound dec_rnd(state, ExpandedKeys[(((NR+1)*128-1)-(i-1)*128)-:128], out_state);

always @(posedge clk or posedge reset) begin
	if(reset) begin
		i=NR+1;
		state<=128'b0;
	end
	else if (enable && i==(NR+1)) begin
		i=i-1;
		//state<=out_state;
		state<=afterfirstround;
	end	
	else if(enable && i>1) begin 
		i=i-1;
		state<=out_state;
		//state<=128'b10;
	end 
	else if(enable && i==1)begin
		state<= afterlastround;
		i=i-1;
	end
end

InvShiftRows s_rows(state,afterShiftRows);
InvSubBytes s_bytes(afterShiftRows,afterSubBytes);
AddRoundKey r_key(afterSubBytes,  ExpandedKeys[((NR+1)*128-1)-:128],afterlastround);

//assign out = state;
assign out = (i==NR && enable) ? afterfirstround : state;
endmodule