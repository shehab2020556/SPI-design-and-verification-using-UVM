class spi_seq extends uvm_sequence#(spi_seq_item);

`uvm_object_utils(spi_seq)
spi_seq_item spi_seq_item_h;

    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction

    virtual task  body();
    `uvm_info(get_type_name(),$sformatf("task body spi_seq"),UVM_LOW)
    spi_seq_item_h=spi_seq_item::type_id::create("spi_seq_item_h");

    start_item(spi_seq_item_h);
    assert(spi_seq_item_h.randomize());
    finish_item(spi_seq_item_h);
        
    endtask


endclass 


