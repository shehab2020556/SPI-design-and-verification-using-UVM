class spi_byte_mon extends uvm_monitor;

  uvm_analysis_port #(spi_seq_item) byte_mon_ap;
  `uvm_component_utils(spi_byte_mon)
  virtual spi_if vif;
  spi_seq_item spi_seq_item_h;
  function new(string name="spi_byte_mon", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("spi_byte_mon build phase"), UVM_LOW)
    if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", vif))
      `uvm_fatal("byte_mon", "Could not get vif")
    byte_mon_ap=new("byte_mon_ap",this);
    endfunction

    virtual task  run_phase(uvm_phase phase);
      super.run_phase(phase);
      spi_seq_item_h=spi_seq_item::type_id::create("spi_seq_item_h");
      while(1) begin
        @(posedge vif.i_TX_DV)
        spi_seq_item_h.i_TX_Byte<=vif.i_TX_Byte;
        // `uvm_info(get_type_name(), $sformatf("spi_byte_mon run_phase sent to scoreboard"), UVM_LOW)
        spi_seq_item_h.t_1<=$time;
        #1;
        byte_mon_ap.write(spi_seq_item_h);
      end
  
      endtask 

endclass 