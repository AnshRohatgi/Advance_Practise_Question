---For each date we have to find the 
-- total users
--total amount  spend using mobile  onnly
-- total  amount spend using desktop only
--  total amoumt spend using mobile and desktop both


with all_spend  as(
select spend_date,user_id,sum(amount) as amount,max(platform) as platform
from spending 
group  by spend_date,user_id 
having count(distinct(platform))=1
union all
select spend_date,user_id,sum(amount) as amount,'both' as platform
from spending 
group  by spend_date,user_id 
having count(distinct(platform))=2)
select spend_date,platform,sum(amount) as total_amount,count(distinct(user_id))
from all_spend 
group by spend_date,platform
order by  spend_date,platform desc


--------
WITH CTE1 AS(
SELECT spend_date, SUM(amount) as Amount, COUNT(DISTINCT user_id) as Users_Count,
CASE 
    WHEN COUNT(user_id)>1 THEN 'Both' ELSE MAX(platform) END AS PlatformName
FROM spending
GROUP BY user_id, spend_date
UNION
SELECT spend_date, 0 as Amount, 0 as Users_Count,'Both' AS PlatformName
FROM spending
GROUP BY user_id, spend_date)
SELECT spend_date, SUM(Amount) as Amount, SUM(Users_Count) AS UsersCount, PlatformName
FROM CTE1
GROUP BY spend_date, PlatformName
order by spend_date
