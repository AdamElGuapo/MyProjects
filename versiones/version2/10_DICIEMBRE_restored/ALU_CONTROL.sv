module ALU_CONTROL (
    input logic [31:0] entrada, 
    input logic [2:0] alu_op, 
    output logic [3:0] alu_control
);

    reg [3:0] concatenacion;

    always @(alu_op, entrada) begin
        case (alu_op)
            3'b000: 
				begin
                concatenacion = {entrada[30], entrada[14:12]}; // RFORMAT
                case (concatenacion)
                    4'b0000: alu_control = 4'b0000; // ADD
                    4'b1000: alu_control = 4'b1001; // SUB
                    4'b0001: alu_control = 4'b0111; // SLL
                    4'b0010: alu_control = 4'b0001; // SLT
                    4'b0011: alu_control = 4'b0010; // SLTU
                    4'b0100: alu_control = 4'b0101; // XOR
                    4'b0101: alu_control = 4'b1000; // SRL
                    4'b1101: alu_control = 4'b1000; // SRA
                    4'b0110: alu_control = 4'b0100; // OR
                    4'b0111: alu_control = 4'b0011; // AND
                    default: alu_control = 4'b0000;
                endcase
            end
				
            3'b001: 
				begin
                concatenacion = {1'b0, entrada[14:12]}; // IFORMAT 
                case (concatenacion)
                    4'b0000: alu_control = 4'b0000; // ADDI
                    4'b0001: alu_control = 4'b0111; // SLLI
                    4'b0010: alu_control = 4'b0001; // SLTI
                    4'b0100: alu_control = 4'b0101; // XORI
                    4'b0101: alu_control = 4'b1000; // SRLI
                    4'b0110: alu_control = 4'b1000; // SRAI
                    4'b0111: alu_control = 4'b0100; // ORI
                    4'b1000: alu_control = 4'b0011; // ANDI
                    default: alu_control = 4'b0000;
                endcase
            end
				
            3'b010: 
				begin
                concatenacion = {1'b0, entrada[14:12]}; // BFORMAT 
                case (concatenacion)
                    4'b0000: alu_control = 4'b1010; // BEQ
                    4'b0001: alu_control = 4'b1011; // BNE
                    4'b0100: alu_control = 4'b1100; // BLT
                    4'b0101: alu_control = 4'b1111; // BGE
                    4'b0110: alu_control = 4'b1101; // BLTU
                    default: alu_control = 4'b0000;
                endcase
            end
				
            3'b011: 
				begin
                concatenacion = {1'b0, entrada[14:12]}; // SFORMAT 
                case (concatenacion)
                    4'b0010: alu_control = 4'b0000; // SW
                    default: alu_control = 4'b0000;
                endcase
            end
				
            3'b100: // UFORMAT 
                alu_control = 4'b0000; // AUIPC o LUI
					 
            3'b101: // JFORMAT  
                alu_control = 4'b0000; // JALR o JAL
					 
            3'b110: 
				begin
                concatenacion = {1'b0, entrada[14:12]}; // SFORMAT 
                case (concatenacion)
                    4'b0010: alu_control = 4'b0000; // LW
                    default: alu_control = 4'b0000;
                endcase
            end
				
            default: alu_control = 4'b0000;
				
        endcase
    end

endmodule
	