use employees;
select gender,min(salary),max(salary),avg(salary),count(*)
from employees e,salaries s 
where e.emp_no=s.emp_no
group by gender;

select  count(emp_no)
from dept_emp
where dept_no='D007' and (to_date >= '1985-01-01' AND  from_date<='1991-03-07');

select count(distinct emp_no)
from employees;

select emp_no, count(*),avg(salary)
from salaries
group by emp_no;

select count(*)
from titles
where title='senior staff' or title='staff';






















