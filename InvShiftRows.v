module InvShiftRows (shiftedMatrix, originalMatrix);
	input [0:127] shiftedMatrix;
	output [0:127] originalMatrix;
	
	// First row isn't shifted
	assign originalMatrix[0+:8] = shiftedMatrix[0+:8];
	assign originalMatrix[32+:8] = shiftedMatrix[32+:8];
	assign originalMatrix[64+:8] = shiftedMatrix[64+:8];
    assign originalMatrix[96+:8] = shiftedMatrix[96+:8];
	
	// Second row is shifted right by 1
    assign originalMatrix[8+:8] = shiftedMatrix[104+:8];
    assign originalMatrix[40+:8] = shiftedMatrix[8+:8];
    assign originalMatrix[72+:8] = shiftedMatrix[40+:8];
    assign originalMatrix[104+:8] = shiftedMatrix[72+:8];
	
	// Third row is shifted right by 2
    assign originalMatrix[16+:8] = shiftedMatrix[80+:8];
    assign originalMatrix[48+:8] = shiftedMatrix[112+:8];
    assign originalMatrix[80+:8] = shiftedMatrix[16+:8];
    assign originalMatrix[112+:8] = shiftedMatrix[48+:8];
	
	// Fourth row is shifted right by 3
    assign originalMatrix[24+:8] = shiftedMatrix[56+:8];
    assign originalMatrix[56+:8] = shiftedMatrix[88+:8];
    assign originalMatrix[88+:8] = shiftedMatrix[120+:8];
    assign originalMatrix[120+:8] = shiftedMatrix[24+:8];

endmodule