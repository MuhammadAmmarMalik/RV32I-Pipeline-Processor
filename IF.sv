module If_stage (
					input logic clk,
  					input logic reset,
  					input logic pc_sel,
  input logic [32-1:0]alu_out_Ex,
  					output logic [32-1:0] pc_ID,
  					output logic [32-1:0] inst_ID
  					
  			
						);
  logic [32-1:0] inst_IF;
  logic [32-1:0] pc_register; //PC register
  logic [32-1:0] imem [40-1:0];//Instruction memory 
  logic [32-1:0] pc_mux_out; //for mux of PC
  
  //wires for memory register
 
  logic [32-1:0] pc_adder_out;
  //
  
  //instruction fetching
  assign inst_IF = imem[pc_register [31:2]]; //very important pc_register[31:2] instead of pc_register[31:0] because it is word addressable

  
  
  
  assign pc_adder_out = pc_register + 4;
  assign pc_mux_out = pc_sel? alu_out_Ex : pc_adder_out;
  
  //Pc Register
  always @ (posedge clk) begin
   //pc set to zero
    if (reset) 
      pc_register <= 0;
    else
      	pc_register <= pc_mux_out;
  
  end
  
 
  
  //instrution memory initialization 
  always @ (posedge clk) begin
      $readmemh("imem.txt",imem);
  end

	//pipeline registers
  
  always @(posedge clk) begin
  	pc_ID = pc_register;  
  end
  always @(posedge clk) begin
  	inst_ID = inst_IF ;
  end
  
endmodule