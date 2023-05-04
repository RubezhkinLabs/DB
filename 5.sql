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

select d.department_id, d.department_name, man.last_name, e.employee_id, e.last_name
from departments d
inner join employees e
on(d.manager_id = e.manager_id)
inner join employees man
on(d.manager_id = man.employee_id);

select e.employee_id, e.last_name, e.hire_date, d.hire_date
from employees d
join employees e
on(e.hire_date > d.hire_date and d.last_name = 'Davies');

select e.employee_id, e.last_name, e.hire_date, man.last_name, man.hire_date
from employees man
join employees e
on(e.hire_date < man.hire_date and e.manager_id = man.employee_id);

select department_id, department_name, count(employee_id)
from employees
natural join departments
group by department_id, department_name;

select e.employee_id, count(h.job_id) as job_count
from employees e
join job_history h
on(e.employee_id = h.employee_id)
group by e.employee_id having count(h.job_id) != 1;

select e.employee_id, e.last_name, man.employee_id, man.last_name
from employees man
join employees e
on(e.salary > man.salary and e.manager_id = man.employee_id);



