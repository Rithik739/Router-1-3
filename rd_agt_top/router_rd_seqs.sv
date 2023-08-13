class router_rd_seq extends uvm_sequence #(read_xtn);
  

//factory registation
    
   `uvm_object_utils(router_rd_seq)
    
     //standard uvm methods
 
 extern function new(string name="router_rd_seq");
    endclass
  
  //constaructor 

function router_rd_seq::new(string name ="router_rd_seq");
     super.new(name);
    endfunction
   


//extended base class//
class router_rxtns1 extends router_rd_seq;
   //factory registration
   
  `uvm_object_utils(router_rxtns1)
     


//standard uvm methods
  
  extern function new(string name="router_rxtns1");
   extern task body();
   endclass

   //constructor

function router_rxtns1 ::new(string name="router_rxtns1");
     super.new(name);
    endfunction
   
   //task body//
   
task router_rxtns1 ::body;
  
req=read_xtn::type_id::create("req");
    start_item(req);
    assert(req.randomize() with{no_of_cycles inside {[1:28]};});
   `uvm_info("router_rd_SEQUENCE", $sformatf("printing the sequence \n %s", req.sprint()),UVM_LOW)
     finish_item(req);
        `uvm_info(get_type_name(),"AFTER FINISH ITEM INSIDE SEQUENCE ",UVM_LOW)
endtask