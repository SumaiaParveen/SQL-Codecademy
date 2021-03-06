select * 
from purchases
order by id 
limit 10;

select * 
from gameplays 
order by id 
limit 10;

select date(created_at), round(sum(price), 2)
from purchases
group by 1
order by 1
limit 10;

select date(created_at), round(sum(price), 2) as daily_rev
from purchases
where refunded_at is null
group by 1
order by 1
limit 10;

select date(created_at), count(distinct user_id) as dau
from gameplays
group by 1
order by 1
limit 10;

select date(created_at), platform, count(distinct user_id) as dau
from gameplays
group by 1, 2
order by 1, 2
limit 10;

select date(created_at), round(sum(price) / count(distinct(user_id)), 2) as arppu
from purchases
where refunded_at is null
group by 1
order by 1
limit 10;

with daily_revenue as (
select date(created_at) as dt, round(sum(price), 2) as rev
from purchases
where refunded_at is null
group by 1
)
select * from daily_revenue order by dt;

with daily_revenue as (
select date(created_at) as dt, round(sum(price), 2) as rev
from purchases
where refunded_at is null
group by 1
), 
daily_players as (
select
date(created_at) as dt, count(distinct user_id) as players
from gameplays
group by 1
)
select * from daily_players order by dt
limit 10;

with daily_revenue as (
select date(created_at) as dt, round(sum(price), 2) as rev
from purchases
where refunded_at is null
group by 1
), 
daily_players as (
select
date(created_at) as dt, count(distinct user_id) as players
from gameplays
group by 1
)
select daily_revenue.dt, daily_revenue.rev / daily_players.players
from daily_revenue
join daily_players using (dt)
limit 10;

select date(created_at) as dt, user_id
from gameplays as g1
order by dt
limit 100;

select date(g1.created_at) as dt, g1.user_id
from gameplays as g1
join gameplays as g2 
on g1.user_id = g2.user_id
order by 1
limit 100;

select date(g1.created_at) as dt, g1.user_id, g2.user_id
from gameplays as g1
join gameplays as g2 
on g1.user_id = g2.user_id
and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
order by 1
limit 100;

select
  date(g1.created_at) as dt,
  count(distinct g1.user_id) as total_users,
  count(distinct g2.user_id) as retained_users
from gameplays as g1
left join gameplays as g2 on
  g1.user_id = g2.user_id
  and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;

select
  date(g1.created_at) as dt,
  round(100 * count(distinct g2.user_id) / 
        count(distinct g1.user_id)) as retention
from gameplays as g1
  left join gameplays as g2 on
  g1.user_id = g2.user_id
  and date(g1.created_at) = date(datetime(g2.created_at, '-1 day'))
group by 1
order by 1
limit 100;
                        