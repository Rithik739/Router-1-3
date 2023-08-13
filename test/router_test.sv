//define class
     
   class router_test extends uvm_test;

   //factory registartion
   
       `uvm_component_utils(router_test)
     
   //handels
     
       router_env env;
       router_env_config e_cfg;
       router_wr_agt_config wcfg[];
       router_rd_agt_config rcfg[];


 bit has_ragent = 1;
 bit has_wagent = 1;
 int no_of_read_agent = 3;
 int no_of_write_agent = 1;
 

//standard uvm methods
  
 extern function new(string name ="router_test",uvm_component parent);
 extern function void config_router();
 extern function void build_phase(uvm_phase phase);	
 extern function void end_of_elaboration_phase(uvm_phase phase);
endclass
 

 ///constructor
 
 function router_test::new(string name ="router_test", uvm_component parent);
 super.new(name,parent);
 endfunction


//function config router()
function void router_test::config_router();
   if(has_wagent)
     begin
       wcfg = new[no_of_write_agent];
               foreach(wcfg[i])
                begin
           wcfg[i]= router_wr_agt_config::type_id::create($sformatf("wcfg[%d]",i));
   //get the virtual inerface fron config_db
   
  if(!uvm_config_db #(virtual router_if)::get(this,"","vif",wcfg[i].vif))
 `uvm_fatal("VIF CONFIG - WRITE","cannot get() interface vif from uvm_config_db have u set() it?")
    wcfg[i].is_active=UVM_ACTIVE;
    e_cfg.wr_agt_cfg[i]=wcfg[i];
  end
 end


//raed_config object
 
   
   if(has_ragent)
     begin
       rcfg = new[no_of_read_agent];
               foreach(rcfg[i])
                begin
           rcfg[i]= router_rd_agt_config::type_id::create($sformatf("rcfg[%d]",i));
   //get the virtual inerface fron config_db

  if(!uvm_config_db #(virtual router_if)::get(this,"",$sformatf("vif[%0d]",i),rcfg[i].vif))
 `uvm_fatal("VIF CONFIG - READ","cannot get() interface vif from uvm_config_db have u set() it?")
    rcfg[i].is_active=UVM_ACTIVE;
    e_cfg.rd_agt_cfg[i]=rcfg[i];
  end
 end

  e_cfg.has_ragent=has_ragent;
  e_cfg.has_wagent=has_wagent;
 e_cfg.no_of_read_agent=no_of_read_agent;
 e_cfg.no_of_write_agent=no_of_write_agent;

endfunction

//build phase
 
 function void router_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
    e_cfg=router_env_config::type_id::create("e_cfg");

  if(has_wagent)
     begin
       e_cfg.wr_agt_cfg=new[no_of_write_agent];
     end
   
    if(has_ragent)
      begin
       e_cfg.rd_agt_cfg=new[no_of_read_agent];
     end


    config_router();
      uvm_config_db #(router_env_config)::set(this,"*","router_env_config",e_cfg);
     env=router_env::type_id::create("env",this);
     endfunction


function void router_test::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
endfunction
 	  
  
/////////small packet //////

class router_small_pkt_test extends router_test;

  //factory registration
  `uvm_component_utils(router_small_pkt_test)
 
  router_small_pkt_vseq router_seqh;
  bit[1:0]addr;
   
 //standard uvm methods//
 
 extern function new(string name="router_small_pkt_test",uvm_component parent);
 extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
 endclass

//constructor method

function router_small_pkt_test::new(string name="router_small_pkt_test",uvm_component parent);
  super.new(name,parent);
  endfunction

//build_phase //
  
  function void router_small_pkt_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction

//run_phase //
task router_small_pkt_test::run_phase(uvm_phase phase);
  
   phase.raise_objection(this);
  repeat(20)
    begin
        addr={$random}%3;
         uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
         router_seqh=router_small_pkt_vseq::type_id::create("router_seqh");
         router_seqh.start(env.v_sequencer);
        end
       phase.drop_objection(this);
  endtask
 

/////////medium packet //////

class router_medium_pkt_test extends router_test;

  //factory registration
  `uvm_component_utils(router_medium_pkt_test)
 
  router_medium_pkt_vseq router_seqh;
  bit[1:0]addr;
   
 //standard uvm methods//
 
 extern function new(string name="router_medium_pkt_test",uvm_component parent);
 extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
 endclass

//constructor method

function router_medium_pkt_test::new(string name="router_medium_pkt_test",uvm_component parent);
  super.new(name,parent);
  endfunction

//build_phase //
  
  function void router_medium_pkt_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  endfunction

//run_phase //
task router_medium_pkt_test::run_phase(uvm_phase phase);
  
   phase.raise_objection(this);
  repeat(20)
    begin
        addr={$random}%3;
         uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
         router_seqh=router_medium_pkt_vseq::type_id::create("router_seqh");
         router_seqh.start(env.v_sequencer);
        end
       phase.drop_objection(this);
  endtask
 

