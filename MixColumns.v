module MixColumns (input [127:0]in ,output [127:0]out);

function [7:0] multiply2 (input [7:0] input_byte);
    begin
            multiply2 = (input_byte[7] == 1) ? ((input_byte << 1) ^ 8'h1b) : (input_byte << 1);
        end
endfunction

function [7:0] multiply3(input[7:0] input_byte);
begin
    multiply3 = multiply2(input_byte) ^ input_byte;
end
endfunction

genvar i;
generate 
for(i = 0 ; i < 4 ; i = i +1)//for each column
    begin
      assign out[i*32+24 +:8] = multiply2(in[i*32+24 +: 8])^multiply3(in[i*32+16 +:8]) ^ in[i*32+8 +:8] ^ in[i*32 +:8];
      assign out[i*32+16 +:8] = in[i*32+24 +:8]^ multiply2(in[i*32+16 +:8])^multiply3(in[i*32+8 +:8])^in[i*32 +:8]; 
      assign out[i*32+8  +:8] = in[i*32+24 +:8]^in[i*32+16 +:8]^multiply2(in[i*32+8 +:8])^multiply3(in[i*32 +:8]);
      assign out[i*32    +:8] = multiply3(in[i*32+24 +:8])^ in[i*32+16 +:8]^in[i*32+8 +:8]^multiply2(in[i*32 +:8]);
    end
endgenerate 
endmodule