select max(salary), min(salary), round(avg(salary)) as avg, sum(salary) 
from employees;

select job_id, max(salary), min(salary), round(avg(salary)) as avg, sum(salary) 
from employees
group by job_id;

select job_id, count(*) 
from employees
group by job_id;

select count(distinct manager_id)
from employees;

select max(salary) - min(salary) as difference
from employees;

select manager_id, min(salary)
from employees
group by manager_id;

select manager_id, min(salary)
from employees
group by manager_id having min(salary) > 6000 and manager_id is not null;

select manager_id, round(avg(salary)) as avg
from employees
group by manager_id;
