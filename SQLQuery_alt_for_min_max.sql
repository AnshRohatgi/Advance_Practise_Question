with cte as (
select dep_id, min(salary) min_salary,max(salary) max_salary 
from Employee
group by dep_id
 )
select e.dep_id
,max(case 
when salary=max_salary then emp_name else null end )as max_salary_man
,max(case 
when salary=min_salary then emp_name else null end) as min_salary_min
from cte ct
join employee e on ct.dep_id=e.dep_id
group by e.dep_id