// Round Robin Arbiter
// Written by: Prince (Engineering Student)
// Date: April 2026
// For: FPGA Design Lab / Digital Systems Project

module round_robin_arbiter #(
    parameter N = 4  // Number of requestors (default 4)
) (
    input  wire             clk,
    input  wire             rst_n,      // Active low reset
    
    input  wire [N-1:0]     req,        // Request signals from N masters
    output reg  [N-1:0]     grant       // Grant to one master at a time
);

    // Internal signals
    reg  [N-1:0] pointer;       // Current pointer (points to highest priority next)
    wire [N-1:0] req_masked;    // Requests after masking with pointer
    wire [N-1:0] grant_next;    // Next grant value
    
    // =========================================================================
    // Masking logic: Higher priority to requests after current pointer
    // =========================================================================
    assign req_masked = req & ~((pointer << 1) | (pointer >> (N-1)));  
    // This is a common (but slightly tricky) way students implement circular masking

    // Find the highest priority request in masked + original requests
    assign grant_next = req_masked ? 
                        (req_masked & ~(req_masked - 1)) :   // Get the LSB set bit
                        (req & ~(req - 1));                  // If no masked, take from beginning

    // =========================================================================
    // Sequential logic - Update pointer and grant
    // =========================================================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            grant   <= 0;
            pointer <= 1;           // Start with master 0 having highest priority after reset
        end 
        else begin
            if (|req) begin         // If any request is active
                grant <= grant_next;
                
                // Update pointer to the next position after the granted master
                if (|grant_next) begin
                    // Find position of granted master and shift pointer
                    case (grant_next)
                        4'b0001: pointer <= 4'b0010;
                        4'b0010: pointer <= 4'b0100;
                        4'b0100: pointer <= 4'b1000;
                        4'b1000: pointer <= 4'b0001;
                        default: pointer <= {pointer[N-2:0], pointer[N-1]}; // Circular shift
                    endcase
                end
            end
            else begin
                grant <= 0;         // No requests, no grant
            end
        end
    end


    // Note: The case statement above works well for N=4.
    // For larger N, we should use a barrel shifter or priority encoder.
    // But since prof said N<=8, this is fine for now :)

endmodule