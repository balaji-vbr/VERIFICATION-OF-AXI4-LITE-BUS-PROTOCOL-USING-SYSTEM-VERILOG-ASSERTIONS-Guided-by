`include "axi4_lite_master.sv"
`include "axi4_lite_slave.sv"
`include "axi4_lite_if.sv"
`include "axi4_lite_Defs.sv"

import axi4_lite_Defs::*;

module axi4_lite_top(
input logic clk,                                           // system clock
input logic rstn,                                        // system reset, active low
input logic rd_en, wr_en,                                   // read and write enable
input logic [Addr_Width-1:0] Read_Address, Write_Address,   // read and write address variables
input logic [Data_Width-1:0] Write_Data                    // write data variable
);

//////////////////////////
//   BFM INSTANTIATION
//////////////////////////
axi4_lite_if bfm (.ACLK(clk), .ARESETN(rstn));

//Instantiate the DUV master and slave:
//Instantiate the master module
axi4_lite_master MP(
    .rd_en(rd_en),
    .wr_en(wr_en),
    .Read_Address(Read_Address),
    .Write_Address(Write_Address),
    .Write_Data(Write_Data),
    .M(bfm.master_if)
);


// instantiate the slave module
axi4_lite_slave SP(
    .S(bfm.slave_if)
);

endmodule