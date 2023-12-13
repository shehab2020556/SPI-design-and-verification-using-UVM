class mosi_active_agent extends uvm_agent;
  `uvm_component_utils(mosi_active_agent)


  uvm_analysis_port #(spi_seq_item) a0_ap_port;
  uvm_sequencer#(spi_seq_item) s0;
  spi_byte_driver d0;
  spi_byte_mon   m0;


  function new(string name="mosi_active_agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("mosi_active_agent build phase"), UVM_LOW)
    s0 = uvm_sequencer#(spi_seq_item)::type_id::create("s0", this);
    d0 = spi_byte_driver::type_id::create("d0", this);
    m0 = spi_byte_mon::type_id::create("m0", this);
    a0_ap_port=new("a0_ap_port",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d0.seq_item_port.connect(s0.seq_item_export);
    m0.byte_mon_ap.connect(a0_ap_port);
  endfunction

endclass 