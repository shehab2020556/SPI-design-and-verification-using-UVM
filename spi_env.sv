class spi_env extends uvm_env;
  `uvm_component_utils(spi_env)
  function new(string name="spi_env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  mosi_active_agent 		a0;
  mosi_passive_agent 		a1;
  scoreboard                scoreboard_0;

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("spi_env build phase"), UVM_LOW)
    a0 = mosi_active_agent::type_id::create("a0", this);
    a1 = mosi_passive_agent::type_id::create("a1", this);
    scoreboard_0=scoreboard::type_id::create("scoreboard_0",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a0.a0_ap_port.connect(scoreboard_0.s_analysis_imp_byte_mon);
    a1.a1_ap_port.connect(scoreboard_0.s_analysis_imp_mosi_mon);
  endfunction

endclass