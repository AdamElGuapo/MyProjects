`timescale 1ns/100ps
module tb_ALU();

localparam T=20;

//DUV instance



reg [31:0]A,B,result;
reg [4:0]ALU_control;



ALU duv(.,);



task INICIO();
begin
A=32'b0;
B=32'b0;
ALU_control=default;

end
endtask



        //Test procedure
initial
begin

INICIO();

#T(10)

add();


$display("Fin de simulación!!");
$stop;
end

task add();
begin
A<=32'd0;
B<=32'd1;
ALU_control<=4'b0000;
end 
endtask




endmodule 