interface spi_if #(parameter bus_width = 8) (input logic i_Clk );

logic                    i_Rst_L,i_TX_DV,i_SPI_MISO;
logic  [bus_width-1:0]   i_TX_Byte;
logic  [bus_width-1:0]   o_RX_Byte;
logic                    o_SPI_MOSI,o_TX_Ready,o_SPI_Clk; 


task reset;
begin
        #10 i_Rst_L=0;  i_TX_DV=0; i_SPI_MISO=0; i_TX_Byte=8'b0; 
        #10 i_Rst_L=1;
        #10;
    
end
endtask


endinterface 