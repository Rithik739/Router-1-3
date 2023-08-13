class router_wr_seqs extends uvm_sequence #(write_xtn);
 
//factory registartion

`uvm_object_utils(router_wr_seqs)

//standard uvm_methods

extern function new(string name ="router_wr_seqs");
endclass

//constructor 

function router_wr_seqs::new(string name ="router_wr_seqs");
  super.new(name);
  endfunction



///small packet///

 class router_wxtns_small_pkt extends router_wr_seqs;
  
 //factory regirstation

`uvm_object_utils(router_wxtns_small_pkt)
 bit[1:0]addr;
 
//standard uvm methods

extern function new(string name="router_wxtns_small_pkt");
   extern task body();
 endclass

//constructor

function router_wxtns_small_pkt::new(string name ="router_wxtns_small_pkt");
    super.new(name);
   endfunction


//task body//
  
   task router_wxtns_small_pkt ::body();
    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")

    req=write_xtn::type_id::create("req");
   start_item(req);
  assert(req.randomize() with {header[7:2] inside {[1:15]} && header[1:0]==addr;});
`uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
   finish_item(req);
 endtask




  
/// medium  packet///

 class router_wxtns_medium_pkt extends router_wr_seqs;
  
 //factory regirstation

`uvm_object_utils(router_wxtns_medium_pkt)
 bit[1:0]addr;
 
//standard uvm methods

extern function new(string name="router_wxtns_medium_pkt");
   extern task body();
 endclass

//constructor

function router_wxtns_medium_pkt ::new(string name ="router_wxtns_medium_pkt");
    super.new(name);
   endfunction


//task body//
  
   task router_wxtns_medium_pkt ::body();
    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal (get_type_name(),"getting the configuration failed have u set() properly")

    req=write_xtn::type_id::create("req");
   start_item(req);
  assert(req.randomize() with {header[7:2] inside {[16:30]} && header[1:0]==addr;});
`uvm_info("router_WR_SEQUENCE",$sformatf("printing from sequence \n %s",req.sprint()),UVM_HIGH)
   finish_item(req);
 endtask
  
