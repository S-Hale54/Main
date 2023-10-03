PAGE 449

/* 3. Write a script that creates a cursor consisting of vendor_name, 
invoice_number, and balance_due for each invoice with a balance due that’s 
greater than or equal to $5,000. The rows in this cursor should be sorted in 
descending sequence by balance due. Then, for each invoice, display the balance 
due, invoice number, and vendor name so it looks something like this:

$19,351.18	P-0608	Malloy Lithographing Inc
*/

declare cursor invoice_cursor is
    select
        v.vendor_name, 
        i.invoice_number, 
        i.invoice_total - payment_total - credit_total as balance_due
    from
        vendors v
        join invoices i
            on v.vendor_id = i.vendor_id
    where
        i.invoice_total - payment_total - credit_total >= 5000
    order by
        balance_due desc;
    
    invoice_row invoices%rowtype;
begin
    for invoice_row
    in invoice_cursor loop
    
        dbms_output.put_line(
            to_char(invoice_row.balance_due, '$99,999.99') || '    ' ||
            invoice_row.invoice_number || '    ' ||
            invoice_row.vendor_name);
    end loop;
end;
/



/* 4. Enhance your solution to exercise 3 so it shows the invoice data in three 
groups based on the balance due amounts with these headings:

$20,000 or More 
$10,000 to $20,000 
$5,000 to $10,000

Each group should have a heading followed by the data for the invoices that fall
into that group. Also, the groups should be separated by one blank line.
*/

declare

counter_one     number(1) := 0;
counter_two     number(1) := 0;
counter_three   number(1) := 0;

cursor invoice_cursor is
    select
        v.vendor_name, 
        i.invoice_number, 
        i.invoice_total - payment_total - credit_total as balance_due
    from
        vendors v
        join invoices i
            on v.vendor_id = i.vendor_id
    where
        i.invoice_total - payment_total - credit_total >= 5000
    order by
        balance_due desc;
    
    invoice_row invoices%rowtype;

begin

    for invoice_row
    in invoice_cursor loop
        
        
        if invoice_row.balance_due > 20000 then
        if counter_one = 0 then
        counter_one := counter_one + 1;
        dbms_output.put_line('$20,000 or More');
        end if;
        
        dbms_output.put_line(
            to_char(invoice_row.balance_due, '$99,999.99') || '    ' ||
            invoice_row.invoice_number || '    ' ||
            invoice_row.vendor_name);
        
            
        elsif invoice_row.balance_due between 10000 and 20000 then
        if counter_two = 0 then
        counter_two := counter_two + 1;
        dbms_output.put_line(' ');
        dbms_output.put_line('$10,000 to $20,000');
        end if;
        
        dbms_output.put_line(
            to_char(invoice_row.balance_due, '$99,999.99') || '    ' ||
            invoice_row.invoice_number || '    ' ||
            invoice_row.vendor_name);
            
        else
        if counter_three = 0 then
        counter_three := counter_three + 1;
        dbms_output.put_line(' ');
        dbms_output.put_line('$5,000 to $10,000');
        end if;
        dbms_output.put_line(
            to_char(invoice_row.balance_due, '$99,999.99') || '    ' ||
            invoice_row.invoice_number || '    ' ||
            invoice_row.vendor_name);
        end if;
    end loop;
end;
/



/* 5. Enhance your solution to exercise 3 so it uses a substitution variable to set
a bind variable that you use to determine what the minimum balance due should be
for the invoices that the SELECT statement is going to retrieve. You should also
use this bind variable to display a heading like this before the list of invoices:

Invoice amounts greater than or equal to $2,000
===================================================
where 2,000 is the value of the bind variable.
*/

declare cursor invoice_cursor is
    select
        v.vendor_name, 
        i.invoice_number, 
        i.invoice_total - payment_total - credit_total as balance_due
    from
        vendors v
        join invoices i
            on v.vendor_id = i.vendor_id
    where
        i.invoice_total - payment_total - credit_total >= :minimum_value
    order by
        balance_due desc;
    
    invoice_row invoices%rowtype;
begin
    :minimum_value := &minimum_amount;
    dbms_output.put_line('Invoice amounts greater than or equal to $' || :minimum_value);
    dbms_output.put_line('===================================================');
    for invoice_row
    in invoice_cursor loop
    
        dbms_output.put_line(
            to_char(invoice_row.balance_due, '$99,999.99') || '    ' ||
            invoice_row.invoice_number || '    ' ||
            invoice_row.vendor_name);
    end loop;
end;
/

Create SQL statements based on the following requirements:


/*1. Write a script that uses an anonymous block of PL/SQL code that creates a 
cursor for a result set for each product with a list price that’s greater than 
$700 that consists of the following columns.

product_name
list_price columns
The rows in this result set should be sorted in descending sequence by list price.
Then, the procedure should display a string variable that includes the product_name and list price for each product so it looks something like this:
"Gibson SG","2517.00"|"Gibson Les Paul","1199.00"|
Here, each value is enclosed in double quotes ("), each column is separated by a comma (,) and each row is separated by a pipe character (|).
*/

declare cursor products_cursor is
    select
        product_name,
        list_price
    from
        mgs_products
    where
        list_price > 700
    order by
        list_price desc;
    
    product_row mgs_products%rowtype;    
begin
    for product_row in
    products_cursor loop
    
        dbms_output.put_line(
        '"' || product_row.product_name || '"' || ', ' || '"' ||
        product_row.list_price || '"' || '|');
    end loop;
end;
/



/*2. Write a script that uses an anonymous block of PL/SQL code that attempts to
insert a new category named “Guitar” into the Categories table.

If the insert is successful, the procedure should display this message: 1 row was inserted.
If the update is unsuccessful, the procedure should display this message: Row was not inserted - duplicate entry.
*/
begin
    insert into mgs_categories
    values(5, 'Guitar');
    
    dbms_output.put_line('1 row was inserted.');
    
    exception
        when DUP_VAL_ON_INDEX
            then dbms_output.put_line('Row was not inserted - duplicate entry.');
end;
/