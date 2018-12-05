module KNN_MMAP (
    input clk,
    input en,
    input rst_n,
    input [31:0] addr,
    input valid,
    input [3:0] wstrb,
    output reg ready,
    input [31:0] wdata,
    output reg [31:0] rdata
    
    // memory interface
    input mem_ready,
    output mem_valid,
    output [31:0] mem_addr,
    input [31:0] mem_rdata,
    output mem_write,
    output [31:0] mem_wdata
);
`undef BLOCKING_OUTPUT
// KNN_MMAP's address mapping
parameter KNN_MMAP_BASE = 32'h4000_0000;
parameter KNN_MMAP_RANG = 32'h0000_ffff;
//TODO
// Assign your own memory mapping here
// Keep your memory address alligned to 4bytes, so you won't run into any trouble
// Each memory address represents 1byte, so each MMAP mapping jump at least 4bytes = 32bits
// e.g. 0x0, 0x4, 0x8, 0xc

// Internal masked  address
wire [31:0] knn_addr;

assign knn_addr = (addr) & KNN_MMAP_RANG;
assign mem_valid = 0;
assign mem_addr = 0;
assign mem_write = 0;
assign mem_wdata = 0;

/**
 *	This block handles the MMAP request.
 *
 *	Signal description:
 *	[31:0] addr:	MMAP request address
 *	[31:0] wdata:	Data write from master
 *	[31:0] rdata:	Data read from module
 *	[3:0] wstrb:	each bit enables 8-bit write to the 32-bit data
 *	valid:		MMAP request from master
 *	ready:		MMAP request is handled
 */
always @(posedge clk or negedge rst_n)
begin
    if (!rst_n) begin
    end else begin
        ready <= 0;
        rdata <= 0;
        if (en && valid && !ready) begin
            if (!wstrb) begin   //read
                case (knn_addr)
		//TODO Implement your MMAP read routine here
                    default: $display("KNN_MMAP: read invalid reg: %h(%h)", knn_addr, addr);
                endcase
            end else begin      //write
                case (knn_addr)
		//TODO Implement your MMAP write routine here
                    default: $display("KNN_MMAP: write invalid reg: %h(%h)", knn_addr, addr);
                endcase
            end
        end
    end
end

//TODO Implement your KNN design here

endmodule
