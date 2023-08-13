class router_rd_agt_config extends uvm_object;

 //uvm factory registration
 
 `uvm_object_utils(router_rd_agt_config)

//declare virtual interface
 
 virtual router_if vif;
 
 // uvm active 
  
 uvm_active_passive_enum is_active = UVM_ACTIVE;
  
 static int drv_data_count  =0;
 static int mon_data_count  = 0;

 //standard uvm_methos
 
 extern function new(string name = "router_rd_agt_config");
 endclass
 
 //constructor
 
 function router_rd_agt_config::new(string name = "router_rd_agt_config");
 super.new(name);
  endfunction
