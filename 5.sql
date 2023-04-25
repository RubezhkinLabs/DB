select location_id, street_address, city, state_province, country_id, country_name from locations
natural join countries;

select last_name, department_id, department_name from employees
natural join departments;

select last_name, job_id, department_id, department_name from employees
natural join departments
natural join locations
where city = 'Toronto';

select e.employee_id, e.last_name, e.manager_id, man.last_name 
from employees e
inner join employees man
on(e.manager_id = man.employee_id);

select e.employee_id, e.last_name, e.manager_id, man.last_name 
from employees e
inner join employees man
on(e.manager_id = man.employee_id) or e.manager_id is null;

select d.department_id, d.department_name, e.employee_id, e.last_name
from departments d
inner join employees e
on(d.manager_id = e.employee_id);

