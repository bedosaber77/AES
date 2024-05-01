module AES_Cipher#(parameter NR = 10,parameter NK = 4)(input clk ,output [127:0] out_state);
//input[128*(NR+1)-1:0] ExpandedKeys;
//wire [127:0]input_key;
wire [127:0] input_bytes = 128'h3243f6a8885a308d313198a2e0370734;
reg  [127:0] state;
wire [127:0] afterfirstround;
//wire [127:0] out_state;
wire [127:0] afterlastround;
wire [127:0] afterSubBytes;
wire [127:0] afterShiftRows;
wire [32*NK-1:0] key128 = 128'h2b7e151628aed2a6abf7158809cf4f3c;
wire [128*(NR+1)-1:0] AllKeys128; 
hello #(NK, NR) key_expander (key128, AllKeys128);

integer i = 0;

AddRoundKey r(input_bytes, AllKeys128[127:0], afterfirstround);
always@*
state<=afterfirstround;
EncyrptRound enc_rnd(state, AllKeys128[(i*128)+:128], out_state);

always @(posedge clk) begin
		if(i<NR) begin
			i = i+1;
			state<=out_state;
		end
		else if(i==NR)
			state<= afterlastround;
end

SubBytes s_bytes(state,afterSubBytes);
ShiftRows s_rows(afterSubBytes,afterShiftRows);
AddRoundKey r_key(afterShiftRows,AllKeys128[1407-:128],afterlastround);
assign out = state;

endmodule
/*
module cipher();

reg input_bytes[127:0] , input_key[1407:0];
wire out;

always #20 clk = ~clk;
 initial begin
    clk <= 0;
	
end

endmodule*/