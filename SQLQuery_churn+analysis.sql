with cte as (
SELECT
    MONTH(order_date) AS month,
    Rank() OVER (PARTITION BY cust_id ORDER BY order_date) AS rn
FROM
    transactions  
	) 
select month,count(*) repeat_buyer from cte 
where  rn=2
group by month
select * from transactions
insert into transactions
values('10','1' ,'2022-01-15','170')


----Churn using self join with the given condition in the question we have to  find the  customer retention so we have to compare  from  previous month so here we  
-- decide to use the self   join to compare feb month with the previous month 

-- apply all the  given  condition on the  sql and see what joins  do 


select  * from 
transactions t1 left   join transactions t2 on t1.cust_id=t2.cust_id and DATEDIFF(month,t2.order_date,t1.order_date)=1

-- and then we will take the 

select month(t1.order_date)as month_date ,count(distinct t2.cust_id) 
from transactions t1 
left join transactions t2  on t1.cust_id=t2.cust_id  and DATEDIFF(MONTH,t2.order_date,t1.order_date)=1
group by month(t1.order_date)
