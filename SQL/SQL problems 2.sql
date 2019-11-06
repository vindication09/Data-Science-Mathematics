-----
----Q1)
---hint : use IN 
select 
*
from employees 
where department IN ('IT', 'analytics') 

---Q2) 
---
#outer query computes the AVG annual salary 
select 
AVG(annual_salary)
from
	(
	#inner query grabs all data belonging to anyone in IT or analytics 
	select 
	*
	from employees 
	where department IN ('IT', 'analytics') 
	)

---Q3) 
---in order to write joins, we need to create an alias 
select
a.emp_id, 
a.emp_name, 
a.emp_rating, 
b.hr_evaluator_id
from employees a  
join evaluations b 
on (a.emp_id=b.emp_id)


---Q4) 
select
a.emp_id, 
a.emp_name, 
a.emp_rating, 
b.hr_evaluator_id
from employees a  
left join evaluations b 
on (a.emp_id=b.emp_id)