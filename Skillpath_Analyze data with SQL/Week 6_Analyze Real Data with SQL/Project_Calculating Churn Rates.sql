select *
from subscriptions
limit 10;

select (select min(date(subscription_start))
from subscriptions) as start, (select max(date(subscription_start))
from subscriptions) as end;

select (select min(date(subscription_end))
from subscriptions) as start, (select max(date(subscription_end))
from subscriptions) as end;

with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
)
select *
from months;

with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
),
cross_join as
(select *
from subscriptions
cross join months)
select *
from cross_join
limit 10;

with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
),
cross_join as
(select *
from subscriptions
cross join months),
status as
(select id, first_day as month,
case
when (segment = 87
      and subscription_start < first_day) 
      or subscription_end is null
then 1
else 0
end as is_active_87,
case
when (segment = 30
      and subscription_start < first_day)
      or subscription_end is null
then 1
else 0
end as is_active_30
from cross_join)
select *
from status
group by 1
limit 10;

with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
),
cross_join as
(select *
from subscriptions
cross join months),
status as
(select id, first_day as month,
case
when (segment = 87
      and subscription_start < first_day) 
      or subscription_end is null
then 1
else 0
end as is_active_87,
case
when (segment = 30
      and subscription_start < first_day)
      or subscription_end is null
then 1
else 0
end as is_active_30,
case
when subscription_end between first_day and last_day and segment = 87
then 1
else 0
end as is_canceled_87,
case
when subscription_end between first_day and last_day and segment = 30
then 1
else 0
end as is_canceled_30
from cross_join)
select *
from status
limit 100;


with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
),
cross_join as
(select *
from subscriptions
cross join months),
status as
(select id, first_day as month,
case
when (segment = 87
      and subscription_start < first_day) 
      or subscription_end is null
then 1
else 0
end as is_active_87,
case
when (segment = 30
      and subscription_start < first_day)
      or subscription_end is null
then 1
else 0
end as is_active_30,
case
when subscription_end between first_day and last_day and segment = 87
then 1
else 0
end as is_canceled_87,
case
when subscription_end between first_day and last_day and segment = 30
then 1
else 0
end as is_canceled_30
from cross_join),
status_aggregate as
(select
month,
sum(is_active_87) as sum_active_87,
sum(is_active_30) as sum_active_30,
sum(is_canceled_87) as sum_canceled_87,
sum(is_canceled_30) as sum_canceled_30
from status
group by month)
select *
from status_aggregate
limit 5;

with months as
(select
'2017-01-01' as first_day,
'2017-01-31' as last_day
union
select
'2017-02-01' as first_day,
'2017-02-28' as last_day
union
select
'2017-03-01' as first_day,
'2017-03-31' as last_day
),
cross_join as
(select *
from subscriptions
cross join months),
status as
(select id, first_day as month,
case
when (segment = 87
      and subscription_start < first_day) 
      or subscription_end is null
then 1
else 0
end as is_active_87,
case
when (segment = 30
      and subscription_start < first_day)
      or subscription_end is null
then 1
else 0
end as is_active_30,
case
when subscription_end between first_day and last_day and segment = 87
then 1
else 0
end as is_canceled_87,
case
when subscription_end between first_day and last_day and segment = 30
then 1
else 0
end as is_canceled_30
from cross_join),
status_aggregate as
(select
month,
sum(is_active_87) as sum_active_87,
sum(is_active_30) as sum_active_30,
sum(is_canceled_87) as sum_canceled_87,
sum(is_canceled_30) as sum_canceled_30
from status
group by month)
select
month,
round(1.0 * sum_canceled_87/sum_active_87, 3) as churn_rate_87,
round(1.0 * sum_canceled_30/sum_active_30, 3) as churn_rate_30
from status_aggregate;