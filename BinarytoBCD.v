module BinarytoBCD (
    input [7:0] binary,
    output [11:0] bcd
);

reg [3:0] units;
reg [3:0] tens;
reg [3:0] hundreds;


integer i;

initial begin
  units = 0;
  tens = 0;
  hundreds = 0;
    for (i = 0; i < 8; i = i + 1) begin

        if (units[3:0] > 4) units = units + 3;
        if (tens[3:0] > 4) tens = tens + 3;

        hundreds ={ hundreds[2:0],tens[3]};
        tens = {tens[2:0],units[3]};
        units = {units[2:0],binary[7-i]};

    end
end

assign bcd = {hundreds[3:0], tens[3:0], units[3:0]};

endmodule