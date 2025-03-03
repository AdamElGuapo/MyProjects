`timescale 1ns/100ps
module tb_micro (); 
	localparam T=20; 
	
	// DUV instance 
	logic clk, reset; 
	
	logic [31:0] w1, w2, w3, w4, w5; 
	logic w6, w7;   
	


covergroup covertura @(posedge clk);

	func3: coverpoint w2[14:12]; //coverpoint para todos los posibles valores de func3
	opcode: coverpoint w2[6:0]
	{
	bins Bformat_bin = {99};
	bins Uformat_bin = {55};
	bins Rformat_bin = {51};
	bins Sformat_bin = {35};
	bins Jformat_bin = {111};
	illegal_bins others = default;
	}
	r1: coverpoint w2[19:15];
	r2: coverpoint w2[24:20];
	instr: cross func3, opcode;

endgroup;
	
	
	
	
	
fase1 duv(.CLK(clk), .RESET(reset), .INSTRUCCION_IF(w2), .READ_DATA_MEM(w5), .READ_DATA_2_MEM(w3), 
.ALU_RESULT_MEM(w4), .PC_IF(w1), .MEMWRITE_MEM(w6), .MEM_READ(w7)); 

//RAM ram (.clk(clk), .write_data(READ_DATA_2_MEM), .address(ALU_RESULT_MEM[11:2]), .read_data(READ_DATA_MEM), .MemWrite(MEMWRITE_MEM), .MemRead(MEM_READ));
RAM ram(.clk(clk), .write_data(w3), .address(w4[11:2]), .read_data(w5), .MemWrite(w6), .MemRead(w7));

//ROM rom (.address(PC_IF[11:2]), .data_out(INSTRUCCION_IF));
ROM rom(.address(w1[11:2]), .data_out(w2));  
	
	//¿el test bench es sobre el micro o sobre el core?
	
	
// Generador de instrucciones aleatorias


class pruebas_concretas; // se trabaja con r1=x1, r2=x2, rd=x2 el inmediato es 16
rand logic [31:0] INSTRUCCION;
constraint Bformat {INSTRUCCION[31:25]==5'd0; INSTRUCCION[24:20]==5'd2; INSTRUCCION[19:15]==5'd1; INSTRUCCION[11:8]==4'd8; INSTRUCCION[7]==1'd0; INSTRUCCION[6:0]==7'b1100011;}
constraint Uformat {INSTRUCCION[31:12]==20'd16; INSTRUCCION[11:7]==5'd2; INSTRUCCION[6:0]==7'b0110111;}
constraint Rformat {INSTRUCCION[31]==1'b0; INSTRUCCION[29:25]==5'd0; INSTRUCCION[24:20]==5'd2; INSTRUCCION[19:15]==5'd1; INSTRUCCION[11:7]==5'd2; INSTRUCCION[6:0]==7'b0110011;}
constraint Sformat {INSTRUCCION[31:25]==5'd0; INSTRUCCION[24:20]==5'd2; INSTRUCCION[19:15]==5'd1; INSTRUCCION[11:7]==5'd16; INSTRUCCION[6:0]==7'b0100011;}
constraint Jformat {INSTRUCCION[31]==1'b0; INSTRUCCION[30:20]==11'd16; INSTRUCCION[19:12]; INSTRUCCION[11:7]==5'd2; INSTRUCCION[6:0]==7'b1101111;}


class todo_random; // aquí se testean todos los registros y sin limite de inmediatos 
rand logic [31:0] INSTRUCCION;
constraint Bformat {INSTRUCCION[6:0]==7'b1100011;}// ¿que haya dos logic llamados INSTRUCCION en diferentes clases esta bien? 
constraint Uformat {INSTRUCCION[6:0]==7'b0110111;}
constraint Rformat {INSTRUCCION[6:0]==7'b0110011;}
constraint Sformat {INSTRUCCION[6:0]==7'b0100011;}
constraint Jformat {INSTRUCCION[6:0]==7'b1101111;}

covertura cov;
pruebas_concretas pcon;
todo_random tra;

task desactivo;
begin
pcon.Bformat.constraint_mode(0);
pcon.Uformat.constraint_mode(0);
pcon.Rformat.constraint_mode(0);
pcon.Sformat.constraint_mode(0);
pcon.Jformat.constraint_mode(0);

tra.Bformat.constraint_mode(0);
tra.Uformat.constraint_mode(0);
tra.Rformat.constraint_mode(0);
tra.Sformat.constraint_mode(0);
tra.Jformat.constraint_mode(0);
end
endtask 

task pB;
	wait(INSTRUCCION)begin //¿esta tarea se espera hasta que INSTRUCCION se actualize?
	reset=1'b1; //¿el reset es negado?
	pcon.Bformat.constraint_mode(1);
	$display("tarea Bformat");
	assert (pcon.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask



task pU;
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	pcon.Uformat.constraint_mode(1);
	$display("tarea Uformat");
	assert (pcon.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task pR;
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	pcon.Rformat.constraint_mode(1);
	$display("tarea Rformat");
	assert (pcon.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task pS;
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	pcon.Sformat.constraint_mode(1);
	$display("tarea Sformat");
	assert (pcon.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task pJ;
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	pcon.Jformat.constraint_mode(1);
	$display("tarea Jformat");
	assert (pcon.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask




task tB;
	repeat(50)
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	tra.Bformat.constraint_mode(1);
	$display("tarea Bformat (todo aleatorio)");
	assert (tra.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task tU;
	repeat(50)
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	tra.Uformat.constraint_mode(1);
	$display("tarea Uformat (todo aleatorio)");
	assert (tra.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task tR;
	repeat(50)
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	tra.Rformat.constraint_mode(1);
	$display("tarea Rformat (todo aleatorio)");
	assert (tra.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task tS;
	repeat(50)
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	tra.Sformat.constraint_mode(1);
	$display("tarea Sformat (todo aleatorio)");
	assert (tra.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task tJ;
	repeat(50)
	wait(INSTRUCCION)begin 
	reset=1'b1; 
	tra.Jformat.constraint_mode(1);
	$display("tarea Jformat (todo aleatorio)");
	assert (tra.randomize()) else    $fatal("randomization failed");
	w2<=INSTRUCCION;
	
	end
endtask

task reset;
begin

//Reset de 4 ciclos asíncrono
        reset=1'b0;
        repeat(4) @(negedge clk);
//Desactivamos el reset
        reset=1'b1;


end
endtask 
	//	clock generation
	always@* 
	begin 
		#(T/2)  clk = ~clk; 
	end
	
	// Test procedure
	
	initial 
	begin 
		pcon=new;
		tra=new;
		cov=new;
	
		desactivo();
		reset();
		
		pB();
		desactivo();
		
		pU();
		desactivo();
		
		pR();
		desactivo();
		
		pS();
		desactivo();
		
		pJ();
		desactivo();
		
		tB();
		desactivo();
		
		tU();
		desactivo();
		
		tR();
		desactivo();
		
		tS();
		desactivo();
		
		tJ();
		desactivo();
		
		
		
		
		$display("Test finished"); 
		$stop; 
	end
	
endmodule 

/*

randcase //¿el randcase lo meto en una funcion o en una task?
    0: instr = 7'b; // ADD //¿que codificación uso?
    1: instr = 7'b; // AUIPC
    2: instr = 7'b; // JAL
    3: instr = 7'b; // JALR
    4: instr = 7'b; // BEQ
    5: instr = 7'b; // BNE
    6: instr = 7'b; // BLT
    7: instr = 7'b; // BGE
    8: instr = 7'b; // BLTU
    9: instr = 7'b; // BGEU
    10: instr = 7'b; // LB
    11: instr = 7'b; // LH
    12: instr = 7'b; // LW
    13: instr = 7'b; // LBU
    14: instr = 7'b; // LHU
    15: instr = 7'b; // SB
    16: instr = 7'b; // SH
    17: instr = 7'b; // SW
    18: instr = 7'b; // ADDI
    19: instr = 7'b; // SLTI
    20: instr = 7'b; // SLTIU
    21: instr = 7'b; // XORI
    22: instr = 7'b; // ORI
    23: instr = 7'b; // ANDI
    24: instr = 7'b; // SLLI
    25: instr = 7'b; // SRLI
    26: instr = 7'b; // SRAI
    27: instr = 7'b; // ADD
    28: instr = 7'b; // SUB
    29: instr = 7'b; // SLL
    30: instr = 7'b; // SLT
    31: instr = 7'b; // SLTU
    32: instr = 7'b; // XOR
    33: instr = 7'b; // SRL
    34: instr = 7'b; // SRA
    35: instr = 7'b; // OR
    36: instr = 7'b; // AND
  endcase
end
