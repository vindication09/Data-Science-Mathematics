##I)	Write a query that matches employees that are from the same department. 
#Your query should return emp name, and department. 

SELECT a.emp_name AS emp_name1, b.emp_name AS emp_name2, a.department as department
FROM `media-data-science.tutorial_data.emp_data` a
join `media-data-science.tutorial_data.emp_data` b
on a.department = b.department #join on department 
WHERE a.emp_name <> b.emp_name #avoid getting the same employee in a row 
ORDER BY a.department 

##II)	II)	Assume that the company only consists of the 6 employees listed on the table. 
#Compute the percentage of employees by department for the company. 
#Your query should only return department and percent employees. 

#we need to use a self join here since this is a two step operation 
#the first step is to count the number of employees per department (this number will be divided by total num employees)
#the second step is to count toal number of employees 
#The third step is to divide the numerator by denominator in a join 


select 
a.department as department, round((a.num_emps/b.sum_emp)*100,2) as percent_emp #We divide the number of emp by department by total number of emp
from 

	(select 
	department, count(distinct emp_name) as num_emps, 1 as dummy #This query grabs numerator part 
	from `media-data-science.tutorial_data.emp_data`
	group by department) a  #group by to count number of emps per department 

join 

	(select 
	count(distinct emp_name) as sum_emp, 1 as dummy
	from `media-data-science.tutorial_data.emp_data`) b  #This query grabs the denominator 

on (a.dummy=b.dummy) #join on some dummy variable we need to create otherwise there is no join condition 
order by a.department 




##III) Use a union all to make a new list of all employees including new hires. 
#Your query should only return employee Id and employee name. 
#Assume the new hires table is called ‘new_hires’. 

select 
emp_id , emp_name 
from `media-data-science.tutorial_data.emp_data`

union all 

select 
new_emp_id , new_emp
from `media-data-science.tutorial_data.new_hires`


##IV) Generate a list of departments that only have under 2 employees from the emp_table and the new_hires table. 
#You should add some sort of flag to identify the result from new_hires and emp_table. 
#Your query should only return department , emp count, and flag. 

select 
department, count(distinct emp_id) as dep_count, 'CurrentEmployees' as flag
from `media-data-science.tutorial_data.emp_data`
group by department
having count(distinct emp_id) <2  

union all 

select 
department, count(distinct new_emp_id) as dep_count, 'NewEmployees' as flag
from `media-data-science.tutorial_data.new_hires`
group by department
having count(distinct new_emp_id) <2  

##V) Use a case when statement to identify employees from the emp_table who qualify for a raise. Identify these employees with some flag. 
#In order to qualify for a raise, the employee must have worked 2 years or more. your query should return emp ID, emp name, annual salary, and flag

select 
emp_id,
emp_name, 
annual_salary, 
case when tenure>=2 then 'GetsRaise' else 'DoesNotQualify' end as flag 
from `media-data-science.tutorial_data.emp_data`

##VI)	Lets say the raise consists of a 3 percent increase of their annual salary.
## Compute a new annual salary for employees who qualify for a raise but do not exclude employees who did not get a raise. 
#You will want to use subquery and an additional case when to specify where to calculate new salary 

select 
emp_id, 
emp_name, 
case when flag in ('GetsRaise') then (annual_salary*.03)+annual_salary else annual_salary end as new_annual_salary
from 
(

	select 
	emp_id,
	emp_name, 
	annual_salary, 
	case when tenure>=2 then 'GetsRaise' else 'DoesNotQualify' end as flag 
	from `media-data-science.tutorial_data.emp_data`

)