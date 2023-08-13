/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   router_top.v   

Description :      This is the top of the router design 

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/
module router_top(input          clock,
		  input          resetn,
		  input          packet_valid,
		  input    [7:0] data,
		  input          read_enb_0,
		  input          read_enb_1,
		  input          read_enb_2,

		  output   [7:0] data_out_0,
		  output   [7:0] data_out_1,
		  output	 [7:0] data_out_2,
	 	  output         vld_out_0,
		  output	 vld_out_1,
		  output	 vld_out_2,
		  output         busy,
		  output         err );            
										
										
   //Internal wires
   wire   [2:0] write_enb;
   wire   [7:0] dout;

   //Instances
		
   fifo FIFO_0(.clock         (clock),
	       .write_enb     (write_enb[0]),
	       .read_enb      (read_enb_0),
	       .data_in       (dout),
	       .data_out      (data_out_0),
	       .empty         (empty_0),
	       .full          (full_0),
	       .resetn        (resetn),
	       .soft_reset    (soft_reset_0),
	       .lfd_state     (lfd_state)
	      );

   fifo FIFO_1(.clock         (clock),
	       .write_enb     (write_enb[1]),
	       .read_enb      (read_enb_1),
	       .data_in       (dout),
	       .data_out      (data_out_1),
	       .empty         (empty_1),
	       .full          (full_1),
	       .resetn         (resetn),
	       .soft_reset    (soft_reset_1),
	       .lfd_state     (lfd_state)
	      );

   fifo FIFO_2(.clock         (clock),
	       .write_enb     (write_enb[2]),
	       .read_enb      (read_enb_2),
	       .data_in       (dout),
	       .data_out      (data_out_2),
               .empty         (empty_2),
	       .full          (full_2),
	       .resetn        (resetn),
	       .soft_reset    (soft_reset_2),
	       .lfd_state     (lfd_state)
              );
								
   router_controller FSM(.clock            (clock),          
			 .busy             (busy),
		         .fifo_empty_0     (empty_0),
	 	         .fifo_empty_1     (empty_1),
		         .fifo_full        (fifo_full),           
		         .fifo_empty_2     (empty_2),
		         .packet_valid     (packet_valid),   
		         .data_in          (data[1:0]),
	                 .parity_done      (parity_done),
		         .low_packet_valid (low_packet_valid),
		         .detect_add       (detect_add),
		         .write_enb_reg    (write_enb_reg),
		         .resetn           (resetn),
		         .lp_state         (lp_state),
		         .ld_state         (ld_state),
		         .laf_state        (laf_state),
		         .lfd_state        (lfd_state),
		         .full_state       (full_state),
		         .reset_int_reg    (reset_int_reg),
		         .soft_reset_0     (soft_reset_0),
		         .soft_reset_1     (soft_reset_1),
		         .soft_reset_2     (soft_reset_2)
			);  

   router_sync SYNCH (.clock         (clock),
		      .resetn        (resetn),
		      .detect_add    (detect_add),
		      .data          (data[1:0]),
	              .empty_0       (empty_0),
		      .empty_1       (empty_1),
		      .empty_2       (empty_2),
	              .full_0        (full_0),
	              .full_1        (full_1),
	              .full_2        (full_2),
	              .write_enb_reg (write_enb_reg),
		      .write_enb     (write_enb),
		      .fifo_full     (fifo_full),
		      .vld_out_0     (vld_out_0),
		      .vld_out_1     (vld_out_1),
		      .vld_out_2     (vld_out_2),
		      .soft_reset_0  (soft_reset_0),
		      .soft_reset_1  (soft_reset_1),
	              .soft_reset_2  (soft_reset_2),
		      .read_0        (read_enb_0),
	              .read_1        (read_enb_1),
		      .read_2        (read_enb_2));

   router_reg R_REG(.clock           (clock),
	      	    .resetn          (resetn),
	            .packet_valid    (packet_valid),
		    .data_in         (data),
		    .fifo_full       (fifo_full),
		    .detect_add      (detect_add), 
		    .lfd_state       (lfd_state),
		    .ld_state        (ld_state),
		    .laf_state       (laf_state),
		    .full_state      (full_state),
		    .reset_int_reg   (reset_int_reg),
	            .parity_done     (parity_done),
		    .low_packet_valid(low_packet_valid),
		    .dout            (dout),
		    .err             (err)
	           );
endmodule 
