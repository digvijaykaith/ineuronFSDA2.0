use warehouse demo;
use database DEMO_DATABASE;

create or replace table dk_sales
(
order_id varchar(20),
order_date CHAR(20),
ship_date CHAR(20),
ship_mode varchar(60),
customer_name varchar(30),
segment varchar(50),
state varchar(50),
country varchar(50),
market varchar(50),
region varchar(50),
product_id varchar(30),
category varchar(50),
sub_category varchar(50),
product_name string,
sales number(10,0),
quantity float,
discount float,
profit float,
shipping_cost float,
order_prirority varchar(20),
year number(10));

select * from dk_sales;


CREATE OR REPLACE TABLE  dk_sales_COPY_DATA AS
SELECT * FROM dk_sales;
select * from dk_sales_COPY_DATA ;
--1st question--SET PRIMARY KEY.
alter table dk_sales_COPY_DATA 
add primary key (product_id);
describe table dk_sales_COPY_DATA;

 --2nd ques.. CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE.
 --order_date and SHIP_DATE  are already in date datatype as data was cleared in ms excel,
/* if data is not in date datatype then----*/

create or replace table dk_sales_COPY_DATA as
select *,
to_char(date(order_DATE,'MM-DD-YYYY'),'YYYY-MM-DD')AS ORDER_DAY
FROM dk_sales_COPY_DATA;
 
create or replace table dk_sales_COPY_DATA as
select *,
to_char(date(SHIP_DATE,'MM-DD-YYYY'),'YYYY-MM-DD')AS SHIP_DAY
FROM dk_sales_COPY_DATA;
 
---3.. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.
SELECT ORDER_id from dk_sales_COPY_DATA;

select split(order_id,'-') from dk_sales_COPY_DATA;

select split_part(order_id,'-','3') from dk_sales_COPY_DATA;

create or replace table dk_sales_COPY_DATA as
select *, split_part(order_id,'-','3') as order_no
from dk_sales_COPY_DATA;

select * from dk_sales_COPY_DATA;



 --.4---  FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FRO EVERY ORDER ID.
select *,
case when discount > 0 then 'yes'
else false
end as discount_status
from dk_sales_COPY_DATA ;
--5.  FIND OUT THE FINAL PROFIT AND PUT IT IN COLUMN FOR EVERY ORDER ID.--ALREADY THERE IN THE TABLE.
--6.  FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.

CREATE OR REPLACE TABLE dk_sales_COPY_DATA AS 
select *,
datediff(day,order_date,ship_date) AS PROCESS_DAYS
from dk_sales_COPY_DATA ;

SELECT * FROM dk_sales_COPY_DATA ; 

--7--FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3 
--DAYS MAKE 5,LESS OR EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,
--LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID.
CREATE OR REPLACE TABLE dk_sales_COPY_DATA AS 
select *,
case 
when  PROCESS_DAYS <=3  then '*****'
when PROCESS_DAYS between 4 and 6 then '****'
when PROCESS_DAYS  between 7 and 10 THEN '***'
else '**'
end as rating
from dk_sales_COPY_DATA ;

alter table  dk_sales_COPY_DATA
drop column RATING ;



