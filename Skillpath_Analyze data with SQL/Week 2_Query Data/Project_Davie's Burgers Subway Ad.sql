select *
from orders
limit 10;

select distinct order_date
from orders
order by 1 desc
limit 10;

select special_instructions
from orders
limit 20;

select special_instructions
from orders
where special_instructions is not null
limit 20;

select special_instructions
from orders
where special_instructions is not null
order by 1 asc
limit 20;

select special_instructions
from orders
where special_instructions like '%sauce%'
order by 1 asc;

select special_instructions
from orders
where special_instructions like '%door%'
order by 1 asc;

select special_instructions
from orders
where special_instructions like '%box%'
order by 1 asc;

select id as '#', special_instructions as 'notes'
from orders
where special_instructions like '%box%'
order by 1 asc;