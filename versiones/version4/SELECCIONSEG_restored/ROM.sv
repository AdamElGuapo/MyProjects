module ROM	#(parameter profundidad = 1024)
(
    input logic [$clog2(profundidad-1)-1:0] address,
    output logic [31:0] data_out
);
    
    logic [31:0] rom [0:profundidad-1];

    
    initial 
	 begin
        $readmemh("C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version4/SELECCIONSEG_restored/seleccionconnops.txt", rom);
    end

    
    assign data_out = rom[address];

endmodule
