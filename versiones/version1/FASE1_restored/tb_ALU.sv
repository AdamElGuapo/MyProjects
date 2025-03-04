`timescale 1ns/100ps
module tb_ALU();

localparam T=20;

//DUV instance



reg [31:0]A,B,result;
reg [4:0]ALU_control;
reg zero_flag;


ALU duv(.*);



task INICIO();
begin
A=32'b0;
B=32'b0;
ALU_control=32'd0;

end
endtask



        //Test procedure
initial
begin

INICIO();

#(T*10);

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

task bge();
begin
A<=32'hFFF6;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'hFFF6;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
end 
endtask

task bgeu();
begin
A<=32'd10;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd10;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
end 
endtask

task blt();
begin
A<=32'hFFF6;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'hFFF6;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
end 
endtask

task bltu();
begin
A<=32'd10;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd10;
ALU_control<=4'b1111;
#(T*20);
A<=32'd5;
B<=32'd5;
ALU_control<=4'b1111;
#(T*20);
end 
endtask
endmodule 