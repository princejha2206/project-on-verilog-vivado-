module advanced_ram #(
    parameter DATA_WIDTH = 8,          // width of each memory word
    parameter ADDR_WIDTH = 8,          // number of address bits
    parameter INIT_FILE  = ""          // optional memory init file
)(
    input clk,

    // Port A
    input we_a,
    input [ADDR_WIDTH-1:0] addr_a,
    input [DATA_WIDTH-1:0] din_a,
    output reg [DATA_WIDTH-1:0] dout_a,

    // Port B
    input we_b,
    input [ADDR_WIDTH-1:0] addr_b,
    input [DATA_WIDTH-1:0] din_b,
    output reg [DATA_WIDTH-1:0] dout_b
);

    // Memory declaration
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    // Optional initialization
    initial begin
        if (INIT_FILE != "") begin
            $readmemh(INIT_FILE, mem);   // load hex file into memory
        end
    end

    // Port A operations
    always @(posedge clk) begin
        if (we_a)
            mem[addr_a] <= din_a;
        dout_a <= mem[addr_a];
    end

    // Port B operations
    always @(posedge clk) begin
        if (we_b)
            mem[addr_b] <= din_b;
        dout_b <= mem[addr_b];
    end

endmodule