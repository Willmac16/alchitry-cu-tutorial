module top(
    input clk,
    input rst,
    output [7:0] LED,
    output [23:0] IO_LED
);

    localparam NUM_LEDS = 32;	
    localparam TIMING_OFFSET = 24;
    localparam COUNTER_WIDTH = NUM_LEDS + TIMING_OFFSET;
    reg [COUNTER_WIDTH-1:0] counter;

    reg [7:0] shift;


    always @(posedge clk) begin
        if (rst == 1'b0) begin
            counter <= 0;
	    shift <= '0;
        end else begin
            counter <= counter + 1;
	    if (counter[TIMING_OFFSET-1:0] == TIMING_OFFSET'd0) begin
		shift[7:0] <= {shift[6:0], ~| shift[6:0]};
	    end
        end
    end

    assign IO_LED = counter[TIMING_OFFSET+3+7:TIMING_OFFSET+3];
    assign LED = shift;
    // assign LED = counter[COUNTER_WIDTH-(24 + 1):COUNTER_WIDTH-32];



endmodule
