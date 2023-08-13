
class router_rd_sequencer extends uvm_sequencer #(read_xtn);
  

//factory regirsttion

 `uvm_component_utils(router_rd_sequencer)

//standard uvm methods

extern function new(string name="router_rd_sequencer",uvm_component parent);
  endclass

//	constructor new method

function router_rd_sequencer ::new(string name="router_rd_sequencer",uvm_component parent);
  super.new(name, parent);
  endfunction


