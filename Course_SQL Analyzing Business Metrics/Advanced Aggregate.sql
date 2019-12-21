select *
from orders
order by id
limit 10;

select *
from order_items
order by id
limit 10;

select date(ordered_at) as date
from orders
order by 1
limit 10;

select date(ordered_at) as date, count(distinct date(ordered_at)) as orders
from orders
group by 1
limit 10;

select date(ordered_at) as date, round(sum(amount_paid), 2) as revenue
from orders
    join order_items 
    on orders.id = order_items.order_id
group by 1
order by 1
limit 10;

select date(ordered_at) as date, round(sum(amount_paid), 2) as revenue
from orders
    join order_items on 
      orders.id = order_items.order_id
where name = 'kale-smoothie'
group by 1
order by 1
limit 10;

select name, round(sum(amount_paid), 2) as total_revenue
from order_items
group by name
order by 2 desc;

select name, round(sum(amount_paid) /
  (select sum(amount_paid) from order_items) * 100.0, 2) as pct
from order_items
group by 1
order by 2 desc;

select name,
  case name
    when 'kale-smoothie'    then 'smoothie'
    when 'banana-smoothie'  then 'smoothie'
    when 'orange-juice'     then 'drink'
    when 'soda'             then 'drink'
    when 'blt'              then 'sandwich'
    when 'grilled-cheese'   then 'sandwich'
    when 'tikka-masala'     then 'dinner'
    when 'chicken-parm'     then 'dinner'
     else 'other'
  end as category
from order_items
order by id
limit 10;

select
  case name
    when 'kale-smoothie'    then 'smoothie'
    when 'banana-smoothie'  then 'smoothie'
    when 'orange-juice'     then 'drink'
    when 'soda'             then 'drink'
    when 'blt'              then 'sandwich'
    when 'grilled-cheese'   then 'sandwich'
    when 'tikka-masala'     then 'dinner'
    when 'chicken-parm'     then 'dinner'
    else 'other'
  end as category, round(1.0 * sum(amount_paid) /
    (select sum(amount_paid) from order_items) * 100, 2) as pct
from order_items
group by 1
order by 2 desc;

select name, count(distinct(order_id)) as orders
from order_items
group by 1
order by 1
limit 10;

select name, round(1.0 * count(distinct order_id) /
  count(distinct delivered_to), 2) as reorder_rate
from order_items
  join orders on
    orders.id = order_items.order_id
group by 1
order by 2 desc;