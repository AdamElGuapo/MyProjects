`timescale 1ns/100ps

class RCSC_ENTRADA; 
rand logic signed [31:0] A; 
rand logic signed [2:0] B; 
constraint siempre {A[31] == 1'b0 && A[29:15] == 15'b000000000000000 && A[11:0] == 12'b000000000000;}
constraint sub_andi {A[30] == 1'b1 && A[14:12] == 3'b000;}
constraint sra {A[30] == 1'b1 && A[14:12] == 3'b101;}
constraint cero {A[30] == 1'b0;}
constraint caso1{B == 3'b000;}
constraint caso2{B == 3'b001;}
constraint caso3{B == 3'b010;}
constraint caso4{B == 3'b011;}
constraint caso5{B == 3'b100;}
constraint caso6{B == 3'b101;}
constraint caso7{B == 3'b110;}
endclass

module tb_ALU_CONTROL (); 

	logic [31:0] ENTRADA; 
   logic [2:0] ALU_OP; 
   logic [3:0] ALU_CONTROL;
	
	//INSTANCIACION DEL DUV
	
	ALU_CONTROL duv (.entrada(ENTRADA), .alu_op(ALU_OP), .alu_control(ALU_CONTROL)); 

	// Test procedure
	
	RCSC_ENTRADA P; 
	initial 
	begin 
		P = new();
		ENTRADA = 32'd0; 
		ALU_OP = 3'b000; 
		#50 

		P.siempre.constraint_mode(1); 
		P.sub_andi.constraint_mode(1); 
		P.sra.constraint_mode(0);
		P.cero.constraint_mode(0); 
		P.caso1.constraint_mode(1); 
		P.caso2.constraint_mode(0); 
		P.caso3.constraint_mode(0); 
		P.caso4.constraint_mode(0); 
		P.caso5.constraint_mode(0); 
		P.caso6.constraint_mode(0); 
		P.caso7.constraint_mode(0);  
		
		begin
			P.randomize(); 
			ENTRADA = P.A; 
			ALU_OP = P.B; 
			//ENTRADA = 32'b01000000000000000000000000000000; 
			//ALU_OP = 3'b000; 
			#50;
		end

		$display("Test finished"); 
		$stop; 
	end
	
endmodule 