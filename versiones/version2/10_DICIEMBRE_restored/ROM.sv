module ROM(
    input logic [31:0] address,
    output logic [31:0] data_out
);

    
    parameter profundidad = 1024; 

    
    logic [31:0] rom [0:profundidad-1];

    
    initial 
	 begin
        $readmemh("C:/Users/adamc/OneDrive/Escritorio/UNI/5toCUATRI/ISDIGI/PROYECTO3/versiones/version2/10_DICIEMBRE_restored/rom.txt", rom);
    end

    
    assign data_out = rom[address];

endmodule
