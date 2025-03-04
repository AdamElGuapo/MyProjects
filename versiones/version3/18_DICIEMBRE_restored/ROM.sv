module ROM	#(parameter profundidad = 1024)
(
    input logic [$clog2(profundidad-1)-1:0] address,
    output logic [31:0] data_out
);
    
    logic [31:0] rom [0:profundidad-1];

    
    initial 
	 begin
        $readmemh("C:/Users/jaume/OneDrive/Documentos/3_TELECO/ISDIGIT/microprocesador/proyecto3_restored/ROM.txt", rom);
    end

    
    assign data_out = rom[address];

endmodule
