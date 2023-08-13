/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   router_reg.v   

Description :      This module is used to drive bytes of data  to FIFO(Header | payload | parity )

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/
module router_reg(input       clock,
		  input       resetn,
		  input       packet_valid,
		  input  [7:0]data_in,
		  input       fifo_full,
		  input       reset_int_reg,
		  input       detect_add,
		  input       ld_state,
                  input       lfd_state,
		  input       laf_state,
		  input       full_state,									 
	          output  reg  parity_done,
		  output  reg  low_packet_valid,
		  output  reg  [7:0] dout,
		  output  reg  err);										
		

   //Internal signals
   reg [7:0] full_state_byte;
   reg [7:0] pkt_parity;
   reg [7:0] first_byte;
   reg [7:0] parity;
   reg       check_error;

   //Parity_done logic
   always@(posedge clock)
      begin
         if(resetn == 1'b0)
            parity_done <= 1'b0;
         else if((ld_state && !fifo_full && !packet_valid) || (laf_state && !parity_done && low_packet_valid))
            parity_done <= 1'b1;
         else if (detect_add)
            parity_done <= 1'b0;
      end

   //Low_packet_valid logic
   always@(posedge clock)
      begin
         if(resetn == 1'b0)
	    low_packet_valid <= 1'b0;
         else if(ld_state == 1 && packet_valid == 0)
	    low_packet_valid<=1'b1;
         else if(reset_int_reg)
            low_packet_valid <= 1'b0;
      end

   //Register dout logic
   always@(posedge clock)
      begin
         if(resetn == 1'b0)
            begin
 	       dout <= 8'h00;
 	       first_byte <= 8'h00;
               full_state_byte <= 8'h00;														
            end   
         else
            begin
               if(detect_add && packet_valid==1 && data_in[1:0] != 2'b11)
		  first_byte <= data_in;
	       else if(lfd_state)
		  dout<= first_byte;
	       else if(ld_state && !fifo_full)
		  begin
		     dout <= data_in;
		  end
               else if(ld_state && fifo_full)
                  full_state_byte <= data_in;
               else if(laf_state)
                  dout <= full_state_byte;
            end
      end

   //Internal parity logic
   always@(posedge clock)
      begin
	 if(resetn == 1'b0)
	    parity  <=8'h00;
         else
            begin
	       if(detect_add)
	          parity <= 8'h00;
               else if(lfd_state)
		  begin
		     parity  <= parity^first_byte;
                  end
               else if(ld_state && !full_state && packet_valid) 
		  parity <= parity^data_in;
            end
      end

   //Packet_parity logic
   always@(posedge clock)
      begin
         if(resetn == 1'b0)
	    begin
	       pkt_parity <= 8'b0000_0000;												
	    end
         else if(detect_add)
            begin
	       pkt_parity <= 8'b0000_0000;		
            end
	 else if((ld_state && !packet_valid && ~fifo_full)||(laf_state & low_packet_valid & ~parity_done))			
            begin
	       pkt_parity <= data_in; 
            end
					
      end

   //Error logic
   always@(posedge clock)
      begin
         if(!resetn)
            err <=1'b0;
         else if(!parity_done)
            err <= 1'b0;
         else if(pkt_parity!=parity)
            err <= 1'b1;
         else
            err <= 1'b0;
      end

endmodule 


