

use new_db;
-- decompress 
-- count num of rows 
-- check iff odd or even
-- find median 
 
with recursive rec_cte as
(select num, frequency, 1 as cnt
from number
union all 
select num, frequency, cnt +1 as cn
from rec_cte 
where cnt < frequency
 ),
 total_rows as
(
select num , frequency, 
	row_number() over( order by num) r_n	,
	sum(1) over() n
from rec_cte),

odd_or_even_cte as(

select num, r_n, n,
	case when n%2 = 0 and r_n = n/2 or r_n = n/2 + 1 then 'T'
		when n%2 != 0 and r_n = n/2 or r_n = n/2 + 1 then 'F' end as Flag
from total_rows)
select round(avg(num) ,1) median
-- select *
from odd_or_even_cte
where Flag  = 'T'
order by num