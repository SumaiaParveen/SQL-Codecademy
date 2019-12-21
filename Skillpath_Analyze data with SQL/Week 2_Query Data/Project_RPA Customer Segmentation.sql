select *
from users
limit 10;

select email, birthday
from users
where birthday between '1980-01-01' and '1989-12-31'
limit 10;

select email, created_at
from users
where created_at < '2017-05-01'
limit 10;

select email
from users
where test  = 'bears'
limit 10;

select email
from users
where campaign like 'BBB%'
limit 10;

select email
from users
where campaign like '%-2'
limit 10;

select email
from users
where campaign is not null
and test is not null
limit 10;