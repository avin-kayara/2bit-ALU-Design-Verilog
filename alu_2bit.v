module alu_2bit(
    input  [1:0] a, b,
    input  [2:0] opcode,
    output reg [1:0] ALU_out,
    output reg carry
);

    parameter ADD = 3'b000,
              SUB = 3'b001,
              AND = 3'b010,
              OR  = 3'b011,
              XOR = 3'b100;

    reg [2:0] temp;

    always @(*) begin
        temp    = 0;
        ALU_out = 0;
        carry   = 0;

        case(opcode)
            ADD: begin
                temp    = a + b;
                ALU_out = temp[1:0];
                carry   = temp[2];
            end
            SUB: begin
                temp    = a - b;
                ALU_out = temp[1:0];
                carry   = (a >= b) ? 1 : 0;
            end
            AND: ALU_out = a & b;
            OR:  ALU_out = a | b;
            XOR: ALU_out = a ^ b;
            default: ALU_out = 2'b00;
        endcase
    end

endmodule
