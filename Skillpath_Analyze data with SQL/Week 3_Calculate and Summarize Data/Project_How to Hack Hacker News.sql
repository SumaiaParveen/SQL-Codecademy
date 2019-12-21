select title, score
from hacker_news
order by score desc
limit 5;

select sum(score)
from hacker_news;

select user, sum(score) as total_score
from hacker_news
group by 1
having total_score > 200
order by 2 desc;

select 100 * (517 + 309 + 304 + 282) / 6366.0 as pct;

select user, count(*)
from hacker_news
where url = 'https://www.youtube.com/watch?v=dqw4w9wgxcq'
group by 1
order by 2 desc;

select case
   when url like '%github.com%' then 'github'
   when url like '%medium.com%' then 'medium'
   when url like '%nytimes.com%' then 'new york times'
   else 'na'
  end as 'source'
from hacker_news
limit 10;

select case
   when url like '%github.com%' then 'github'
   when url like '%medium.com%' then 'medium'
   when url like '%nytimes.com%' then 'new york times'
   else 'na'
  end as 'source', count(url)
from hacker_news
group by 1
limit 10;

select timestamp
from hacker_news
limit 10;

select timestamp,
   strftime('%h', timestamp)
from hacker_news
group by 1
limit 10;

select strftime('%h', timestamp) as hour, avg(score), count(url)
from hacker_news
group by 1
order by 1
limit 10;

select strftime('%h', timestamp) as hour, round(avg(score)) as avg_score, count(url) as stories
from hacker_news
where timestamp is not null
group by 1
order by 1
limit 10;