select * from trips;

select * from riders;

select * from cars;

is the result useful?
select riders.first,
   riders.last,
   cars.model
from riders, cars;

select *
from trips
left join riders 
on trips.rider_id = riders.id;

select trips.date, 
   trips.pickup, 
   trips.dropoff, 
   trips.type, 
   trips.cost,
   riders.first, 
   riders.last,
   riders.username
from trips
left join riders 
on trips.rider_id = riders.id;

select *
from trips
join cars 
on trips.car_id = cars.id;

select *
from riders
union
select *
from riders2;

select avg(cost)
from trips;

select *
from riders
where total_trips < 500
union
select *
from riders2
where total_trips < 500;

select *
from cars
where status = 'active';

select *
from cars
order by trips_completed desc
limit 2;