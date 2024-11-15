module tb_RAM_16x8;

reg clk;                  // Clock signal
reg wr;                   // Write enable signal
reg [3:0] addr;           // 4-bit address input
reg [7:0] din;            // 8-bit data input
wire [7:0] dout;          // 8-bit data output

    // Instantiate the RAM module (Unit Under Test)
    RAM_16x8 uut (.clk(clk),.wr(wr),.addr(addr),.din(din),.dout(dout));
    always begin
        #5 clk = ~clk; // Clock period = 10 time units
    end

    initial begin
        // Initialize signals
        clk = 0;
        wr = 0;
        addr = 4'b0000;
        din = 8'b00000000;

        //1: Write data to RAM
        #10;
        wr = 1;                // Enable write
        addr = 4'b0010;         // Address 2
        din = 8'b10101100;      // Data to write
        #10;                   // Wait for one clock cycle
        wr = 0;                // Disable write

        //2: Read data from RAM
        #10;
        addr = 4'b0010;         // Read from Address 2
        #10;                   // Wait for one clock cycle
        $display("Read Data at Address %b: %b", addr, dout);

        //3: Write another value to a different address
        #10;
        wr = 1;                // Enable write
        addr = 4'b0011;         // Address 3
        din = 8'b11001100;      // Data to write
        #10;                   // Wait for one clock cycle
        wr = 0;                // Disable write

        //4: Read data from Address 3
        #10;
        addr = 4'b0011;         // Read from Address 3
        #10;                   // Wait for one clock cycle
        $display("Read Data at Address %b: %b", addr, dout);

        //5: Check another address (Address 0)
        #10;
        addr = 4'b0000;         // Read from Address 0 (should be 0)
        #10;
        $display("Read Data at Address %b: %b", addr, dout);

        //6: Overwrite and Read data from Address 2
        #10;
        wr = 1;                // Enable write
        addr = 4'b0010;         // Address 2
        din = 8'b11110000;      // New data to overwrite
        #10;                   // Wait for one clock cycle
        wr = 0;                // Disable write
        #10;
        addr = 4'b0010;         // Read from Address 2
        #10;
        $display("Read Overwritten Data at Address %b: %b", addr, dout);
        $stop;
        $finish;
    end

endmodule