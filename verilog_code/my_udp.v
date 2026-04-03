
primitive full_adder_sum(sum, a, b, cin);
    output sum;
    input a, b, cin;

    table
    // a b cin : sum
       0 0 0 : 0;
       0 0 1 : 1;
       0 1 0 : 1;
       0 1 1 : 0;
       1 0 0 : 1;
       1 0 1 : 0;
       1 1 0 : 0;
       1 1 1 : 1;
    endtable
endprimitive


primitive full_adder_carry(carry_out, a, b, cin);
    output carry_out;
    input a, b, cin;

    table
    // a b cin : carry_out
       0 0 0 : 0;
       0 0 1 : 0;
       0 1 0 : 0;
       0 1 1 : 1;
       1 0 0 : 0;
       1 0 1 : 1;
       1 1 0 : 1;
       1 1 1 : 1;
    endtable
endprimitive