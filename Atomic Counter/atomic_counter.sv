         
/*                          ┌─────────┐      
                     trig   │         │    ack
                  ─────────►│         │────────────►
                    atomic  │ Atomic  │      
                  ─────────►│ Counter │ count[31:0]
                     req    │         ├────────────►
                  ─────────►│         │
                            │         │      
                            └─────────┘      
*/

module atomic_counter(
    input bit clk,reset,
    input logic trig,atomic,req,
    output logic ack,
    output logic [31:0] count
);

logic atomic_ff , req_ff;
logic [63:0] c_count , count_ff;
logic [31:0] count_msb;

always_ff @(posedge clk or posedge reset)
    if(reset) begin
        atomic_ff <= 1'b0;
        req_ff <= 1'b0;
    end
    else begin
        atomic_ff <= atomic;
        req_ff <= req; 
    end

always_ff @(posedge clk or posedge reset)
    if(reset) 
        c_count <= 64'b0;
    else
        c_count <= count_ff;
assign count_ff = c_count + {{63{1'b0}},trig};

always_ff @(posedge clk or posedge reset)
    if(reset)
        count_msb <= 32'b0;
    else if(atomic_ff) 
        count_msb <= c_count[63:32];

assign ack = req_ff;
assign count = req_ff ? (atomic_ff ? c_count[31:0] : count_msb)
                   : 32'b0;
endmodule