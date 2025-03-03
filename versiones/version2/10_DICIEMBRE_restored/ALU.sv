module ALU(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] ALU_control,
    output logic [31:0] result,
    output logic zero_flag
);

    always @(ALU_control, A, B)
			case(ALU_control)
            
            4'b0000: result = A + B; // ADDI o ADD o JAL o SW o JALR o AUIPC O LW
            4'b0001: result = ($signed(A) < $signed(B)) ? 1 : 0; // SLTI o SLT
            4'b0010: result = (A < B) ? 1 : 0; // SLTIU o SLTU
            4'b0011: result = A & B; // ANDI o AND
            4'b0100: result = A | B; // ORI o OR
            4'b0101: result = A ^ B; // XORI o XOR
            4'b0110: result = B << 12; // LUI
            4'b0111: result = A << B; // SLLI o SLL
            4'b1000: result = (B[31]) ? (A >>> B) : (A >> B); // SRLI/SRAI o SRL/SRA
            4'b1001: result = A - B; // SUB


            // Instrucciones de control de flujo
            4'b1010: // BEQ
							if (A == B)
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
					
            4'b1011:	if (A != B)// BNE
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
				
				4'b1100: if ($signed(A) < $signed(B)) // BLT 
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
							
				4'b1101: if (A < B) // BLTU  
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
								
				4'b1110: if ($signed(A) > $signed(B)) // BGEU 
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
								
				4'b1111: if (A > B) // BGE
								begin
									zero_flag = 1;
									result = 0;
								end
							else
								result = 32'd82;
				
            default: begin
								zero_flag = 0;
								result = 0;
							end
        endcase
//assign zero_flag = (result == 32'd0);		  
		  
endmodule

            