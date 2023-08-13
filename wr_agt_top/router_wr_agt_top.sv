class  router_wr_agt_top extends uvm_env;
   
 //factory registartion   
   
    `uvm_component_utils(router_wr_agt_top)
  
// create agt handles
 
 router_wr_agent agnth[];

//create env config
    router_env_config m_cfg;
 
//standard uvm methods

 extern function new(string name= "router_wr_agt_top",uvm_component parent);
 extern function void build_phase(uvm_phase phase); 
  endclass
  
 //constructor 

  function router_wr_agt_top::new(string name ="router_wr_agt_top",uvm_component parent);
     super.new(name, parent);
  endfunction

//build phase method

 function void  router_wr_agt_top::build_phase(uvm_phase phase);
    super.build_phase(phase);
 if(!uvm_config_db #(router_env_config)::get(this,"","router_env_config",m_cfg))
    `uvm_fatal(get_type_name(),"ENV:write_error") 
    agnth=new[m_cfg.no_of_write_agent];
   foreach(agnth[i])
        begin
          agnth[i]=router_wr_agent::type_id::create($sformatf("agnth[%0d]*",i),this);
      uvm_config_db #(router_wr_agt_config)::set(this,$sformatf("agnth[%0d]*",i),"router_wr_agt_config" ,m_cfg.wr_agt_cfg[i]);
      end
  endfunction 
