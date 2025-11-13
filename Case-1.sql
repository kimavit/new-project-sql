with t as (select dr_dat::timestamp + dr_tim as dt,*
from sales s), 
t2 as (
select * from t 
join bonuscheques b 
on t.dt = b.datetime
join shops s2 
on t.dr_apt = s2.id 
where date_part('year',t.dt) = 2022 and card like '2000%'
order by b.datetime) , 
t3 as (select name, count (distinct t2.dt) as npurch, max(dt) - min (dt) as lt, count(distinct t2.card) as nbuyers, sum(summ_with_disc) as rev
from t2
group by t2.name
order by rev desc), t4 as(
select name, nbuyers::numeric / npurch as lifetime, round (rev::numeric / nbuyers,3) as ARPU
from t3)
select *, arpu * lifetime as ltv
from t4

-- расчет производился в виде Lifetime = число покупок за период, фактически, арпу вышел средним чеком. Показатели 
-- считались с разбивкой по аптекам, дабы увидеть разницу, аналогичную контрасту при разбивке по странам в кейса Андрона на примере базы нордвинд