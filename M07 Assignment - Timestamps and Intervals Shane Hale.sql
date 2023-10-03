/* 1. Create a table named Timestamp_Values in the EX schema that contains four columns: 

timestamp_id as a NUMBER data type; 
timestamp_value as a TIMESTAMP(6) data type; 
timestamp_wltz_value as a TIMESTAMP WITH LOCAL TIME ZONE data type; 
and timestamp_wtz_value as a TIMESTAMP WITH TIME ZONE data type. 

Next, insert a row into this table with 1 for the id column, 
LOCALTIMESTAMP(3) for the second column, 
and CURRENT_TIMESTAMP(3) for the last two columns. 

Finally, write a SELECT statement that selects this data and review the data that’s returned.
*/

create table timestamp_values
    (
    timestamp_id            number(38,0),
    timestamp_value         timestamp(6),
    timestamp_wltz_value    timestamp with local time zone,
    timestamp_wtz_value     timestamp with time zone
    );

insert into timestamp_values
values(1, localtimestamp(3), current_timestamp(3), current_timestamp(3));

select
    *
from
    timestamp_values;



/* 2. First, change the date format for the current session so it shows the time in 24-hour format. 
Second, write a SELECT statement that retrieves the four columns of the one row in the Timestamp_Values table that you created in exercise 1. 
Third, change the time zone for the session to MST. 
Fourth, insert a row just like the one you inserted in exercise 1 but with an id of 2. 
Fifth, run the SELECT statement again to review the differences in the two rows.
*/

select
    timestamp_id,
    to_char(timestamp_value, 'DD-MON-YY HH24:MM:SS.FF6')as conv_time,
    new_time(timestamp_wltz_value, 'EST', 'MST') as mst_time,
    timestamp_wtz_value
from
    timestamp_values;
    
insert into timestamp_values
values(2, localtimestamp(3), new_time(current_timestamp(3), 'EST', 'MST'), current_timestamp(3));

select
    *
from
    timestamp_values;



/* 3. Keep the date format for the current session as described in exercise 2. 
Then, write a SELECT statement that retrieves four columns from the Timestamp_Values table of exercises 1 and 2: 
(1) timestamp_id, 
(2) timestamp_value, and 
(3) timestamp_value after it has been converted to Central Standard Time (CST) with cst_time as the column name.
*/

select
    timestamp_id,
    to_char(timestamp_value, 'DD-MON-YY HH24:MM:SS.FF6')as conv_time,
    new_time(timestamp_wltz_value, 'EST', 'CST') as cst_time,
    timestamp_wtz_value
from
    timestamp_values;


/* 4. Keep the date format for the current session as described in exercise 2. 
Then, write a SELECT statement that retrieves the invoice_number and invoice_date columns from the Invoices table in the AP schema, 
followed by a column named days_old that uses an interval function to retrieve 
the number of days, hours, and seconds that have elapsed between the invoice date and the current date. 

Sort the rows by the days_old value and only retrieve rows when the days_old value is greater than 30.
*/

select
    invoice_number,
    invoice_date,
    systimestamp - invoice_date as days_old
from
    invoices
where
    (systimestamp - invoice_date) > interval '30' DAY(2)
order by
    days_old;