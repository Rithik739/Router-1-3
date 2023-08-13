/************************************************************************
  
Copyright 2019 - Maven Silicon Softech Pvt Ltd.  
  
www.maven-silicon.com 
  
All Rights Reserved. 
This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd. 
It is not to be shared with or used by any third parties who have not enrolled for our paid 
training courses or received any written authorization from Maven Silicon.
  
Filename				:   router_if.sv

Description			:		Interface file for Router 1x3
  
Author Name			:   Shanthi V A

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version					:		1.0

************************************************************************/
interface router_if(input bit clock);
  
   logic [7:0] data_in;       
   logic [7:0] data_out;
   logic rst;
   logic  error;                             
   logic  busy;
   logic read_enb;
   logic v_out;
   bit pkt_valid;
    

   //TB Modports and CBs
   //Write Driver 
   clocking wdr_cb @ (posedge clock);
      default input #1 output #1;
      output data_in;
      output pkt_valid;
      output rst;
      input error;
      input busy;
   endclocking

   //Read Driver 
   clocking rdr_cb @ (posedge clock);
      default input #1 output #1;
      output read_enb;//Read Driver MP
      input v_out;    
   endclocking

   //Write Monitor 
   clocking wmon_cb @(posedge clock);
      default input #1 output #1;
      input data_in;
      input pkt_valid;
      input error;
      input busy;
      input rst;    
   endclocking

   //Read Monitor 
   clocking rmon_cb @(posedge clock);
      default input #1 output #1;
      input data_out;
      input read_enb;
   endclocking

   //Write Driver MP
   modport WDR_MP (clocking wdr_cb);

   //Read Driver MP
   modport RDR_MP (clocking rdr_cb);

   //Write Monitor MP
   modport WMON_MP (clocking wmon_cb);

   //Read  Monitor MP
   modport RMON_MP (clocking rmon_cb);
   
   

endinterface
