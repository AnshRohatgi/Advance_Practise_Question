with cte as (
select department_id as d_id,avg(salary)  avg_salary,count(*) no_of_emp from emp
group by department_id),
 t2 as(
select c1.d_id,c1.avg_salary,sum(c2.avg_salary*c2.no_of_emp) as total_other_dep_sal,SUM(c2.no_of_emp) as total_other_dep_no,
sum(c2.avg_salary*c2.no_of_emp)/SUM(c2.no_of_emp) avg_other_dept
from cte c1 
join cte c2 on c1.d_id<>c2.d_id
group by c1.d_id,c1.avg_salary )

select d_id ,avg_salary,avg_other_dept from t2 where avg_salary<avg_other_dept



