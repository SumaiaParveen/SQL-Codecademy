select count(email)
from users
where email like '%.com';

select first_name, count(first_name)
from users
group by 1
order by 2 desc;

select round(watch_duration_in_minutes), count(1)
from watch_history
group by 1
order by 1;

select user_id, sum(amount)
from payments
where status = 'paid'
group by 1
order by 2 desc;

select user_id, sum(watch_duration_in_minutes)
from watch_history
group by 1
having sum(watch_duration_in_minutes) > 400;

select round(sum(watch_duration_in_minutes))
from watch_history;

select pay_date, sum(amount)
from payments
where status = 'paid'
group by 1
order by 2 desc;

select avg(amount)
from payments
where status = 'paid';

select max(watch_duration_in_minutes) as longest,
       min(watch_duration_in_minutes) as shortest
from watch_history;