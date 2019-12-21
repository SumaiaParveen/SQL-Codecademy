create table friends (
   id integer,
   name text,
   birthday date
);

insert into friends (id, name, birthday) 
values (1, 'jane doe', '1990-05-30');

insert into friends (id, name, birthday) 
values (1, 'julian fortin', '1990-05-29');

insert into friends (id, name, birthday) 
values (1, 'kristina nelson', '1990-05-28');

update friends
set name = 'jane smith'
where id = 1;

alter table friends 
add column email text;

update friends
set email = 'jane@codecademy.com'
where id = 1;

delete from friends
where id = 1;

select * 
from friends;