select * 
from survey_responses
limit 10;

select question_text, count(question_text) as responses
from survey_responses
where question_text is not null
group by 1
order by 2 desc
limit 10;

select *
from onboarding_modals
limit 10;

select modal_text, count(user_id) as responses
from onboarding_modals
group by 1
order by 2 desc;

select modal_text,
  count(distinct case
    when ab_group = 'control' then user_id
    end) as 'control_clicks'
from onboarding_modals
group by 1
order by 1;

select modal_text,
    count(distinct case
    when ab_group = 'control' then user_id
    end) as 'control_clicks',
    count(distinct case
    when ab_group = 'variant' then user_id
    end) as 'variant_clicks'
from onboarding_modals
group by 1
order by 1;

select *
from browse
limit 5;

select *
from checkout
limit 5;

select *
from purchase
limit 5;

select * 
from browse as 'b'
left join checkout as 'c'
on c.user_id = b.user_id
left join purchase as 'p'
on p.user_id = c.user_id
limit 50;

select distinct b.browse_date, b.user_id, 
c.user_id is not null as 'is_checkout', 
p.user_id is not null as 'is_purchase'
from browse as 'b'
left join checkout as 'c'
on c.user_id = b.user_id
left join purchase as 'p'
on p.user_id = c.user_id
limit 50;

with funnels as (
  select distinct b.browse_date,
     b.user_id,
     c.user_id is not null as 'is_checkout',
     p.user_id is not null as 'is_purchase'
  from browse as 'b'
  left join checkout as 'c'
    on c.user_id = b.user_id
  left join purchase as 'p'
    on p.user_id = c.user_id)
select count(*)
from funnels;

with funnels as (
  select distinct b.browse_date,
     b.user_id,
     c.user_id is not null as 'is_checkout',
     p.user_id is not null as 'is_purchase'
  from browse as 'b'
  left join checkout as 'c'
    on c.user_id = b.user_id
  left join purchase as 'p'
    on p.user_id = c.user_id)
select count(*), sum(is_checkout) as 'num_checkout'
from funnels;

with funnels as (
  select distinct b.browse_date,
     b.user_id,
     c.user_id is not null as 'is_checkout',
     p.user_id is not null as 'is_purchase'
  from browse as 'b'
  left join checkout as 'c'
    on c.user_id = b.user_id
  left join purchase as 'p'
    on p.user_id = c.user_id)
select count(*), sum(is_checkout) as 'num_checkout',
sum(is_purchase) as 'num_purchase'
from funnels;

with funnels as (
  select distinct b.browse_date,
     b.user_id,
     c.user_id is not null as 'is_checkout',
     p.user_id is not null as 'is_purchase'
  from browse as 'b'
  left join checkout as 'c'
    on c.user_id = b.user_id
  left join purchase as 'p'
    on p.user_id = c.user_id)
select count(*), sum(is_checkout) as 'num_checkout',
sum(is_purchase) as 'num_purchase', 1.0 * sum(is_checkout) / count(user_id) as '%(browse-checkout)',
1.0 * sum(is_purchase) / sum(is_checkout) as '%(checkout-purchase)'
from funnels;


with funnels as (
  select distinct b.browse_date,
     b.user_id,
     c.user_id is not null as 'is_checkout',
     p.user_id is not null as 'is_purchase'
  from browse as 'b'
  left join checkout as 'c'
    on c.user_id = b.user_id
  left join purchase as 'p'
    on p.user_id = c.user_id)
select browse_date, count(*) as 'num_browse',
   sum(is_checkout) as 'num_checkout',
   sum(is_purchase) as 'num_purchase',
   round(1.0 * sum(is_checkout) / count(user_id), 2) as 'browse_to_checkout',
   round(1.0 * sum(is_purchase) / sum(is_checkout), 2) as 'checkout_to_purchase'
from funnels
group by browse_date
order by browse_date;