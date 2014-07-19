module axi_slave (
	input bit aclk,
	input bit aresetn,
	input bit [31:0] awaddr,
	input bit [3:0] awid,
	input bit [1:0] awburst,
	input bit [3:0] awlen,
	input bit [2:0] awsize,
	input bit [1:0] awlock,
	input bit [1:0] awprot,
	input bit [1:0] awcache,
	output reg [1:0] awready,

	input bit [31:0] wdata,
	input bit [3:0] wstrb,
	....


	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
	input bit aclk,
);

reg [31:0] awwaddr_t;
reg [3:0] awlen_t;
reg [31:0] awburst_t;
reg [31:0] awwaddr_t;
reg [31:0] awwaddr_t;

byte mem[int]; //byte represetnt data, int : index of memory(address where we write or read)_

always @(posedge aclk) begin
	if (awvalid == 1'b0) begin
		awready <= 1'b0;
	end
end

//read address phase
always @(posedge aclk) begin
	if (arvalid == 1'b1) begin
		arready <= 1'b1;
		araddr_t <= araddr;
		arlen_t <= arlen;
		arburst_t <= arburst;
		arsize_t <= arsize;
		arcache_t <= arcache;
		->read_data_phase_trigger_e;
	end
end

always @(read_data_phase_trigger_e) begin
	delay = $urandom_range(0, 10); //0, 10, 4
	repeat (delay) @(posedge aclk);
	for (int i = 0; i <= arlen_t; i++) begin
		rdata[7:0] = mem[araddr_t];
		rdata[15:8] = mem[araddr_t+1];
		rdata[23:16] = mem[araddr_t+2];
		rdata[31:24] = mem[araddr_t+3];
		araddr_t = araddr_t + 4;
		rresp = OKAY;
		rid = arid_t;
		rvalid = 1'b1;
		@(posedge aclk);
		wait(rready == 1'b1);
	end
end

always @(rready) begin
	if (rready == 1'b0) rvalid = 1'b0;
end

//Write address phase
always @(posedge aclk) begin
	if (awvalid == 1'b1) begin
		awready <= 1'b1;
		awaddr_t <= awaddr;
		awlen_t <= awlen;
		awburst_t <= awburst;
		awsize_t <= awsize;
		awcache_t <= awcache;
	end
end

//write data phase
always @(posedge aclk) begin
	if (wvalid == 1'b1) begin
		//Storing data to memory : 1. check if fixed or incr or wrap?
		if (awburst_t == FIXED) begin
			mem[awaddr_t] = wdata[7:0];
			//Shifting of data in FIFO would happen here
			mem[awaddr_t] = wdata[15:8];
			mem[awaddr_t] = wdata[23:16];
			mem[awaddr_t] = wdata[31:24];
		end
		if (awburst_t == INCR) begin
			if (wstrb[0] == 1'b1) begin
				mem[awaddr_t] = wdata[7:0];
				awaddr_t++;
			end
			if (wstrb[1] == 1'b1) begin
				mem[awaddr_t] = wdata[15:8];
				awaddr_t++;
			end
			if (wstrb[2] == 1'b1) begin
				mem[awaddr_t] = wdata[23:16];
				awaddr_t++;
			end
			if (wstrb[3] == 1'b1) begin
				mem[awaddr_t] = wdata[31:24];
				awaddr_t++;
			end
			awlen_t--; //9, 8, 7, 6, 5, 4, 3, 2, 1,  0
			if (awlen_t == -1) begin
				if (wlast != 1) begin
					$display("ERROR Message");
				end
				else begin
					//done with all data transfers, now start write repsonse phase
					->write_resp_phase_trigger_e;
				end
			end
		end

	end

	always @(write_resp_phase_trigger_e) begin
		delay = $urandom_range(0, 10); //0, 10, 4
		repeat (delay) @(posedge aclk);
		bresp = OKAY;
		bid = awid_t;
		bvalid = 1'b1;
		wait (bready == 1'b1);
		bvalid = 1'b0;
		//Now whole write transaction is compelte
	end
end
