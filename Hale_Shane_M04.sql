PAGE 449

/*1. Write a script that declares and sets a variable that’s equal to the count 
of all rows in the Invoices table that have a balance due that’s greater than 
or equal to $5,000. Then, the script should display a message that looks like 
this:
3 invoices exceed $5,000.
*/

declare
    v_balance_due   number(9,2);
    v_count         number(3) := 0;
    v_iid           number(3) := 1;
begin

   /*I set the while loop to run until the counter variable 'v_iid' 
   (invoice_id from the invoices table) reaches 115 because 114 is the 
   highest value in the table.
   */

    while (v_iid < 115) loop
        select 
            (invoice_total - payment_total - credit_total)
        into 
            v_balance_due
        from 
            invoices
        where
            invoice_id = v_iid;
        --if the balance due is over 5000, the count is increased by 1  
        if v_balance_due > 5000 then
            v_count := v_count + 1;
            end if;
	   --v_iid is incremented by 1 to iterate through the next row with an invoice_id of 2
        v_iid := v_iid + 1;
    end loop;

    dbms_output.put_line('There are ' || v_count || ' invoices exceeding $5,000');

end;
/



/* 2. Write a script that uses variables to get 
(1) the count of all of the invoices in the Invoices table that have a 
balance due and 
(2) the sum of the balances due for all of those invoices. 
If that total balance due is greater than or equal to $50,000, 
the script should display a message like this:

Number of unpaid invoices is 40. Total balance due is $66,796.24.

Otherwise, the script should display this message:
Total balance due is less than $50,000.
*/

declare
    v_balance_due           number(9,2);
    v_count_balance_due     number(3) := 0;
    v_sum_balance_due       number(9,2);
    v_iid                   number(3) := 1;
begin
    while (v_iid < 115) loop
        select 
            (invoice_total - payment_total - credit_total)
        into 
            v_balance_due
        from 
            invoices
        where
            invoice_id = v_iid;
         
        if v_balance_due > 0 then
            v_count_balance_due := v_count_balance_due + 1;
            end if;
        v_iid := v_iid + 1;
        v_sum_balance_due := v_sum_balance_due + v_balance_due;
    end loop;
    
    dbms_output.put_line(v_sum_balance_due);
end;
/



/* 1. Write a script that uses an anonymous block of PL/SQL code to declare a 
variable and set it to the count of all products in the Products table.

If the count is greater than or equal to 7, the block should display a message 
that says, “The number of products is greater than or equal to 7”.

Otherwise, it should say, “The number of products is less than 7”.
*/

declare 
    v_product_count     mgs_products.product_id%type;    
begin
    
    select count(product_id) into v_product_count
    
    from mgs_products;
    
    if v_product_count >= 7 then
    dbms_output.put_line('The number of products is greater than or equal to 7');
    else
    dbms_output.put_line('The number of products is less than 7');
    end if;
    
end;
/



/* 2. Write a script that uses an anonymous block of PL/SQL code to declare two 
variables to store (1) the count of all of the products in the Products table 
and (2) the average list price for those products.

If the product count is greater than or equal to 7, the stored procedure should 
display a result set that displays the values of both variables.

Otherwise, the procedure should display a result set that displays a message 
that says, “The number of products is less than 7”.
*/

declare
    v_product_count     mgs_products.product_id%type;
    v_product_average   mgs_products.list_price%type;
begin
    select 
        count(product_id),
        avg(list_price)
    into
        v_product_count,
        v_product_average
    from
        mgs_products;
        
    if v_product_count >= 7 then
    dbms_output.put_line('The number of products is ' || v_product_count ||
    ' and the average price is $'|| to_char(v_product_average, 999.99));
    else
    dbms_output.put_line('The number of products is less than 7');
    end if;
end;
/



/* 3. Write a script that uses an anonymous block of PL/SQL code that calculates 
the common factors between 10 and 20.

To find a common factor, you can use the modulo function (MOD) 
(Links to an external site.) to check whether a number can be 
evenly divided into both numbers.

Then, this procedure should display a string that displays the common factors 
like this: Common factors of 10 and 20: 1 2 5
*/

declare
    v_factor_one    number;
    v_factor_two    number;
    v_counter       number;
    common_var      varchar2(100) := 'The common variables of 10 and 20 are: ';
begin
    v_factor_one := 10;
    v_factor_two := 20;
    v_counter := 1;
    
while (v_counter < v_factor_one) loop
                
    if (v_factor_one mod v_counter = 0 and v_factor_two mod v_counter = 0) then
        common_var := common_var || v_counter || ' ';
        end if;
    v_counter := v_counter + 1;
end loop; 
    dbms_output.put_line(common_var);
end;
/



