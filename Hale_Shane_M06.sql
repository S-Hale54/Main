PAGE 532

/*1. Create a trigger named invoices_before_update_payment for the 
Invoices tablethat raises an application error whenever the payment total plus 
the credit total becomes larger than the invoice total in a row. 
Then, test this trigger with an appropriate UPDATE statement.
*/

create or replace trigger trg_invoices_before_update_payment
	before update of payment_total
		on invoices
	for each row
    	when (new.payment_total + old.credit_total > old.invoice_total)  
    	begin
        raise_application_error(-20001, 'Error: payment_total + credit_total
            exceeds invoice_total');
    	end;


update invoices
set payment_total = 150
where invoice_id = 1;



/* 2. Create a trigger named invoices_after_update_payment for the 
Invoices table that displays the vendor name, invoice number, and payment total
in the output window whenever the payment total is increased. Then, test this 
trigger with an appropriate UPDATE statement.
*/

create or replace trigger trg_invoices_after_update_payment
    after update of payment_total
        on invoices
    for each row
    when (new.payment_total > old.payment_total)
    begin
        dbms_output.put_line('Vendor: ' || :new.vendor_id);
        dbms_output.put_line('Invoice number: ' || :old.invoice_number);
        dbms_output.put_line('Payment total: ' || :new.payment_total);
    end;

:new.payment_total
update invoices
set payment_total = 1000, payment_date = '18-APR-21'
where invoice_id = 6;



/* 3. Use the script for figure 11-4 of chapter 11 to create an updateable view 
named balance_due_view. Then, create and test an INSTEAD OF trigger named 
invoices_instead_of_insert that lets the user update the columns in the view by 
directly updating the Invoices table. Within this trigger, you can call the 
stored procedure named insert_invoice that’s created by the script for figure 
15-5 of chapter 15.
*/

create or replace trigger trg_invoices_instead_of_insert
    instead of update on balance_due_view
    for each row
    begin
        update invoices
        set invoice_number = :new.invoice_number;
        
        update invoices
        set invoice_total = :new.invoice_total;
        
        update invoices
        set payment_total = :new.payment_total;
        
        update invoices
        set credit_total = :new.credit_total;
        
        update vendors
        set vendor_name = :new.vendor_name;
    end;



Create SQL statements based on the following requirements:


/* 1. Create a trigger named products_before_update that checks the new value 
for the discount_percent column of the mgs_products table.

This trigger should raise an appropriate error if the discount percent is 
greater than 100 or less than 0. If the new discount percent is between 0 and 1,
this trigger should modify the new discount percent by multiplying it by 100.
That way, a discount percent of .2 becomes 20.
Test this trigger with an appropriate UPDATE statement.
*/

create or replace trigger trg_products_before_update
    before update of discount_percent on mgs_products
    for each row
    begin
        if :new.discount_percent between 0 and 1 then
            :new.discount_percent := (:new.discount_percent * 100);
        elsif :new.discount_percent > 100 or :new.discount_percent < 0 then
            raise_application_error(-20020, 'Error: discount_percent greater than 100 or less than 0.');
        end if;        
    end;

update mgs_products
set discount_percent = 101
where product_id = 1;

update mgs_products
set discount_percent = .3
where product_id = 1;



/* 2. Create a trigger named products_before_insert that inserts the current
date for the date_added column of the Products table if the value for that column is null.

Test this trigger by creating an appropriate INSERT statement.
*/

/*I'm close on this one but can't figure it out. The trigger compiles and the row inserts, but the date added column for the new row is null and will not update 
no matter what I try. I somehow set every other record in that column to the sysdate of 18-APR-22.
*/

create or replace trigger trg_products_before_insert
before insert on mgs_products 
for each row
    declare
        v_null  varchar2(10);
    begin
        v_null := :new.date_added;
        
        if v_null is null then
            update mgs_products
            set date_added = sysdate
            where date_added is null;
        end if;
    end;
    
insert into mgs_products (product_id, category_id, product_code, product_name, description, list_price, discount_percent, date_added, product_price)
values (14, 3, 'zildjian', 'Bongo', ' ', 59.99, 0, null, null);



/* 3. Create a table named mgs_products_audit based on the mgs_products table. 
This table should have all columns of the mgs_products table, except the 
description column.

Create a numeric column with the name audit_id and set this column as the primary key.
The date_added column should be renamed to date_updated.
*/

create table mgs_products_audit 
    (
    audit_id            number primary key,
    product_id          number,
    category_id         number,
    product_code        varchar2(10),
    product_name        varchar2(255),
    list_price          number(10,2),
    discount_percent    number(10,2),
    date_updated        date,
    product_price       number(5,2)
    );



/* 4. Create a trigger named products_after_update. This trigger should insert 
the old data about the product into the Products_Audit table after the row is updated.

Test this trigger with an appropriate UPDATE statement.
*/

-- The only method I could come up with for handling the primary key column of audit_id was to code a sequence to use in the trigger


create sequence mgs_product_audit
minvalue 1
increment by 1;

create or replace trigger trg_products_after_update
    after update on mgs_products
        for each row       
        begin
            insert into mgs_products_audit
            values(mgs_product_audit.nextval,
                    :old.product_id, 
                    :old.category_id,
                    :old.product_code,
                    :old.product_name,
                    :old.list_price,
                    :old.discount_percent,
                    :old.date_added,
                    :old.product_price);
        end;

update mgs_products
set list_price = 899.99
where product_id = 10;



/* 5. Create an index on the mgs_products_audit table, the index should be created on the product_code column.
*/

create index mgs_audit_produce_code_idx
on mgs_products_audit(product_code);