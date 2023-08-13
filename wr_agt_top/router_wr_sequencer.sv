class router_wr_sequencer extends uvm_sequencer #(write_xtn);
  

//factory regirsttion

 `uvm_component_utils(router_wr_sequencer)

//standard uvm methods

extern function new(string name="router_wr_sequencer",uvm_component parent);
  endclass

//	constructor new method

function router_wr_sequencer ::new(string name="router_wr_sequencer",uvm_component parent);
  super.new(name, parent);
  endfunction



