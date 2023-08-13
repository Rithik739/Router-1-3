/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage   	  	:   www.maven-silicon.com

Filename   			:	  fifo.v   

Description 		:   This fifo is of 1 byte width and 2 byte depth.
                   	Read and write works simultaneously. This is having full
                   	and empty outputs, which are used to disallow overflow or
                   	underflow. 

Author Name 		:   Susmita

Support e-mail	: 	For any queries, reach out to us on "techsupport_vm@maven-silicon.com" 

Version    			: 	1.0
*********************************************************************************************/
module fifo (input clock,
	     input resetn,  
	     input soft_reset,
	     input write_enb,
	     input read_enb,
	     input lfd_state,
	     input  [7:0]data_in,  
	     output reg [7:0]data_out, 
	     output empty,    
	     output full);

    
   // Internal signals
   reg [8:0] memory [15:0]; 
   reg [4:0] write_ptr; 
   reg [4:0] read_ptr; 
   reg [6:0] count;
   integer i;
   reg lfd_state_d1;

   // FIFO full and empty logic
   assign empty = (write_ptr == read_ptr) ? 1'b1 : 1'b0;
   assign full  = (write_ptr == {~read_ptr[4],read_ptr[3:0]}) ? 1'b1 : 1'b0; 

   //lfd_state delayed by 1 cycle
   always@(posedge clock)
      lfd_state_d1 <= lfd_state;


   //FIFO write and read operation 
   always@(posedge clock) 
	    begin 
	       if(~resetn) 
	          begin
		           write_ptr <= 0;
		           read_ptr  <= 0;
		           data_out  <=8'h00;
		           for(i = 0;i < 16;i=i+1)
		               begin
			                memory[i] <= 0;
		               end
	          end 

	       else if(soft_reset)
	          begin
		           write_ptr <= 0;
		           read_ptr  <= 0;
		           data_out  <=8'hzz;
		           for(i = 0;i < 16 ; i=i+1)
		              begin
			               memory[i] <= 0;
		              end
	          end 

	       else 
	          begin
		           if(write_enb &&  ~full) 
		              begin
			               memory[write_ptr[3:0]] <= {1'b0,data_in};
			               write_ptr <= write_ptr + 1;
			               if(lfd_state_d1)
			                  memory[write_ptr[3:0]] <= {1'b1,data_in};							
		              end 

		           if(read_enb && ~empty)
		              read_ptr <= read_ptr + 1;
						
		           if((count == 0) && (data_out != 0))
		              data_out <= 8'dz;

			         else if(read_enb && ~empty) 
			            begin
			               data_out <= memory[read_ptr[3:0]];
			            end
	          end

      end 


   //FIFO down-counter logic
   always@(posedge clock)
      begin
	       if(~resetn)
	          begin
	             count <= 0;
	          end

	       else if(soft_reset)
	          begin
	             count <= 0;
	          end

	       else if(read_enb & ~empty)
	          begin
	             if(memory[read_ptr[3:0]][8] == 1'b1 )
		              count <= memory[read_ptr[3:0]][7:2] + 1'b1;					
	 	           else if(count != 0)
	    	          count <= count - 1'b1;
      	    end
      end


endmodule 
