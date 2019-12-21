select * from movies;

select name, genre 
from movies;

select name, genre, year 
from movies;

select name as 'titles'
from movies;

select imdb_rating as 'imdb'
from movies;

select distinct genre 
from movies;

select distinct year 
from movies;

select * 
from movies 
where imdb_rating < 5;

select * 
from movies 
where year > 2014;

select * 
from movies
where name like 'se_en';

select * 
from movies
where name like 'a%';

select * 
from movies 
where name like '%man%';

select * 
from movies
where name like 'the %';

select name
from movies 
where imdb_rating is not null;

select name
from movies 
where imdb_rating is null;

select *
from movies
where year between 1990 and 1999;

select *
from movies
where name between 'a' and 'j';

select *
from movies
where name between 'd' and 'g';

select *
from movies
where year between 1970 and 1979;

select * 
from movies
where year between 1990 and 1999
   and genre = 'romance';

select *
from movies
where year between 1970 and 1979
  and imdb_rating > 8;

select *
from movies
where year < 1985
and genre = 'horror';

select *
from movies
where year > 2014
   or genre = 'action';

select *
from movies
where genre = 'romance'
   or genre = 'comedy';

select *
from movies
order by name;

select *
from movies
where imdb_rating > 8
order by year desc;

select name, year
from movies
order by name;

select name, year, imdb_rating
from movies
order by imdb_rating desc;

select *
from movies
limit 10;

select *
from movies
order by imdb_rating desc
limit 3;

select name,
 case
  when imdb_rating > 8 then 'fantastic'
  when imdb_rating > 6 then 'poorly received'
  else 'avoid at all costs'
 end as 'review'
from movies;

select name,
 case
  when genre = 'romance' then 'chill'
  when genre = 'comedy' then 'chill'
  else 'intense'
 end as 'mood'
from movies;