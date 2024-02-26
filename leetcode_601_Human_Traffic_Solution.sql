with grp_num as (
select *,
row_number() over(order by visit_date)  as rn,
id-row_number() over(order by visit_date) as grp 
from Stadium
where people>100)
select id,visit_date,people
from grp_num 
where  grp in 
(
select  grp  from 
grp_num
group by  grp 
having count(1)>=3
)

