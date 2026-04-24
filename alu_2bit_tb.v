
`timescale 1ns/1ns

module alu_2bit_tb;

    reg  [1:0] a, b;
    reg  [2:0] opcode;
    wire [1:0] ALU_out;
    wire carry;

    alu_2bit DUT (
        .a(a), .b(b),
        .opcode(opcode),
        .ALU_out(ALU_out),
        .carry(carry)
    );

    initial begin
        $dumpfile("alu_2bit.vcd");
        $dumpvars(0, alu_2bit_tb);

        // ADD: 2 + 1 = 3
        a = 2'b10; b = 2'b01; opcode = 3'b000; #10;
        $display("ADD: %0d + %0d = %0d | carry=%b", a, b, ALU_out, carry);

        // ADD with carry: 3 + 2 = 5 (overflow, out=1, carry=1)
        a = 2'b11; b = 2'b10; opcode = 3'b000; #10;
        $display("ADD(carry): %0d + %0d = %0d | carry=%b", a, b, ALU_out, carry);

        // SUB: 3 - 1 = 2
        a = 2'b11; b = 2'b01; opcode = 3'b001; #10;
        $display("SUB: %0d - %0d = %0d | carry=%b", a, b, ALU_out, carry);

        // SUB: 1 - 3 (underflow)
        a = 2'b01; b = 2'b11; opcode = 3'b001; #10;
        $display("SUB(uflow): %0d - %0d = %0d | carry=%b", a, b, ALU_out, carry);

        // AND: 11 & 10 = 10
        a = 2'b11; b = 2'b10; opcode = 3'b010; #10;
        $display("AND: %b & %b = %b", a, b, ALU_out);

        // OR:  11 | 10 = 11
        a = 2'b11; b = 2'b10; opcode = 3'b011; #10;
        $display("OR:  %b | %b = %b", a, b, ALU_out);

        // XOR: 11 ^ 10 = 01
        a = 2'b11; b = 2'b10; opcode = 3'b100; #10;
        $display("XOR: %b ^ %b = %b", a, b, ALU_out);

        $finish;
    end

endmodule
