/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   router_sync.v   

Description :      This module synchronizes a particular FIFO with the FSM.

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/
module router_sync(input       clock,
		   input       resetn,
		   input       detect_add,
	           input [1:0] data,
		   input       write_enb_reg,
		   input       empty_0,
		   input       empty_1,
	           input       empty_2,
		   input       full_0,
		   input       full_1,
		   input       full_2,
		   input       read_0,read_1,read_2,
		   output reg [2:0] write_enb,
		   output reg    fifo_full,
		   output       vld_out_0,
		   output       vld_out_1,
		   output       vld_out_2,
		   output reg soft_reset_0,soft_reset_1,soft_reset_2);

   //Internal signals
   reg  [1:0] addr;
   reg  [4:0] count_read_0;
   reg  [4:0] count_read_1;
   reg  [4:0] count_read_2;
		
   //Address logic
   always@(posedge clock)
      if(detect_add)
         addr <= data;
				
   //Write_enb logic
   always@(*)
      begin
         if(~write_enb_reg)
             write_enb = 0;
         else 
            begin
               case(addr) 
                  2'b00   : write_enb = 3'b001;
	          2'b01   : write_enb = 3'b010;
	          2'b10   : write_enb = 3'b100;
	          default : write_enb = 0;
               endcase
            end
       end

   //Output data will be valid at channels when vld_out will be high
   assign vld_out_0 = ~empty_0;
   assign vld_out_1 = ~empty_1;
   assign vld_out_2 = ~empty_2;

   //Soft reset0 logic 
   always@(posedge clock)
      begin
	 if(~resetn)
	    begin
	       count_read_0 <= 0;
	       soft_reset_0 <= 0;
    	    end
	 else if(~vld_out_0)
            begin
	       count_read_0 <=0;
	       soft_reset_0 <= 0;
	    end
	 else if(read_0)
	    begin
	       count_read_0 <= 0;
	       soft_reset_0 <= 0;
	    end
	 else
	    begin
	       if(count_read_0 == 29)
		  begin
		     count_read_0 <= 0;
		     soft_reset_0 <= 1;
		  end
	       else
	          begin
	             count_read_0 <=count_read_0 + 1;
                     soft_reset_0 <= 0;
	          end
	    end
      end
				
   //Soft reset1 logic 
   always@(posedge clock)
      begin
	 if(~resetn)
	    begin
	       count_read_1 <= 0;
	       soft_reset_1 <= 0;
	    end
	 else if(~vld_out_1)
	    begin
	       count_read_1 <=0;
	       soft_reset_1 <= 0;
	     end
	 else if(read_1)
	    begin
	       count_read_1 <= 0;
	       soft_reset_1 <= 0;
	    end
	 else
	    begin
	       if(count_read_1 == 29)
		  begin
		      count_read_1 <= 0;
		      soft_reset_1 <= 1;
		  end
	       else
		  begin
		     count_read_1 <=count_read_1 + 1;
		     soft_reset_1 <= 0;
		  end
            end
      end
			
   //Soft reset2 logic 
   always@(posedge clock)
      begin
         if(~resetn)
            begin
               count_read_2 <= 0;
	       soft_reset_2 <= 0;
            end
         else if(~vld_out_2)
            begin
               count_read_2 <=0;
               soft_reset_2 <= 0;
	    end
         else if(read_2)
            begin
	       count_read_2 <= 0;
	       soft_reset_2 <= 0;
            end
         else
            begin
               if(count_read_2 == 29)
                  begin
                     count_read_2 <= 0;
                     soft_reset_2 <= 1;
                  end
               else
                  begin
                     count_read_2 <=count_read_2 + 1;
                     soft_reset_2 <= 0;
                  end
            end
      end

   //FIFO full logic
   always@(*)
      begin
         case(addr) 
	    2'b00   :fifo_full = full_0;																            2'b01   :fifo_full = full_1;
	    2'b10   :fifo_full = full_2;	
            default :fifo_full = 1'b0;
	 endcase
      end										

					
endmodule
