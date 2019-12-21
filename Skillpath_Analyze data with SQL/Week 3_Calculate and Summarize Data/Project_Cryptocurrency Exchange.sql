select *
from transactions;

select sum(money_in)
from transactions;

select sum(money_out)
from transactions;

select count(money_in)
from transactions;

select count(money_in)
from transactions
where currency = 'bit';

select max(money_in)
from transactions;

select max(money_out)
from transactions;

select avg(money_in)
from transactions
where currency = 'eth';

select date, avg(money_in), avg(money_out)
from transactions
group by 1
order by 1 desc
limit 10;

select date, round(avg(money_in), 2) as avg_income, round(avg(money_out), 2) as avg_expense
from transactions
group by 1
order by 1 desc
limit 10;