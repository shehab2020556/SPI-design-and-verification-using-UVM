class spi_byte_driver extends uvm_driver #(spi_seq_item); 

     `uvm_component_utils(spi_byte_driver)
    virtual spi_if vif;
    spi_seq_item spi_seq_item_h;

    function new(string name = "spi_byte_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

  
  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("spi_byte_driver build phase"), UVM_LOW)
    if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", vif))
      `uvm_fatal("DRV", "Could not get vif")
  endfunction

  virtual task  run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      seq_item_port.get_next_item(spi_seq_item_h);
     `uvm_info(get_type_name(), $sformatf("spi_byte_driver run_phase got seq item "), UVM_LOW)
      drive(spi_seq_item_h);    
       #2;
    seq_item_port.item_done();
    end
  
  endtask 

  
task drive(input spi_seq_item spi_seq_item_h);
begin
    for (int i = 0 ;i<spi_seq_item_h.i_TX_Byte_q.size() ;i++ )
    begin
    @(posedge vif.i_Clk)
    vif.i_TX_DV<=1;
    vif.i_TX_Byte<=spi_seq_item_h.i_TX_Byte_q[i];
    @(posedge vif.i_Clk)
    vif.i_TX_DV<=0;
    vif.i_TX_Byte<=8'b0000_0000;
    @(posedge vif.o_TX_Ready);
    end
end
endtask

endclass 



