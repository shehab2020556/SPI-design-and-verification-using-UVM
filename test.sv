class test extends uvm_test;
  `uvm_component_utils(test)
  function new(string name = "test", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  spi_env e0;
  virtual spi_if vif;
  spi_seq spi_seq_h;

  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("test build phase"), UVM_LOW)
    e0 = spi_env::type_id::create("e0", this);
    if (!uvm_config_db#(virtual spi_if)::get(this, "", "spi_if", vif))
      `uvm_fatal("TEST", "Did not get vif")
      uvm_config_db#(virtual spi_if)::set(this, "e0.a0.*", "spi_if", vif);
      uvm_config_db#(virtual spi_if)::set(this, "e0.a1.*", "spi_if", vif);

  endfunction
  
  virtual task  run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(), $sformatf("test run phase"), UVM_LOW)
  spi_seq_h=spi_seq::type_id::create("spi_seq_h");
  phase.raise_objection(this);
  
  vif.reset();
  fork
    spi_seq_h.start(e0.a0.s0);      
  join
  phase.drop_objection(this);

  endtask 
endclass