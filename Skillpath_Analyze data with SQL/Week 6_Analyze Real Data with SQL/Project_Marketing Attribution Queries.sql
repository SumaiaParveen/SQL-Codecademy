select count(distinct utm_campaign) 
from page_visits
limit 5;

select count(distinct utm_source) 
from page_visits
limit 5;

select distinct utm_campaign, utm_source
from page_visits
group by 1
limit 10;

select distinct page_name
from page_visits
limit 5;

 with first_touch as (
    select user_id,
        min(timestamp) as first_touch_at
    from page_visits
    group by user_id)
select pv.utm_campaign, count(ft.first_touch_at) as first_touch_count 
from first_touch ft
join page_visits pv
    on ft.user_id = pv.user_id
    and ft.first_touch_at = pv.timestamp
    group by 1
    order by 2 desc
  limit 5;
  
  
  with first_touch as (
   select user_id,
        min(timestamp) as first_touch_at
    from page_visits
    group by user_id),
ft_attr as (
  select ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  from first_touch ft
  join page_visits pv
    on ft.user_id = pv.user_id
    and ft.first_touch_at = pv.timestamp
)
select ft_attr.utm_source,
       ft_attr.utm_campaign,
       count(*)
from ft_attr
group by 1, 2
order by 3 desc;

with last_touch as (
   select user_id,
        max(timestamp) as last_touch_at
    from page_visits
    group by user_id),
ft_attr as (
  select ft.user_id,
         ft.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  from last_touch ft
  join page_visits pv
    on ft.user_id = pv.user_id
    and ft.last_touch_at = pv.timestamp
)
select ft_attr.utm_source,
       ft_attr.utm_campaign,
       count(*)
from ft_attr
group by 1, 2
order by 3 desc;

select count(distinct(user_id))
from page_visits
where page_name = '4 - purchase';

with last_touch as (
   select user_id,
        max(timestamp) as last_touch_at
    from page_visits
    group by user_id),
ft_attr as (
  select ft.user_id,
         ft.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
        pv.page_name
  from last_touch ft
  join page_visits pv
    on ft.user_id = pv.user_id
    and ft.last_touch_at = pv.timestamp
)
select ft_attr.utm_source,
       ft_attr.utm_campaign,
       ft_attr.page_name,
       count(*)     
from ft_attr
where page_name = '4 - purchase' 
group by 1, 2
order by 4 desc;

-- case 1

with first_touch as (
   select user_id,
        min(timestamp) as first_touch_at
    from page_visits
    group by user_id),
ft_attr as (
  select ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  from first_touch ft
  join page_visits pv
    on ft.user_id = pv.user_id
    and ft.first_touch_at = pv.timestamp
)
select ft_attr.utm_source,
       ft_attr.utm_campaign,
       count(*)
from ft_attr
group by 1, 2
order by 3 asc;

-- recommendation: google

--case 2

with last_touch as (
   select user_id,
        max(timestamp) as last_touch_at
    from page_visits
    group by user_id),
ft_attr as (
  select ft.user_id,
         ft.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
        pv.page_name
  from last_touch ft
  join page_visits pv
    on ft.user_id = pv.user_id
    and ft.last_touch_at = pv.timestamp
)
select ft_attr.utm_source,
       ft_attr.utm_campaign,
       ft_attr.page_name,
       count(*)     
from ft_attr
where page_name = '3 - checkout' 
group by 1, 2
order by 4 asc;

-- recommendation:
-- cool-tshirts-search	
-- ten-crazy-cool-tshirts-facts	
-- interview-with-cool-tshirts-founder
-- getting-to-know-cool-tshirts	
-- paid-search