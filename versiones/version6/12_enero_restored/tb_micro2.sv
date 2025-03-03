`timescale 1ns/100ps
module tb_micro2 (); 

	localparam T=20; 
	
	
	// DUV instance 
	logic clk, reset; 
	
	logic [31:0] w1, w2, w3, w4, w5; 
	logic w6, w7;   


fase1 duv(.CLK(clk), .RESET(reset), .INSTRUCCION_IF(w2), 
.READ_DATA_MEM(w5), .READ_DATA_2_MEM(w3), 
.ALU_RESULT_MEM(w4), .PC_IF(w1), .MEMWRITE_MEM(w6), .MEM_READ(w7)); 

RAM ram(.clk(clk), .write_data(w3), .address(w4[11:2]), 
.read_data(w5), .MemWrite(w6), .MemRead(w7));

class RCSG_RISCV;
	rand logic [31:0]IN; //w2 es la instruccion
	constraint R_format    {IN[6:0] == 7'b0110011;} // obliga a que la instruccion sea R-format
	constraint R_format_a  {(IN[6:0] == 7'b0110011 && IN[14:12]!=3'b000 && IN[14:12]!=3'b101) -> IN[31:25]==7'b0000000 ;}
	constraint R_format_b  {(IN[6:0] == 7'b0110011 && (IN[14:12]==3'b000) || IN[14:12]==3'b101) -> IN[31:25]==7'b0000000 || IN[31:25]==7'b0100000 ;}
endclass

covergroup instrucciones @(posedge clk);
 
  rformat : coverpoint ({w2[30],w2[14:12]})  iff (w2[6:0]==7'b0110011 && w2[31]==1'b0 && w2[29:25]==5'b0000)
  {
      bins add ={0};
      bins sub={8};      
      bins sll={1};
      bins slt={2};
      bins sltu={3};
      bins ixor={4};
      bins slr={5};
      bins sra={13};
      bins ior={6};
      bins iand={7};
      illegal_bins imposibles_rformat={9,10,11,12,14,15}; 
  } 
endgroup

covergroup registros @(posedge clk);

	r1 : coverpoint ({w2[19:15]})  
	{
		bins x0 = {0};
		bins x1 = {1};
		bins x2 = {2};
		bins x3 = {3};
		bins x4 = {5};
		bins x5 = {6};
		bins x6 = {7};
		bins x7 = {8};
		bins x8 = {9};
		bins x9 = {10};
		bins x10 = {11};
		bins x11 = {12};
		bins x12 = {13};
		bins x14 = {14};
		bins x15 = {15};
		bins x16 = {16};
		bins x17 = {17};
		bins x18 = {18};
		bins x19 = {19};
		bins x20 = {20};
		bins x21 = {21};
		bins x22 = {22};
		bins x23 = {23};
		bins x24 = {24};
		bins x25 = {25};
		bins x26 = {26};
		bins x27 = {27};
		bins x28 = {28};
		bins x29 = {29};
		bins x30 = {30};
		bins x31 = {31};
	}
	r2 : coverpoint ({w2[24:20]})  
	{
		bins x0 = {0};
		bins x1 = {1};
		bins x2 = {2};
		bins x3 = {3};
		bins x4 = {5};
		bins x5 = {6};
		bins x6 = {7};
		bins x7 = {8};
		bins x8 = {9};
		bins x9 = {10};
		bins x10 = {11};
		bins x11 = {12};
		bins x12 = {13};
		bins x14 = {14};
		bins x15 = {15};
		bins x16 = {16};
		bins x17 = {17};
		bins x18 = {18};
		bins x19 = {19};
		bins x20 = {20};
		bins x21 = {21};
		bins x22 = {22};
		bins x23 = {23};
		bins x24 = {24};
		bins x25 = {25};
		bins x26 = {26};
		bins x27 = {27};
		bins x28 = {28};
		bins x29 = {29};
		bins x30 = {30};
		bins x31 = {31};
	}
	rd : coverpoint ({w2[11:7]})  
	{
		bins x0 = {0};
		bins x1 = {1};
		bins x2 = {2};
		bins x3 = {3};
		bins x4 = {5};
		bins x5 = {6};
		bins x6 = {7};
		bins x7 = {8};
		bins x8 = {9};
		bins x9 = {10};
		bins x10 = {11};
		bins x11 = {12};
		bins x12 = {13};
		bins x14 = {14};
		bins x15 = {15};
		bins x16 = {16};
		bins x17 = {17};
		bins x18 = {18};
		bins x19 = {19};
		bins x20 = {20};
		bins x21 = {21};
		bins x22 = {22};
		bins x23 = {23};
		bins x24 = {24};
		bins x25 = {25};
		bins x26 = {26};
		bins x27 = {27};
		bins x28 = {28};
		bins x29 = {29};
		bins x30 = {30};
		bins x31 = {31};
	}
endgroup 

sequence add_mal;
  logic [31:0]  src1,src2;
  logic [4:0]   add_destino;
  ({w2[30],w2[14:12]}==4'b0000, src1=w2[19:15], src2=w2[24:20],add_destino=w2[11:7]) ##1 (add_destino!=src1+src2, $display("en registro %d obtenido=%h esperado=%h",w2[11:7],add_destino,src1+src2));
endsequence

sequence add_bien;
  logic [31:0]  src1,src2;
  logic [4:0]   add_destino;
  ({w2[30],w2[14:12]}==4'b0000, src1=w2[19:15], src2=w2[24:20],add_destino=w2[11:7]) ##1 (add_destino==src1+src2);
endsequence

deteccion: assert property (@(posedge clk) disable iff (reset==1'b0) w2[6:0]==7'b0110011 && w2[31]==1'b0 && w2[29:25]==5'b0000|->add_bien )
else $error("R format add");
detalles: cover property (@(posedge clk) disable iff (reset==1'b0) w2[6:0]==7'b0110011 && w2[31]==1'b0 && w2[29:25]==5'b0000|->add_mal );

RCSG_RISCV generar_instrucciones;
instrucciones instr;
registros regi;
	always
	begin 
		#(T/2)  clk = ~clk; 
	end
	


initial 
begin

	instr=new;
	regi=new;
	generar_instrucciones=new;
	clk=1'b0;
	reset=1'b0;
	
	repeat(5) @(negedge clk);
	
	RST();
	desactivo();
	repeat(100) prueba_random_Rformat();
	
	$display("Fin de simulación!!");
	$stop;
end
	
	
task desactivo;
fork
generar_instrucciones.R_format.constraint_mode(0);
generar_instrucciones.R_format_a.constraint_mode(0);
generar_instrucciones.R_format_b.constraint_mode(0);
join
endtask 

task RST;
begin

//Reset de 4 ciclos asíncrono
        reset=1'b0;
        repeat(4) @(negedge clk);
//Desactivamos el reset
        reset=1'b1;


end
endtask 

task prueba_random_Rformat;
	begin 
	reset=1'b0; 
	generar_instrucciones.R_format.constraint_mode(1);
	generar_instrucciones.R_format_a.constraint_mode(1);
	generar_instrucciones.R_format_b.constraint_mode(1);
	$display("tarea random Rformat");
	assert (generar_instrucciones.randomize()) else    $fatal("randomization failed");
	w2<=generar_instrucciones.IN;
	#20;
	
	
	end
endtask



endmodule
