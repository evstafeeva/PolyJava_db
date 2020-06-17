alter session set "_ORACLE_SCRIPT"=true; 
create user hr    -- им€ пользовател€ (oraclelabs)
identified by hr      -- пароль пользовател€ (oracle)
default tablespace users; -- табличное пространство дл€ хранени€ данных таблиц и индексов
grant connect to hr;  -- предоставление привилегий дл€ подключени€ к Ѕƒ
grant resource to hr; -- предоставление привилегий на создание основных объектов в своей схеме
grant create view to hr; -- предоставление привилегий на создание представлений
GRANT ALL PRIVILEGES TO hr;


SELECT last_name, first_name,  'работает в должности: ' || job_id AS "CURRENT JOB"
FROM employees;

SELECT employee_id, last_name, first_name, job_id, salary, manager_id, department_id
FROM employees
WHERE (manager_id IS NULL) OR( department_id IS NULL);

SELECT employee_id, last_name, first_name, manager_id
FROM employees
WHERE manager_id NOT IN (100);

SELECT employee_id, last_name, hire_date, TRUNC (MONTHS_BETWEEN (sysdate, hire_date)/12) AS "YEARS WORKED"
FROM employees
ORDER BY years_worked, last_name;

SELECT department_id, COUNT (employee_id) AS "EMP_CNT"
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 10
ORDER BY emp_cnt DESC;

SELECT department_id, COUNT(employee_id) AS "EMP_CNT"
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >= 3
ORDER BY emp_cnt DESC;

SELECT
COUNT(CASE WHEN  EXTRACT(year FROM hire_date)=2007 THEN 1 ELSE NULL END) AS "CNT 2007",
COUNT(CASE WHEN EXTRACT(year FROM hire_date)=2008 THEN 1 ELSE NULL END) AS "CNT 2008",
COUNT(employee_id) AS "CNT TOTAL"
FROM employees;

SELECT e.employee_id empid, e.last_name empname, NVL(m.employee_id, 0) manid, NVL(m.last_name, 'не имеет') manname
FROM employees e LEFT JOIN employees m
ON (e.manager_id = m.employee_id)
ORDER BY empid;

SELECT department_id, d.department_name, d.location_id, ROUND(AVG(NVL(e.salary, 0)), 2) avgsal
FROM employees e RIGHT JOIN departments d USING (department_id)
WHERE department_name LIKE '%n_'
GROUP BY department_id, d.department_name, d.location_id
ORDER BY department_id;

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees WHERE last_name = 'Mourgos');

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE (job_id, salary) IN (SELECT job_id, max_salary FROM jobs);

SELECT last_name, salary, max_salary
FROM employees e JOIN jobs j ON e.job_id = j.job_id;
SELECT employee_id, last_name
FROM employees
WHERE employee_id != ALL (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);


WITH salary_of_dept AS
(SELECT department_name, SUM(salary) AS salary_dept
   FROM employees JOIN departments USING(department_id)
   GROUP BY department_id, department_name),
sumsalary AS
  (SELECT SUM(salary) AS sum_salary FROM employees)
SELECT department_name, salary_dept
FROM salary_of_dept
WHERE salary_dept > (SELECT sum_salary FROM sumsalary)*(1/8);

SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id DESC;

SELECT last_name, first_name
      ,NVL((SELECT department_name FROM departments d WHERE e.employee_id = d.manager_id), 'не €вл€етс€ руководителем отдела') deptname
FROM employees e
UNION ALL
SELECT 'ќбщее число ', 'руководителей отделов:', TO_CHAR(COUNT(*))
FROM employees e JOIN departments d ON (e.employee_id = d.manager_id);

CREATE TABLE emp_depts AS
SELECT employee_id empno, last_name, department_id deptno, department_name, to_char(hire_date, 'yyyy-q') hire_quarter
FROM employees LEFT JOIN departments USING(department_id);


