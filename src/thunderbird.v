// Ford Thunderbird Rearlights Controller
// Juan Fernando Posso & Pierina Miraba


// Two-bit counter
module counter (input wire clk,
                input wire rst,
                output reg [1:0] count);
  
  always @(posedge clk or posedge rst) begin
      if (rst)
          count <= 2'b00;
      else
          count <= count + 1'b1;
  end
  
endmodule


// Controller
module controller (input wire [1:0] state,
                   input wire [1:0] control,
                   output reg [1:0] left,
                   output reg [1:0] right);
  
  always@* begin
    case(control)
      2'b00: begin
             left = 2'b00;
        	 right = 2'b00;
     		 end
      
      2'b01: begin
             left = state;
        	 right = 2'b00;
     		 end
      
      2'b10: begin
             left = 2'b00;
        	 right = state;
     		 end

      2'b11: begin
             left = state;
        	 right = state;
     		 end
      
      default: begin
               left = 2'b00;
        	   right = 2'b00;
     		   end
    endcase
  end

endmodule


// Decoder
module decoder (input wire [1:0] in,
                output reg [2:0] out);
  
  always@* begin
    case(in) 
      2'b00: out = 3'b000;
      2'b01: out = 3'b001;
      2'b10: out = 3'b011;
      2'b11: out = 3'b111;
      default: out = 3'b000;
    endcase
  end
      
endmodule


// Top Module
module top(input wire clk,
           input wire rst,
           input wire [1:0] blinker,
           output wire [2:0] left,
           output wire [2:0] right);
  
  wire [1:0] count;
  wire [1:0] leftnode;
  wire [1:0] rightnode;
  
  counter cnt(.clk(clk), .rst(rst), .count(count));
  
  controller ctr(.state(count), .control(blinker), .left(leftnode), .right(rightnode));
  
  decoder dcr1(.in(leftnode), .out(left));
  
  decoder dcr2(.in(rightnode), .out(right));
  
  
endmodule
                                      
                