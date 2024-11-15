module RAM_16x8(clk,wr,addr,din,dout);
input clk;               // Clock signal
input wr;               // Write enable signal
input [3:0] addr;        // 4-bit address input (16 locations)
input [7:0] din;         // 8-bit data input
output reg [7:0] dout;    // 8-bit data output

reg [7:0] memory [15:0];

    // Always block for read/write operation (synchronous with clk)
   always @(posedge clk) 
  begin
	if (wr) 
	  begin
       memory[addr] <= din;
     end 
	 else 
	   begin
        dout <= memory[addr];
       end
  end

endmodule