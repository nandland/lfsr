// Description: Simple Testbench for LFSR.v.  Set NUM_BITS to different
// values to verify operation of LFSR
module LFSR_TB ();
 
  parameter NUM_BITS = 3;
   
  reg r_Clk = 1'b0;
   
  wire [NUM_BITS-1:0] w_LFSR_Data;
  wire w_LFSR_Done;
  reg r_Seed_DV = 1'b0;
  
  LFSR #(.NUM_BITS(NUM_BITS)) LFSR_inst
         (.i_Clk(r_Clk),
          .i_Enable(1'b1),
          .i_Seed_DV(r_Seed_DV),
          .i_Seed_Data({NUM_BITS{1'b0}}), // Replication
          .o_LFSR_Data(w_LFSR_Data),
          .o_LFSR_Done(w_LFSR_Done)
          );
  
  always #10 r_Clk <= !r_Clk; // create oscillating clock
   
  initial 
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      @(posedge r_Clk);
      r_Seed_DV <= 1'b1;
      @(posedge r_Clk);
      r_Seed_DV <= 1'b0;
      @(posedge r_Clk);
      repeat (10) @(posedge r_Clk);
      #10;
      $finish();
    end
  
  
endmodule // LFSR_TB