module KNN_PCPI(
input             clk, resetn,
	input             pcpi_valid,
	input      [31:0] pcpi_insn,
	input      [31:0] pcpi_rs1,
	input      [31:0] pcpi_rs2,
	output            pcpi_wr,
	output     [31:0] pcpi_rd,
	output            pcpi_wait,
	output            pcpi_ready,
	//memory interface
	input      [31:0] mem_rdata,
	input             mem_ready,
	output            mem_valid,
	output            mem_write,
	output     [31:0] mem_addr,
	output     [31:0] mem_wdata
);


	wire pcpi_insn_valid = pcpi_valid && pcpi_insn[6:0] == 7'b0101011 && pcpi_insn[31:25] == 7'b0000001;

	//TODO: PCPI interface. Modify these values to fit your needs
	assign pcpi_wr = 1;
	assign pcpi_wait = 0;
	assign pcpi_ready = pcpi_insn_valid;
	assign pcpi_rd = 0;

	//TODO: Memory interface. Modify these values to fit your needs
	assign mem_write = 0;
	assign mem_valid = 0;
	assign mem_addr = 0;
	assign mem_wdata = 0;
	
	//TODO: Implement your k-NN design below
	
endmodule
