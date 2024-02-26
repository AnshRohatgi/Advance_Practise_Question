with cte as
(
select customer_id, order_date,row_number() over(partition by customer_id order by 
order_date asc) as rn from customer_orders
)
select order_date ,sum(case when rn =1 then 1 else 0 end) as new_customer ,
sum(case when rn>1 then 1 else 0 end ) as repeated_customer
from cte
group by  order_date


---- we  can also do  the same by the comparing the min 

  with first_visit_cte as 
  (select customer_id ,min(order_date) as min_date_of_order
from customer_orders
group by customer_id)

visit_flag as (
select co.* ,fvc.min_date_of_order,
case when  co.order_date=fvc.min_date_of_order then 1 else 0 end as  first_time ,
case when co.order_date<>fvc.min_date_of_order then 1 else 0 end as  repeat_time
from customer_orders co inner  join 
first_visit_cte fvc on   co.customer_id=fvc.customer_id
order by order_id
)
select *

from visit_flag


--select order_date, sum(case when rn=1 then 1 else 0 end) as new_customers,
--sum(case when rn>1 then 1 else 0 end) as repeat_customers from cte
--group by order_date;