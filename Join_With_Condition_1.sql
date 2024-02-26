with  final_cte as (
select t1.Trade_id T1 ,t2.Trade_id T2 ,t1.Trade_Timestamp as T1_time ,t2.Trade_Timestamp as T2_time ,t1.Price as T1_price ,t2.Price as T2_Price  from 
Trade t1  inner join 
Trade t2
on t1.Trade_id<>t2.Trade_id and  t1.Trade_Timestamp<t2.Trade_Timestamp )

select  T1,T2,T1_time,T2_time,T1_price ,T2_price,abs(T1_price-T2_Price)/T1_price*100 from  final_cte
where DATEDIFF(second,T1_time,T2_time)<10 and abs(T1_price-T2_Price)/T1_price*100 >10
