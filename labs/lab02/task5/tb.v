module tb;

    reg [3:0] a;
    reg [3:0] b;
    reg       op;

    wire [3:0] result;

    alu DUT (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    task check;
        input [3:0] expected;

        begin
            #1;

            if (result !== expected)
                $display("FAIL: a=%d b=%d op=%b | result=%d | expected=%d",
                         a, b, op, result, expected);
            else
                $display("PASS: a=%d b=%d op=%b | result=%d",
                         a, b, op, result);
        end
    endtask

    initial begin

        // ADDITION TESTS
        op = 0; a = 4; b = 3;
        check(7);

        a = 7; b = 2;
        check(9);

        a = 15; b = 1;
        check(0);       // 4-bit overflow wraps around

        // SUBTRACTION TESTS
        op = 1; a = 7; b = 3;
        check(4);

        a = 10; b = 4;
        check(6);

        a = 3; b = 5;
        check(14);      // 3 - 5 = -2 = 1110 in 4-bit

        $finish;
    end



endmodule