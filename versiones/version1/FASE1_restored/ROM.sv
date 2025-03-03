module ROM(
    input logic [31:0] address,
    output logic [31:0] data_out
);

    
    parameter profundidad = 1024; 

    
    logic [31:0] rom [0:profundidad-1];

    
    initial 
	 begin
        $readmemb("ROM.txt", rom);
    end

    
    assign data_out = rom[address];

endmodule
