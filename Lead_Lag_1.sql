---  more than average question
with avg_cte as(
select subject,avg(marks)  as avg_marks
from students
group by subject)

select studentname ,marks 
from
students  s join avg_cte ac on s.subject= ac.subject
where marks>avg_marks
-------
select count( distinct case when marks>90 then studentid else null end )*1.0/count(distinct studentid)*100 as count_more_than_90 
from students

 
 -----  second highest and  second lowest for each subject 

 select subject ,
 max(case when rn_desc =2 then marks else null end) as second_highest,
 max(case when rn_asc=2 then marks else null end) as second_lowest
  from 
 (select subject,marks ,dense_rank()   over(partition by subject order by marks desc)  rn_desc,
 dense_rank()   over(partition by subject order by marks asc)  rn_asc
 from students) A
 group by subject


 ----
 select   *,
 case when  prev_test_marks>marks then 'dec' 
 when prev_test_marks<marks then 'inc'
 else null end as status 
 from 
 (
 select  *,lag(marks,1) over(partition by studentid order by testdate,subject) as prev_test_marks
 from students
 )  A 