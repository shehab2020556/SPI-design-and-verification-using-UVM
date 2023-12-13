import uvm_pkg::*;
`include "uvm_macros.svh"
`include "rtl/SPI_master.v"
`include "spi_if.sv"
`include "spi_seq_item.sv"
`include "spi_seq.sv"
`include "spi_byte_driver.sv"
`include "spi_byte_mon.sv"
`include "spi_mosi_mon.sv"
`include "mosi_active_agent.sv"
`include "mosi_passive_agent.sv"
`include "scoreboard.sv"
`include "spi_env.sv"
`include "test.sv"
module spi_tb;
// import uvm_pkg::*;
logic i_Clk;
always #5 i_Clk=~i_Clk;

initial begin
    i_Clk=0;
end

spi_if inf(i_Clk);

SPI_master DUT(
    .i_Clk(inf.i_Clk),
    .i_Rst_L(inf.i_Rst_L),
    .i_TX_DV(inf.i_TX_DV),
    .i_SPI_MISO(inf.i_SPI_MISO),
    .i_TX_Byte(inf.i_TX_Byte),
    .o_RX_Byte(inf.o_RX_Byte),
    .o_SPI_MOSI(inf.o_SPI_MOSI),
    .o_TX_Ready(inf.o_TX_Ready),
    .o_SPI_Clk(inf.o_SPI_Clk) 
);
initial begin
    uvm_config_db#(virtual spi_if)::set(null, "uvm_test_top", "spi_if", inf);
    run_test("test");
    
end



    
endmodule