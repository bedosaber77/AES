// module doubledabble (
//     input [7:0] binary,
//     output reg [11:0] out
// );

// reg [3:0] units= 4'b0000;
// reg [3:0] tens= 4'b0000;
// reg [3:0] hundreds= 4'b0000;


// integer i;

// always @(binary) begin
//     for (i = 0; i < 8; i = i + 1) begin

//         if (units[3:0] > 4) units = units + 3;
//         if (tens[3:0] > 4) tens = tens + 3;

//         hundreds <={ hundreds[2:0],tens[3]};
//         tens <= {tens[2:0],units[3]};
//         units <= {units[2:0],binary[7-i]};

//     end
// end

// assign out = {hundreds[3:0], tens[3:0], units[3:0]};

// endmodule

module doubledabble
  ( input      [7:0] binary   , 
    output reg [11:0] bcd   );

  integer i,j;

  always @(bin) begin
    for(i = 0; i <= 11; i = i+1) bcd[i] = 0;     
    bcd[7:0] = bin;                                  
    for(i = 0; i <= 4; i = i+1)                       
      for(j = 0; j <= i/3; j = j+1)                     
        if (bcd[8-i+4*j -: 4] > 4)                      
          bcd[8-i+4*j -: 4] = bcd[8-i+4*j -: 4] + 4'd3; 
  end

endmodule