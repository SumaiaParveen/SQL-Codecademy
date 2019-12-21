 select year, number
from babies
where name  = 'Lillian';

select distinct name
from babies
where name like 'S%'
limit 20;

select distinct name, gender, number
from babies
where year = '1880'
order by 3 desc
limit 10;

select *
 from nomnom
 where cuisine = 'Japanese'
 and price = '$$';

select *
from nomnom 
where name like '%noodle%';

select *
from nomnom 
where health is null;

SELECT title, publisher
FROM news
ORDER BY title ASC;

select *
from news
where title like '%bitcoin%';

select *
from news
where category = 'b'
order by timestamp desc
limit 20;