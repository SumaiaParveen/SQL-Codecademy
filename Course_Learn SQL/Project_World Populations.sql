select count(*)
from countries
where continent  = 'africa';

select sum(population) as pop_oceania_tot
from population_years
join countries
on countries.id = population_years.country_id
where continent  = 'oceania'
and year = 2005;

select avg(population) as pop_sa_avg
from population_years
join countries
on countries.id = population_years.country_id
where continent  = 'south america'
and year = 2003;

select name, population
from population_years
join countries
on countries.id = population_years.country_id
where year = 2007
and population is not null
order by 2 asc
limit 1;

with poland_pop as 
(select name, year, population
from population_years
join countries
on countries.id = population_years.country_id
where name  = 'poland')
select avg(population) as avg_pop_poland_
from poland_pop;

select count(distinct(name))
from countries
where name like '%the%';

select continent, sum(population)
from population_years
join countries
on countries.id = population_years.country_id
where year = 2010
and population is not null
group by 1
order by 2 desc;