select *
from met
limit 10;

select count(*)
from met;

select count(*)
from met
where category like '%celery%';

select min(date) as date, title, medium
from met;

select country, count(country) as pieces
from met
where country is not null
group by 1
order by 2 desc
limit 10;

select category, count(category) as pieces
from met
where category is not null
group by 1
having pieces > 100
order by 2 desc;

select medium, count(*)
from met
where medium like '%gold%'
or medium like '%silver%'
group by 1
order by 2 desc
limit 10;