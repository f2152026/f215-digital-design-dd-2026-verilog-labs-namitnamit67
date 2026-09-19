module tb_comp2;

    reg [1:0] A;
    reg [1:0] B;

    wire GT;
    wire LT;
    wire EQ;

    integer i, j;
    integer errors;

    comp2 DUT (
        .A(A),
        .B(B),
        .GT(GT),
        .LT(LT),
        .EQ(EQ)
    );

    initial begin
        errors = 0;

        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin

                A = i;
                B = j;

                #1;

                if ((GT !== (A > B)) ||
                    (LT !== (A < B)) ||
                    (EQ !== (A == B))) begin

                    $display("FAIL: A=%d B=%d | GT=%d LT=%d EQ=%d",
                             A, B, GT, LT, EQ);

                    errors = errors + 1;
                end
                else begin
                    $display("PASS: A=%d B=%d", A, B);
                end

            end
        end

        $display("--------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("%d TESTS FAILED", errors);

        $finish;
    end



endmodule