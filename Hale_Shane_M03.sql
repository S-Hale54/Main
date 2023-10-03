350 to 351

/* 1. Adds 2 check constraints to the invoices table. The first allows 
payment_date to be null only if the payment_total is 0 and allows payment_date
to be not null only if payment_total is greater than 0. The second ensures
the payment_total and the credit_total together do not exceed the invoice_total
*/

alter table invoices
    add constraint payment_null check
    ((payment_date is null and payment_total = 0) or 
    (payment_date is not null and payment_total > 0));
    
alter table invoices
    add constraint sumcheck check
    (payment_total + credit_total <= invoice_total);
    


-- 2. Add an index to the AP schema for the zip code field in the Vendors table.

create index ix_vendor_zip
on vendors (vendor_zip_code);



Create SQL statements based on the following requirements:



--1. Adds an index to the order_date column in the Orders table

create index mgs_orders_order_date_ix
on mgs_orders (order_date);



-- 2. Creates 2 tables and adds primary and foreign key constraints

create table mgs_users
    (
    user_id         number(10,0) not null,
    email_address   varchar2(50),
    first_name      varchar2(20),
    last_name       varchar2(20),
    constraint pk_users primary key (user_id)
    );

create table mgs_downloads
    (
    download_id     number(10,0) not null,
    user_id         number(10,0) not null,
    download_date   date,
    filename        varchar2(20),
    product_id      number(10,0),
    constraint pk_downloads primary key (download_id),
    constraint fk_downloads_users_user_id 
        foreign key (user_id)
            references mgs_users (user_id),
    constraint fk_downloads_products_product_id
        foreign key (product_id)
            references mgs_products (product_id)            
    );
 
-- Creates a sequence for each table (The product_id column already has values up to 11 so I set a minvalue of 12)   
    
create sequence users_seq minvalue 1
    increment by 1;
    
create sequence downloads_seq minvalue 1
    increment by 1;
    
create sequence product_id_seq minvalue 12
    increment by 1;
    
create index ix_download_date
on mgs_downloads (download_date);



-- 3. Write an ALTER TABLE statement that adds two new columns to the Products table 

alter table mgs_products
add product_price number(5,2);

alter table mgs_products
modify product_price default '9.99';

alter table mgs_products
add date_added date;



/* 4. Write an ALTER TABLE statement that modifies the Users table created in 
exercise 2 so the first_name column can store NULL values and can store a 
maximum of 20 characters. (10 points)
*/

alter table mgs_users
modify first_name varchar2(20) null;

update mgs_users
set first_name = null;

update mgs_users
set first_name = 'Name too long for entry';



Create schema objects based on the following requirements:


--1. Creates a sequence named F_CUSTOMERS_SEQ that has a minimum value of 500, increments by 1, and has a start value of 501

create sequence f_customers_seq 
    start with 501 increment by 1
    minvalue 500;

--2. Creates a sequence named F_FOOD_ITEMS_SEQ that has a minimum value of 100, increments by 1, and has a start value of 101

create sequence f_food_items_seq 
    start with 101 increment by 1
    minvalue 100;

--3. Creates a sequence named F_ORDERS_SEQ that has a minimum value of 1000, increments by 1, and has a start value of 1001

create sequence f_orders_seq 
    start with 1001 increment by 1
    minvalue 1000;



--4. Alter the table F_ORDER_LINES

--1. Drop the primary key (F_OLE_PK) from F_ORDER_LINES

alter table f_order_lines
drop constraint f_ole_pk;


--2. TRUNCATE F_ORDERS and F_ORDER_LINES 

--The foreign key constraint in f_order_lines must be dropped before f_orders can be truncated

alter table f_order_lines
drop constraint f_ole_order_number_fk;

truncate table f_orders;

truncate table f_order_lines;


--3. Adds a new column named ORDER_LINE to F_ORDER_LINES

alter table f_order_lines
add order_line number(2);


--4. Creates a new primary key for F_ORDER_LINES that contains the old primary key columns (ORDER_NUMBER, FOOD_ITEM_NUMBER and the new column)

alter table f_order_lines
add constraint f_ole_pk primary key (order_number, food_item_number, order_line);