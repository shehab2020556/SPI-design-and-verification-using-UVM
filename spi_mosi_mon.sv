class spi_mosi_mon extends uvm_monitor;

  `uvm_component_utils(spi_mosi_mon)
  virtual spi_if vif;
  spi_seq_item spi_seq_item_h;
  int n;
  time t_1,t_2;
  localparam i_Clk_p = 10ns ;


  uvm_analysis_port #(spi_seq_item) mosi_mon_ap;

  function new(string name="spi_mosi_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("spi_mosi_mon build phase"), UVM_LOW)
    if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", vif))
      `uvm_fatal("mosi mon", "Could not get vif")
    mosi_mon_ap=new("mosi_mon_ap",this);
  endfunction

  
    virtual task  run_phase(uvm_phase phase);
      super.run_phase(phase);
      spi_seq_item_h=spi_seq_item::type_id::create("spi_seq_item_h");
      // @(negedge vif.o_SPI_Clk)
      while(1) begin
         n=7;
         spi_seq_item_h.i_TX_Byte<='b0;
         repeat(8) begin         
         @(negedge vif.o_SPI_Clk)
         t_1<=$time;
         spi_seq_item_h.i_TX_Byte[n]<=vif.o_SPI_MOSI;
         n=n-1;
          @(posedge vif.o_SPI_Clk)
          t_2=$time;
          assert ((i_Clk_p*4)==(t_2-t_1))  
          else `uvm_error(get_type_name(), $sformatf("FAILED: error in o_SPI_Clk t_diff=%t ",(t_2-t_1)))
         end
         spi_seq_item_h.t_1<=$time;
         #1;
         mosi_mon_ap.write(spi_seq_item_h);
        end
      // `uvm_info(get_type_name(), $sformatf("mosi_mon_ap run_phase sent to scoreboard"), UVM_LOW)

      endtask 


endclass 
