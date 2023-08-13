module top;
  //import pakage
    import router_pkg::*;
   //import uvm_pkg
    import uvm_pkg::*;
 
    // import router_pkg::*;
      //generate clock signal
    bit clock;
    always #5 clock = ~ clock;
 //instantiate interface insytances
     
               router_if in(clock);
               router_if in0(clock);
               router_if in1(clock);
               router_if in2(clock);
      


       //instantiate rtl and pass the instances as argument
    
         router_top DUV(.clock(clock),
                         .resetn(in.rst),
                         .busy(in.busy),
                         .packet_valid(in.pkt_valid),
                         .data(in.data_in),
                         .err(in.error),
                         .read_enb_0(in0.read_enb),
                         .vld_out_0(in0.v_out),
                     	 .data_out_0(in0.data_out),
                         
                         .read_enb_1(in1.read_enb),
                         .vld_out_1(in1.v_out),
                     	 .data_out_1(in1.data_out),
                         
                         .read_enb_2(in2.read_enb),
                         .vld_out_2(in2.v_out),
                     	 .data_out_2(in2.data_out));



	//initial begin
    
         initial 
               begin
                   
    ///set the virtual interface instances as string vif_1,vif_2,vif_3,vif_0 using the uvm_config_db



			uvm_config_db #(virtual router_if)::set(null,"*","vif",in);
			uvm_config_db #(virtual router_if)::set(null,"*","vif[0]",in0);
			uvm_config_db #(virtual router_if)::set(null,"*","vif[1]",in1);
			uvm_config_db #(virtual router_if)::set(null,"*","vif[2]",in2);
			

//call run_test
         run_test();
   end
endmodule


  
  
