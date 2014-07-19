`timescale 1ns/1ps
module axi_slave(
  input aclk,
  input aresetn,
  input [3:0] awid,
  input [31:0] awaddr,
  input [3:0] awlen,
  input [2:0] awsize,
  input [1:0] awburst,
  input [1:0] awlock,
  input [3:0] awcache,
  input [2:0] awprot,
  input  awvalid,
  output logic awready,

  input [3:0] wid,
  input [31:0] wdata,
  input [3:0] wstrb,
  input  wlast,
  input  wvalid,
  output  logic  wready,

  output logic [3:0]  bid,
  output logic [1:0]  bresp,
  output logic  bvalid,
  input   bready,

  input [3:0]  arid,
  input [31:0]  araddr, //bit array of 32 bits
  input [3:0]  arlen,
  input [2:0]  arsize,
  input [1:0]  arburst,
  input [1:0]  arlock,
  input [3:0]  arcache,
  input [1:0]  arprot,
  input   arvalid,
  output  logic  arready,

  output logic [3:0] rid,
  output logic [31:0]  rdata,
  output  logic  rlast,
  output  logic rvalid,
  input   rready,
  output logic [1:0]  rresp
);

integer count = 0;
integer wid_temp;
byte dataA[integer];  //associative array of index integer
integer arid_l;
integer araddr_t[16];
bit [3:0] arlen_l[16];
integer awaddr_t[16];

  always @(posedge aclk) begin
	  if (awvalid == 1'b1) begin
	  awready = 1'b1;
	  awaddr_t[awid] = int'(awaddr);
	  @(posedge aclk);
	  awready = 1'b0;
          end
  end
  always @(posedge aclk) begin
     if (wvalid == 1'b1) begin
	  dataA[awaddr_t[wid]+0] = wdata[7:0];	 
	  dataA[awaddr_t[wid]+1] = wdata[15:8];	 
	  dataA[awaddr_t[wid]+2] = wdata[23:16];	 
	  dataA[awaddr_t[wid]+3] = wdata[31:24];	 
	  wready = 1'b1;
	  wid_temp = wid;
	  awaddr_t[wid] = awaddr_t[wid]+4;
     end 
  end
  always @(posedge wlast) begin
	  #25;
	  bvalid = 1'b1;
	  bid = wid_temp;
	  bresp = 2'b0;  //OKAY response
	  #10;
	  wready <= 1'b0;
	  bvalid = 1'b0;
  end

  always @(posedge aclk) begin
	  if (arvalid == 1'b1) begin
	  arready <= 1'b1;
	  arid_l = arid;
	  arlen_l[arid] = arlen;
	  araddr_t[arid] = integer'(araddr);
	  @(posedge aclk);
	  arready <= 1'b0;
          end
  end
  always @(posedge arready) begin
	  if (arlen_l[arid] != 0) arlen_l[arid]++;
	  for (int i = 0; i <= arlen_l[arid]; i++) begin
		  rvalid <= 1'b1;
		  rid <= arid_l;
		  rdata = $random();
		  if (dataA.exists(araddr_t[arid])) rdata[7:0] <= dataA[araddr_t[arid]];
		  if (dataA.exists(araddr_t[arid]+1)) rdata[15:8] <= dataA[araddr_t[arid]+1];
		  if (dataA.exists(araddr_t[arid]+2)) rdata[23:16] <= dataA[araddr_t[arid]+2];
		  if (dataA.exists(araddr_t[arid]+3)) rdata[31:24] <= dataA[araddr_t[arid]+3];
		  araddr_t[arid] = araddr_t[arid] + 4;
		  rresp <= 2'b00; //OKAY response, EXOKAY, SLVERR, DECERR
		  if (i == arlen_l[arid]) rlast <= 1'b1;
		  #1;
		  @(posedge aclk);
		  wait(rready == 1'b1);
		  rvalid <= 1'b0;
		  rlast <= 1'b0;
	  end
  end
endmodule
