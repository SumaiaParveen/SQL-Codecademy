select *
from fake_apps;

select count(*) 
from fake_apps;

select count(*) 
from fake_apps
where price  = 0.0;

select sum(downloads)
from fake_apps;

select min(downloads)
from fake_apps;

select max(price)
from fake_apps;

select avg(downloads)
from fake_apps;

select avg(price)
from fake_apps;

select round(price, 0)
from fake_apps;

select round(price, 0)
from fake_apps;

select round (avg(price), 2)
from fake_apps;

select year,
   avg(imdb_rating)
from movies
group by year
order by year;

select price, count(*) 
from fake_apps
group by price;

select price, count(*) 
from fake_apps
where downloads > 20000
group by price;

select category, sum(downloads) 
from fake_apps
group by category;

select round(imdb_rating),
   count(name)
from movies
group by round(imdb_rating)
order by round(imdb_rating);

select round(imdb_rating),
   count(name)
from movies
group by 1
order by 1;

select category, 
   price,
   avg(downloads)
from fake_apps
group by category, price;

select category, 
   price,
   avg(downloads)
from fake_apps
group by 1, 2;

select year,
   genre,
   count(name)
from movies
group by 1, 2
having count(name) > 10;

select price, round(avg(downloads)), count(*)
from fake_apps
group by price
having count(*) > 10;