select *
from page_visits
limit 10;

select *
from page_visits
where user_id = 10069
and utm_source = 'buzzfeed'
limit 10;

select *
from page_visits
where user_id = 10069;

select *
from page_visits
where user_id = 10329;

select user_id,
  max(timestamp) as last_touch_at
from page_visits
group by 1;

select user_id,
  max(timestamp) as last_touch_at
from page_visits
where user_id = 10069
group by 1;

with last_touch as (
    select user_id,
    max(timestamp) as 'last_touch_at'
    from page_visits
    group by user_id)
select lt.user_id,
   lt.last_touch_at,
   pv.utm_source
from last_touch as 'lt'
join page_visits as 'pv'
   on lt.user_id = pv.user_id
   and lt.last_touch_at = pv.timestamp
   limit 10;

with last_touch as (
    select user_id,
    max(timestamp) as 'last_touch_at'
    from page_visits
    group by user_id)
select lt.user_id,
   lt.last_touch_at,
   pv.utm_source
from last_touch as 'lt'
join page_visits as 'pv'
   on lt.user_id = pv.user_id
   and lt.last_touch_at = pv.timestamp
   where lt.user_id = 10069
   limit 10;