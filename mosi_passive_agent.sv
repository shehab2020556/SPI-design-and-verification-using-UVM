class mosi_passive_agent extends uvm_agent;
  `uvm_component_utils(mosi_passive_agent)


  uvm_analysis_port#(spi_seq_item)  a1_ap_port;
  spi_mosi_mon   m0;


  function new(string name="mosi_passive_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("mosi_passive_agent build phase"), UVM_LOW)
    m0 = spi_mosi_mon::type_id::create("m0", this);
    a1_ap_port=new("a1_ap_port",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m0.mosi_mon_ap.connect(a1_ap_port);

  endfunction

endclass 