select premium_users.user_id, plans.description
from premium_users
join plans
on plans.id = premium_users.membership_plan_id
limit 10;

select plays.user_id, plays.play_date, songs.title
from plays
join songs
on songs.id = plays.song_id
limit 10;

select users.id
from users
left join premium_users
on premium_users.user_id  = users.id
where premium_users.user_id is null;

with january as (
  select *
  from plays
  where strftime("%m", play_date) = '01'
),
february as (
  select *
  from plays
  where strftime("%m", play_date) = '02'

)
select january.user_id
from january
left join february 
on february.user_id = january.user_id
where february.user_id is null;

select user_id, purchase_date, cancel_date, months
from premium_users 
cross join months;

select premium_users.user_id,
  months.months,
  case
  when (premium_users.purchase_date <= months.months)
      and
       (premium_users.cancel_date >= months.months
      or
      premium_users.cancel_date is null)
    then 'active'
    else 'not_active'
  end as 'status'
from premium_users
cross join months
limit 10;
  
select *
from songs
union
select *
from bonus_songs
limit 10;

select '2017-01-01' as month
union
select '2017-02-01' as month
union
select '2017-03-01' as month;

with play_count as (select song_id, count(*) as 'times_played'
from plays
group by 1) 
select songs.title, songs.artist, play_count.times_played
from songs
join play_count
on play_count.song_id = songs.id
limit 10;