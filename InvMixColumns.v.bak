module InvMixColumns(input [127:0] in , output [127:0] out);

function [7:0] multiply2 (input [7:0] input_byte);
    begin
            multiply2 = (input_byte[7] == 1) ? ((input_byte << 1) ^ 8'h1b) : (input_byte << 1);
        end
endfunction

function [7:0] multiply9(input[7:0] input_byte);
begin
    multiply9 = multiply2(multiply2(multiply2(input_byte)))^input_byte;
end
endfunction
function [7:0] multiplyB(input[7:0] input_byte);
begin
    multiplyB = multiply2(multiply2(multiply2(input_byte))^input_byte)^input_byte;
end
endfunction
function [7:0] multiplyD(input[7:0] input_byte);
begin
    multiplyD = multiply2(multiply2(multiply2(input_byte)^input_byte))^input_byte;
end
endfunction
function [7:0] multiplyE(input[7:0] input_byte);
begin
    multiplyE = multiply2(multiply2(multiply2(input_byte)^input_byte)^input_byte);
end
endfunction

genvar i;
generate 
for(i = 0 ; i < 4 ; i = i +1)//for each column
    begin
      assign out[i*32+24 +:8] = multiplyE(in[i*32+24 +:8])^multiplyB(in[i*32+16 +:8])^multiplyD(in[i*32+8 +:8])^multiply9(in[i*32 +:8]);
      assign out[i*32+16 +:8] = multiply9(in[i*32+24 +:8])^multiplyE(in[i*32+16 +:8])^multiplyB(in[i*32+8 +:8])^multiplyD(in[i*32 +:8]); 
      assign out[i*32+8  +:8] = multiplyD(in[i*32+24 +:8])^multiply9(in[i*32+16 +:8])^multiplyE(in[i*32+8 +:8])^multiplyB(in[i*32 +:8]);
      assign out[i*32    +:8] = multiplyB(in[i*32+24 +:8])^multiplyD(in[i*32+16 +:8])^multiply9(in[i*32+8 +:8])^multiplyE(in[i*32 +:8]);
    end
endgenerate 

endmodule
