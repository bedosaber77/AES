module KeyExpansion(input [127:0] initialKey, output reg [1407:0] expandedKeys);
integer i;
reg [31:0] temp;
reg [7:0] shift;
initial 
begin
    expandedKeys[1407-:128] = initialKey[127-:128];
  for(i = 0; i<40; i=i+1) 
  begin
    temp = expandedKeys[(1407-(i+3)*32)-:32];
    if(i % 4 == 0) 
    begin
      shift = temp[31-:8];
      temp = {temp, shift};
      // subBytes(temp) ^ Rcon 
    end
    /*if(i % 4 == 0) begin //for test only
      temp = 32'h8b84db01;
    end*/
    expandedKeys[(1407-(i+4)*32)-:32] = expandedKeys[(1407-(i)*32)-:32] ^ temp;
  end
end
endmodule