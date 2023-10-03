PAGES 350 - 351

--3. Creates 3 tables with primary key and foreign key constraints

create table members
    (
    member_id       number(38, 0) not null,
    first_name      varchar2(50),
    last_name       varchar2(50),
    address         varchar2(50),
    city            varchar2(25),
    state           varchar2(2),
    phone           number(11),
    constraint pk_members primary key (member_id)
    );
    
create table groups
    (
    group_id        number(8,0) not null,
    group_name      varchar2(50),
    constraint pk_groups primary key (group_id)
    );

create table member_groups
    (
    member_id       number(38,0),
    group_id        number(8,0),
    constraint fk_members_group_members_id
        foreign key (member_id)
            references members (member_id)
        );



--4. Inserts rows into the 3 new tables, then joins the tables in a select statement

insert into members
    values(1, 'Walter', 'White', '3828 Piermont Dr.', 'Albuquerque', 'NM', 5056194288);
    
insert into members
    values(2, 'Jesse', 'Pinkman', '9809 Margo St.', 'Albuquerque', 'NM', 1234567890);
    
insert into groups
    values(1, 'Chemists');
    
insert into groups
    values(2, 'Criminals');
    
insert into member_groups
    values(1, 2);
    
insert into member_groups
    values(2, 1);
    
insert into member_groups
    values(2, 2);
    
select 
    groups.group_name,
    members.first_name,
    members.last_name
from groups 
join member_groups
on member_groups.group_id = groups.group_id
join members
on members.member_id = member_groups.member_id;



--5. Creates a sequence with a minimum value of 3 that increments by 1

create sequence members_seq minvalue 3
    increment by 1;



--6. Inserts a new row into the groups table using the nextval pseudocolumn

insert into groups (group_id)
values(members_seq.nextval);



--7. Alters the members table to add 2 columns. Additionally, the annual_dues column is defualted to '52.50'

alter table members
add annual_dues number(5,2);

alter table members
modify annual_dues default '52.50'; 

alter table members
add payment_date date;



--8. Creates a unique index on the member_groups table to ensure each row is unique

create unique index ux_members_groups on
    member_groups (member_id, group_id);


PAGE 372

--1. Creates a view named open_items that returns 4 columns from 2 joined tables

create view open_items as
select v.vendor_name, i.invoice_number, i.invoice_total, (i.invoice_total - i.payment_total - i.credit_total) as balance_due
from vendors v
join invoices i
on v.vendor_id = i.vendor_id
where (i.invoice_total - i.payment_total - i.credit_total) > 0
order by vendor_name;



--2. Selects all entries from the open_items with an outstanding balance of $1,000 or more

select *
from open_items
where balance_due > 1000;



--3. Creates a view that returns vendor name, open item count, and the open item total amount

create view open_items_summary as
select 
    v.vendor_name,
    sum(case when i.invoice_total - i.payment_total - i.credit_total > 0
    then 1 
    else 0
    end) as open_item_count,
    sum(i.invoice_total - i.payment_total - i.credit_total) as balance_due
from vendors v
join invoices i
on v.vendor_id = i.vendor_id
group by v.vendor_name
order by balance_due desc;



--4. Selects the first 5 rows in the view

select *
from open_items_summary
fetch first 5 rows only;



--5. Creates a view named vendor_address on the vendors table

create view vendor_address as
select
    vendor_id,
    vendor_address1,
    vendor_address2,
    vendor_city,
    vendor_state,
    vendor_zip_code
from vendors;



--6. Updates the vendor address columns for the vendor with an id of 4 

update vendors
set vendor_address2 = vendor_address1,
vendor_address1 = null
where vendor_id = 4;


PART TWO

1. Creates a view named mgs_customer_addresses that shows the shipping and billing addresses for each customer

create view mgs_customer_addresses as
select 
    c.customer_id,
    c.email_address,
    c.last_name,
    c.first_name,
    a.line1 as ship_line1,
    a.line2 as ship_line2,
    a.city as ship_city,
    a.STATE as ship_state,
    a.zip_code as ship_zip,
    b.line1,
    b.line2,
    b.city,
    b.STATE as bill_state,
    b.zip_code
from mgs_customers c
join mgs_addresses a
on c.shipping_address_id = a.address_id
join mgs_addresses b
on c.billing_address_id = b.address_id
order by last_name, first_name;



--2. Creates a view named mgs_order_item_products that returns columns from the Orders, Order_Items, and Products tables

create view mgs_order_item_products as
select
    mgs_orders.order_id,
    order_date,
    tax_amount,
    ship_date,
    item_price,
    discount_amount,
    item_price - discount_amount as final_price,
    quantity,
    (item_price - discount_amount) * quantity as item_total,
    product_name
from mgs_orders
join mgs_order_items
on mgs_orders.order_id = mgs_order_items.order_id
join mgs_products
on mgs_order_items.product_id = mgs_products.product_id;

--3. Creates a view named mgs_product_summary that uses the view created in exercise 2

create view mgs_product_summary as
select 
    product_name,
    count(*) as order_count,
    sum(item_total) as order_total
from mgs_order_item_products
group by product_name;                                                                                                                                                                                                                                                               
