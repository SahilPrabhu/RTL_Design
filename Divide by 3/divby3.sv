/*
Input	Formed Number       	Divisible by Three
0	        'b0	                        Yes
1	        'b01	                    No
1	        'b011	                    Yes
0	        'b0110	                    Yes
1	        'b01101	                    No

i) x_i = 0 => {a, 0} => (2×a) % 3 = 0
   x_i = 1 => {a, 1} => (2×a + 1) % 3 = 1

ii) x_i = 0 => {2a+1, 0} => 2(2a+1) = (4a+2) % 3 = 2
    x_i = 1 => {2a+1, 1} => 2(2a+1) + 1 = (4a+3) % 3 = 0

iii) x_i = 0 => {4a+2, 0} => 2(4a+2) = (8a+4) % 3 = 1
     x_i = 1 => {4a+2, 1} => 2(4a+2) + 1 = (8a+5) % 3 = 2
*/

module divby3(
    input logic clk,reset,
    input logic inp,
    output logic div
);

typedef enum {REM_0 , REM_1 , REM_2} state;

state current_state;
state next_state;

always_ff @(posedge clk or posedge reset)
    if(reset)
        current_state <= REM_0;
    else   
        current_state <= next_state;

always_comb begin 
    div = 1'b0;
    case(current_state)
        REM_0 : 
            if(inp) begin
                next_state = REM_1;
            end
            else begin
                next_state = REM_0;
                div = 1'b1;
            end
        REM_1 :
            if(inp) begin
                next_state = REM_1;
                div = 1'b1;
            end
            else begin
                next_state = REM_2;
            end
        REM_2 :
            if(inp) begin
                next_state = REM_2;
            end
            else begin
                next_state = REM_1;
            end
        default : next_state = REM_0;
    endcase
end
endmodule