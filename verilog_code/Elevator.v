// Elevator Controller
// Written by: Prince (Engineering Student)
// Date: 18 November 2024
// For: Digital Systems Design / FPGA Project

module elevator_controller(
    input wire          clk,
    input wire          reset,
    input wire [2:0]    req_floor,      // Requested floor (0 to 7)
    
    output reg [2:0]    current_floor,  // Current floor of the elevator
    output reg          moving          // 1 = elevator is moving, 0 = stopped
);

    // State Encoding
    parameter IDLE       = 2'b00;
    parameter MOVING_UP  = 2'b01;
    parameter MOVING_DOWN= 2'b10;
    parameter ARRIVED    = 2'b11;

    reg [1:0] state, next_state;

    // =========================================================================
    // State Memory (Sequential Logic)
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // =========================================================================
    // Next State Logic (Combinational)
    // =========================================================================
    always @(*) begin
        next_state = state;     // Default assignment to avoid latches (good practice!)

        case (state)
            IDLE: begin
                if (req_floor > current_floor)
                    next_state = MOVING_UP;
                else if (req_floor < current_floor)
                    next_state = MOVING_DOWN;
                // If same floor, stay in IDLE
            end

            MOVING_UP: begin
                if (current_floor == req_floor)
                    next_state = ARRIVED;
            end

            MOVING_DOWN: begin
                if (current_floor == req_floor)
                    next_state = ARRIVED;
            end

            ARRIVED: begin
                next_state = IDLE;      // After arriving, go back to idle
            end

            default: next_state = IDLE;
        endcase
    end

    // =========================================================================
    // Output and Floor Update Logic
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_floor <= 3'd0;   // Start at ground floor (Floor 0)
            moving        <= 1'b0;
        end 
        else begin
            case (state)
                MOVING_UP: begin
                    current_floor <= current_floor + 1'b1;
                    moving        <= 1'b1;
                end
                
                MOVING_DOWN: begin
                    current_floor <= current_floor - 1'b1;
                    moving        <= 1'b1;
                end
                
                ARRIVED: begin
                    moving <= 1'b0;      // Stop moving when arrived
                end
                
                default: begin
                    moving <= 1'b0;
                end
            endcase
        end
    end

    // =========================================================================
    //  Notes:
    // - This is a simple Moore FSM for elevator control
    // - Assumes floors from 0 to 7 (3-bit)
    // - No door open/close logic or multiple requests yet
    // - Moving signal is just an indicator
    // - For better design, we should add floor limits check 
    //   (don't go below 0 or above 7)
    // =========================================================================

endmodule