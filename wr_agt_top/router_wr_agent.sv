class router_wr_agent extends uvm_agent;
 
 //factory regstartion 
 `uvm_component_utils(router_wr_agent)
 
 //create configuration  handles
 
 router_wr_agt_config m_cfg;
  
 //create handles
 
 router_wr_monitor monh;
 router_wr_driver drvh;
 router_wr_sequencer m_sequencer;

//standard methods
 
  extern function new(string name ="router_wr_agent",uvm_component parent=null);
  extern function void build_phase(uvm_phase phase);
   extern function void connect_phase(uvm_phase phase);
   extern task run_phase(uvm_phase phase);
  endclass 
 
 //constructor 

 function router_wr_agent::new(string name ="router_wr_agent",uvm_component parent = null);
   super.new(name,parent);
  endfunction

//build phase 

 function void router_wr_agent::build_phase(uvm_phase phase);
     super.build_phase(phase);
    //get config object using config_db

   if(!uvm_config_db #(router_wr_agt_config)::get(this,"","router_wr_agt_config",m_cfg))
      `uvm_fatal("CONFIG","cannot get() m_cfg from config_db have u set() it?")
    monh=router_wr_monitor::type_id::create("monh",this);
    if(m_cfg.is_active == UVM_ACTIVE)
           begin
                   
            drvh=router_wr_driver::type_id::create("drvh",this);
            m_sequencer=router_wr_sequencer::type_id::create("m_sequencer",this);
       end
   endfunction

 //connect phase//
  
   function void router_wr_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(m_cfg.is_active == UVM_ACTIVE)
      begin
        drvh.seq_item_port.connect(m_sequencer.seq_item_export);
      end
    endfunction

task router_wr_agent::run_phase(uvm_phase phase);
  uvm_top.print_topology;
    endtask


     
