with  cte as (select department_id,avg(salary) as avg_salary,count(*) no_of_emp,sum(salary) total_salary  from emp
group by department_id)

-- now we have to  not  include a  department  for comparing the average  salariess 
select 
e1.department_id,e1.avg_salary,sum(e2.no_of_emp) no_of_emp ,sum(e2.total_salary)  combined_income
from cte e1 inner join  cte e2 on  e1.department_id<>e2.department_id
group by e1.department_id,e1.avg_salary
order by e1.department_id
-----------------
with cte as 
(

select *
,AVG(salary) OVER (PARTITION BY department_id) as Avg_Department_Wise
,SUM(salary) OVER (PARTITION BY department_id) as Sum_Department_Wise
,SUM(salary) Over () as Total_Sum
--,COUNT(salary)
,Count(1) OVER () AS Total_Count
,COUNT(1) OVER (PARTITION BY DEPARTMENT_ID) as Count_Department_Wise
from emp
),cte2 as (

select distinct department_id,Avg_Department_Wise,(Total_sum - Sum_Department_Wise)/(Total_Count - Count_Department_Wise) as Result_Needed from cte
)
select  department_id ,Avg_Department_Wise from cte2 
where Result_Needed > Avg_Department_Wise

----------------------



with dept as (
select distinct department_id as depid
from emp
)
select depid
from dept,emp
group by depid
having avg(case when depid = department_id then salary else null end) < avg(case when depid != department_id then salary else null end)