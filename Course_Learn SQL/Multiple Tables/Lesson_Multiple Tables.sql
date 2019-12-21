select *
from orders
limit 5;

select *
from subscriptions
limit 5;

select * 
from customers
limit 5;

select *
from orders
join customers
  on orders.customer_id = customers.customer_id;

select orders.order_id,
   customers.customer_name
from orders
join customers
  on orders.customer_id = customers.customer_id;

select *
from orders
join subscriptions
on orders.subscription_id = subscriptions.subscription_id;

select *
from orders
join subscriptions
on orders.subscription_id = subscriptions.subscription_id
where description = 'fashion magazine';

select count(*)
from newspaper;

select count(*)
from online;

select count(*)
from newspaper
join online
  on newspaper.id = online.id;

select *
from newspaper
left join online
  on newspaper.id = online.id;
  
select *
from newspaper
left join online
on newspaper.id = online.id
where online.id is null;

select *
from classes
join students
  on classes.id = students.class_id;

select count(*)
from newspaper
where start_month <= 3 
  and end_month >= 3;
  
  select *
from newspaper
cross join months;

select *
from newspaper
cross join months
where start_month <= month 
  and end_month >= month;
  
select month,
   count(*) as 'subscribers'
from newspaper
cross join months
where start_month <= month 
   and end_month >= month
group by month;

select * 
from newspaper 
union 
select * 
from online;

with previous_query as (
   select customer_id,
      count(subscription_id) as 'subscriptions'
   from orders
   group by customer_id
)
select customers.customer_name, 
   previous_query.subscriptions
from previous_query
join customers
  on previous_query.customer_id = customers.customer_id;