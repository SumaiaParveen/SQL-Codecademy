select 100./2000;
 
select 450./3000;

select 1.0 * 
(
  select count(*)
  from subscriptions
  where subscription_start < '2017-01-01'
  and (
    subscription_end
    between '2017-01-01'
    and '2017-01-31'
  )
) / (
  select count(*) 
  from subscriptions 
  where subscription_start < '2017-01-01'
  and (
    (subscription_end >= '2017-01-01')
    or (subscription_end is null)
  )
) 
as result;

select *
from subscriptions
where subscription_start < '2017-01-01'
and (
(subscription_end >= '2017-01-01')
or (subscription_end is null)
)
limit 5;

with enrollments as
(select *
from subscriptions
where subscription_start < '2017-01-01'
and (
(subscription_end >= '2017-01-01')
or (subscription_end is null)
)), status as 
(select
case
when (subscription_end > '2017-01-31')
or (subscription_end is null) then 0
else 1
end as is_canceled,
case
when subscription_start < '2017-01-01'
and (
(subscription_end >= '2017-01-01')
or (subscription_end is null)
) then 1
else 0
end as is_active
from enrollments
)
select *
from status
limit 5;

with enrollments as
(select *
from subscriptions
where subscription_start < '2017-01-01'
and (
(subscription_end >= '2017-01-01')
or (subscription_end is null)
)), status as 
(select
case
when (subscription_end > '2017-01-31')
or (subscription_end is null) then 0
else 1
end as is_canceled,
case
when subscription_start < '2017-01-01'
and (
(subscription_end >= '2017-01-01')
or (subscription_end is null)
) then 1
else 0
end as is_active
from enrollments
)
select 1.0 * sum(is_canceled) / sum(is_active) as churn
from status;

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
  when (subscription_start < first_day)
    and (
      subscription_end > first_day
      or subscription_end is null
    ) then 1
  else 0
end as is_active
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
  when (subscription_start < first_day)
    and (
      subscription_end > first_day
      or subscription_end is null
    ) then 1
  else 0
end as is_active,
case 
  when subscription_end between first_day and last_day then 1
  else 0
end as is_canceled
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
  when (subscription_start < first_day)
    and (
      subscription_end > first_day
      or subscription_end is null
    ) then 1
  else 0
end as is_active,
case 
  when subscription_end between first_day and last_day then 1
  else 0
end as is_canceled
from cross_join),
status_aggregate as
(select
  month,
  sum(is_active) as active,
  sum(is_canceled) as canceled
from status
group by month)
select *
from status_aggregate;

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
  when (subscription_start < first_day)
    and (
      subscription_end > first_day
      or subscription_end is null
    ) then 1
  else 0
end as is_active,
case 
  when subscription_end between first_day and last_day then 1
  else 0
end as is_canceled
from cross_join),
status_aggregate as
(select
  month,
  sum(is_active) as active,
  sum(is_canceled) as canceled
from status
group by month)
select
  month,
  1.0 * canceled/active as churn_rate
from status_aggregate;