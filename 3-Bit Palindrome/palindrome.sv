module palindrome(
    input logic clk,reset,
    input logic inp,
    output logic palidrome_o
);

    logic [1:0] current_count, next_count;
    logic [1:0] shift_reg_current,shift_reg_next;

    always_ff @(posedge clk or negedge reset)
        if(reset) begin
            current_count <= 2'b00;
            shift_reg_current <= 2'b00;
        end
        else begin
            current_count <= next_count;
            shift_reg_current <= shift_reg_next;
        end

    assign next_count = current_count[1] ? current_count : current_count + 2'b01;
    assign shift_reg_next = {shift_reg_current[0],inp};
    assign palidrome_o = (inp == shift_reg_current[1]) & current_count[1];
endmodule