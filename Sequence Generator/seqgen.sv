module seqgen(
    input logic clk,reset,
    output logic seq_o
);
  logic [31:0] seq2, seq3, seq1;
  logic [31:0] seq_nxt;

  always @(posedge clk or posedge reset)
    begin
        if(reset) begin  // Assigning initial values
            seq3 <= 32'h0;
            seq2 <= 32'h1;  
            seq1 <= 32'h1;
        end
        else begin      // Iterating through the sequence
            seq3 <= seq2;
            seq2 <= seq1;  
            seq1 <= seq_nxt;
        end
    end


  assign seq_nxt = seq3 + seq2;
  assign seq_o = seq3;
endmodule