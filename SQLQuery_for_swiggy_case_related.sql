--- customer who have never ordered from the resturants
select name 
from users
where user_id not in(
select user_id from orders
where order_id is not null
)
--- average price of the  dish 
select m.f_id,Round(AVG(m.price),2) 'avg-price',f.f_name  
from menu m   join  food f on m.f_id=f.f_id
group by m.f_id ,f.f_name

---------- top  resturants in terms of the order
select TOP 1 COUNT(o.order_id) count_of_order,r.r_name
from orders o join resturants r on o.r_id=r.r_id
where MONTH(date)=6
group by o.r_id,r.r_name
order by COUNT(order_id) DESC
----------------resturants name where amount wass greater than a particular  amount in a month 
select SUM(amount) revenue ,r.r_name
from orders o 
join resturants r on o.r_id=r.r_id
where MONTH(date)=6 
group by o.r_id,r.r_name
having sum(amount)>400

------show  the order detaisl  for  ankit 

select o.order_id,r.r_name from orders o join resturants r on o.r_id=r.r_id
where user_id=4 and date>'2022-06-10' and  date <'2022-07-10'

---resturants  with the max repeat  rate 
select  r_id ,count(*) repeat_customer  from (
select  user_id,r_id,count(*) max_visit from orders o 
where order_id is not null
group by user_id,r_id
having count(*)>1
) t 
group by r_id
order by COUNT(*) desc


------------------------- customerss favorite food 
 select o.user_id,od.f_id,COUNT(*)  fav_food 
 from orders o join order_detail od on o.order_id=od.order_id
 where user_id is not null
 group by o.user_id,od.f_id
 order by user_id






