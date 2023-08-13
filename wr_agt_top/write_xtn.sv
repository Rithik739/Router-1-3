class write_xtn extends uvm_sequence_item;
 
//uvm factory registration macro
`uvm_object_utils(write_xtn)



//data members
    
    rand bit[7:0] header;
   rand bit[7:0] payload_data[];
    bit[7:0] parity;
   bit err;
		

//constraints
  constraint c1{header[1:0]!=3;}
  constraint c2{payload_data.size==header[7:2];}	

  constraint c3{payload_data.size!=0;}	



// standard uvm
  
    extern function new(string name="write_xtn");
    extern function void do_print(uvm_printer printer);
    extern function void post_randomize();

endclass
//constructor 
  
     function write_xtn::new(string name = "write_xtn");
            super.new(name);
        endfunction


//post randomize

   function void write_xtn::post_randomize();
      parity=0^header;
      foreach(payload_data[i])
       begin
            parity=parity^payload_data[i];
    end       
endfunction

//do print
  
   function void write_xtn::do_print (uvm_printer printer);
       super.do_print(printer);

       printer.print_field("header",this.header, 8, UVM_HEX);
       foreach(payload_data[i])
        printer.print_field($sformatf("payload_data[%0d]",i),this.payload_data[i],    8 ,   UVM_HEX);
       printer.print_field("parity",this.parity  ,  8  ,  UVM_HEX);
   endfunction

