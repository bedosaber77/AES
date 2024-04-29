module ShiftRows (insertedMatrix, shiftedMatrix);
	input [0:127] insertedMatrix;
	output [0:127] shiftedMatrix;
	
	// First row isn't shifted
	assign shiftedMatrix[0+:8] = insertedMatrix[0+:8];
	assign shiftedMatrix[32+:8] = insertedMatrix[32+:8];
	assign shiftedMatrix[64+:8] = insertedMatrix[64+:8];
    assign shiftedMatrix[96+:8] = insertedMatrix[96+:8];
	
	// Second row is shifted left by 1
    assign shiftedMatrix[8+:8] = insertedMatrix[40+:8];
    assign shiftedMatrix[40+:8] = insertedMatrix[72+:8];
    assign shiftedMatrix[72+:8] = insertedMatrix[104+:8];
    assign shiftedMatrix[104+:8] = insertedMatrix[8+:8];
	
	// Third row is shifted left by 2
    assign shiftedMatrix[16+:8] = insertedMatrix[80+:8];
    assign shiftedMatrix[48+:8] = insertedMatrix[112+:8];
    assign shiftedMatrix[80+:8] = insertedMatrix[16+:8];
    assign shiftedMatrix[112+:8] = insertedMatrix[48+:8];
	
	// Fourth row is shifted left by 3
    assign shiftedMatrix[24+:8] = insertedMatrix[120+:8];
    assign shiftedMatrix[56+:8] = insertedMatrix[24+:8];
    assign shiftedMatrix[88+:8] = insertedMatrix[56+:8];
    assign shiftedMatrix[120+:8] = insertedMatrix[88+:8];

endmodule