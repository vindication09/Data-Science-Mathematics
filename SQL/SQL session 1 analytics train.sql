#########################SQL Training 

---Q1) 
select 
emp_id, emp_name_ age, annual_salary, tenure_yearsworked
from employees 
order by tenure_yearsworked desc ;

--q2) 
---AVG()
select 
AVG(annual_salary)
from employees ;

---q3) 
select
employee_id, employee_name, age, annual_salary, tenure_yearsworked ----select variables 
from employees #from what table 
where age>30 #add condition 
order by age desc; #add sorting condition 

---q4) 
---round(a,b)
---a is some numeric variable 
---b is going to specify # of decimal places 
select 
emp_id, emp_name, round(annual_salary/12, 2) as monthly_salary 
from employees 

---q5)
select 
emp_id, emp_name, annual_salary, round(annual_salary*1.05,0) as bonus_awarded
from employees

---q6)
--- wildcard % is a conditional statment 
--if you know the start or ending of a value but not the whole value 
----('Tom%')
select
emp_id emp_name, annual_salary
from employees
where employee_name like ('Tom%')

---If you know the exact value...
select
emp_id emp_name, annual_salary
from employees
where employee_name in ('Tom Brooks')

---q7) 
----GROUP BY is the aggregation operation 
select 
tenure_yearsworked, AVG(annual_salary)
from employees
group by tenure_yearsworked
