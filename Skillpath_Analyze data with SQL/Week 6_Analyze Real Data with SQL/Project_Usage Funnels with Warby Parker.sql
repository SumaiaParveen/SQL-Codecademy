select *
from survey
limit 10;
 
select question, count(distinct user_id) as 'response_count'
from survey
group by 1
order by 2 desc
limit 10;

-- 3)

select distinct user_id, count(response) as response_count
from survey
where response is not null
group by 1
having response_count > 4
limit 10;

with user_response_count as (
select distinct user_id, count(response) as response_count
from survey
where response is not null
group by 1
having response_count > 4)
select count(distinct user_id) as all_answer_users
from user_response_count;

select count(distinct user_id) as total_users
from survey;

select (270./500);

select question, count(response), count(response)/5 as 'rate as %'
from survey 
group by 1;

select *
from quiz
limit 5;

select *
from home_try_on
limit 5;

select *
from purchase
limit 5;

select q.user_id,
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase'
from quiz as 'q'
left join home_try_on as 'h'
on q.user_id  = h.user_id 
left join purchase as 'p'
on q.user_id  = p.user_id 
group by 1
limit 10;

with funnel as
(select q.user_id,
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase'
from quiz as 'q'
left join home_try_on as 'h'
on q.user_id  = h.user_id 
left join purchase as 'p'
on q.user_id  = p.user_id 
group by 1
limit 10)
select number_of_pairs, sum(is_purchase)
from funnel
group by 1
limit 5;