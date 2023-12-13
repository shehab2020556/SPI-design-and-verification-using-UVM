class scoreboard extends  uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  `uvm_analysis_imp_decl(_byte_mon)
  `uvm_analysis_imp_decl(_mosi_mon)

  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  uvm_analysis_imp_byte_mon #(spi_seq_item, scoreboard) s_analysis_imp_byte_mon;
  uvm_analysis_imp_mosi_mon #(spi_seq_item, scoreboard) s_analysis_imp_mosi_mon;
  spi_seq_item spi_seq_item_h;
  typedef mailbox #(spi_seq_item) mbx_seq;
  mbx_seq mbx_seq_h;
  localparam i_Clk_p = 10ns ;

    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("scoreboard build phase"), UVM_LOW)
    s_analysis_imp_byte_mon = new("s_analysis_imp_byte_mon", this);
    s_analysis_imp_mosi_mon = new("s_analysis_imp_mosi_mon", this);
    mbx_seq_h = new(1);
  endfunction

  function void write_byte_mon(input spi_seq_item trans);
      if (mbx_seq_h.try_put(trans)) begin
        `uvm_info(get_type_name(), $sformatf("score board byte recieved from byte_mon=%b",trans.i_TX_Byte), UVM_LOW)
      end
      else begin
        `uvm_error(get_type_name(), $sformatf("score board couldn't put in mailbox"))
      end
  endfunction

   function void write_mosi_mon(input spi_seq_item trans);
      if(mbx_seq_h.try_get(spi_seq_item_h)) begin
      if (trans.i_TX_Byte==spi_seq_item_h.i_TX_Byte && (trans.t_1-spi_seq_item_h.t_1==i_Clk_p*(8*8+1))) begin
          `uvm_info(get_type_name(), $sformatf("PASS:correct byte recieved = %b",trans.i_TX_Byte), UVM_LOW)
      end
      else begin
          `uvm_error(get_type_name(), $sformatf("FAIL: byte from mosi_mon = %b  , from byte_mon=%b ,t_diff=%t",trans.i_TX_Byte,spi_seq_item_h.i_TX_Byte,(trans.t_1-spi_seq_item_h.t_1)))
      end
      end
      else begin
        `uvm_error(get_type_name(), $sformatf("score board couldn't get from mailbox"))    
      end
    
  endfunction
  
endclass 