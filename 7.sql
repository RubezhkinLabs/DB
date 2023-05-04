select department_name
from departments
except
select department_name
from departments
where department_id in 
(select department_id
from employees
where job_id like 'SA_REP');

select country_id from countries
except
select country_id from countries
where country_id in
(select country_id from locations
where location_id in 
 (select location_id from departments));
 
select last_name from employees
where department_id = 10
union
select last_name from employees
where department_id = 20
union
select last_name from employees
where department_id = 50;

select employee_id, job_id
from employees
intersect 
select employee_id, job_id
from job_history;