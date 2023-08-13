class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

//fatory registartion

`uvm_component_utils(router_virtual_sequencer)
 
     
//dynamic handles for write and read sequencer

router_wr_sequencer wr_seqrh[];
router_rd_sequencer rd_seqrh[];
 
//handle for router_env_config

router_env_config m_cfg;
 

//standard methods
  
extern function new(string name="router_virtual_sequencer",uvm_component parent);
extern function void build_phase(uvm_phase phase);
 endclass
 	
  //constructor

function router_virtual_sequencer::new(string name="router_virtual_sequencer",uvm_component parent);
   super.new(name,parent);
  endfunction

 //buildphase

function void router_virtual_sequencer::build_phase(uvm_phase phase);
 super.build_phase(phase);
 
//get the config object using config_db


 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
    `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db have u set it?")
  
  wr_seqrh=new[m_cfg.no_of_write_agent];
  rd_seqrh=new[m_cfg.no_of_read_agent];


endfunction

