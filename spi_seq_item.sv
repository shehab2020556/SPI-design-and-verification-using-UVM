class spi_seq_item extends uvm_sequence_item;

    `uvm_object_utils(spi_seq_item)
    rand bit [7:0] i_TX_Byte_q [$];
    bit [7:0] i_TX_Byte;
    time t_1;
    constraint burst_size{i_TX_Byte_q.size()>=10; i_TX_Byte_q.size()<=30;}

    function new(string name = "spi_seq_item");
        super.new(name);
    endfunction
endclass 