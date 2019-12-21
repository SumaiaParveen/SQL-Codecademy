select *
from startups;

select count(*)
from startups;

select sum(valuation)
from startups;

select name, max(raised)
from startups;

select name, max(raised)
from startups
where stage = 'seed';

select name, min(founded)
from startups;

select category, avg(valuation)
from startups
group by category;

select category, round(avg(valuation), 2)
from startups
group by category;

select category, round(avg(valuation), 2) as 'avg_value'
from startups
group by 1
order by 2 desc;

select distinct category, count(*)
from startups
group by 1;

select distinct category, count(*) as 'company'
from startups
group by 1
having company > 3
order by company desc;

select location, round(avg(employees), 2) as 'size'
from startups
group by 1
order by 2 desc;

select location, round(avg(employees), 2) as 'size'
from startups
group by 1
having size > 500.0
order by 2 desc;