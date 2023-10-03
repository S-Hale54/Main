Page 230

--1. Inserts a row into invoices
insert into invoices
values(115, 32, 'AX-014-027', '01-AUG-14', 434.58 , 0.00, 0.00, 2, '31-AUG-14', null);

--2. Updates the default_account_number column for selected entries
update vendors
set default_account_number = 403
where default_account_number = 400;

--3. Updates the invoices table using the default_terms_id in the vendor table
update invoices
set terms_id = 2
where vendor_id in
(select vendor_id
from vendors
where default_terms_id = 2);

--4. Deletes the row with an invoice_id of 115 from the invoices table 
Delete from invoices
where invoice_id = 115;

--5. Issues a rollback of the changes made
ROLLBACK;

Page 280 - 281

--1. Selects the invoice_totals column (plus variations) from the invoices table
select 
    invoice_total,
    to_char(invoice_total, '999,999.99') as decimal_format,
    to_char(invoice_total, '999,999') as no_decimal_format,
    lpad(cast(invoice_total as int), 7, '0') as seven_digit_format
from invoices;

--2. Selects the invoice_date column in various ways
select
    invoice_date, 
    to_char(invoice_date, 'DD-MON-YYYY HH24:MM:SS'), 
    to_char(invoice_date, 'DD-MON-YYYY HH:MM:SS AM'),
    cast(invoice_date as varchar2(20))
from invoices;

--3. Selects the vendor_name column and the vendor_name column in capital letters
select
    vendor_name,
    UPPER(vendor_name)
from vendors;

--4. Selects information from the invoice table for the month of May
select
    invoice_number,
    invoice_date,
    invoice_date + 30,
    payment_date,
    payment_date - invoice_date as days_to_pay,
    to_number(to_char(invoice_date, 'MM')) as month_number,
    to_char(invoice_date, 'YYYY') as four_digit_year,
    last_day(invoice_date)
from invoices
where
    to_char(invoice_date, 'MON') = 'MAY';

--5. Selects the invoice number and calculates the balance due
select invoice_number, 
    to_char(invoice_total - payment_total - credit_total, '999,999.99') as balance_due
from invoices;


PART TWO

--1. Inserts a row into the mgs_categories and commits the change
insert into mgs_categories(category_id, category_name)
values(5, 'Brass');

commit;

--2. Updates the category_name column in the mgs_categories table according to the category_id
update mgs_categories
set category_name = 'Woodwind'
where category_id = 5;

--3. Deletes the row from the mgs_categories according to the category_id
delete from mgs_categories
where category_id = 5;

--4. Inserts a row into the mgs_products table
insert into mgs_products
values(11, 4, 'dgx-640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, current_date);

--5. Updates ht emgs_products table. Sets the discount_percent column to 35 for the product_id of 11
update mgs_products
set discount_percent = 35
where product_id = 11;

--6. Creates an index on the order_date column in the mgs_orders table
create index mgs_orders_order_date_ix
on mgs_orders (order_date);