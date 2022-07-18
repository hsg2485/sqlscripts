-- 작성자 : 한성구
-- 조인과 group by 를 포함해서 select 로 검색하는 문제를 10개 만들기
-- group by 결과로도 조인을 할 수 있음. ex) 부서 인원이 가장 많은 부서는?

--1) EMPLOYEES 테이블에서 부서 인원이 10명보다 많은 부서의 부서번호, 인원수 구하기
SELECT department_id, COUNT(*)
FROM EMPLOYEES e 
GROUP BY department_id
HAVING COUNT(*) > 10;

--2) EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 
--	 업무ID, 평균 급여, 급여의 합을 구하기
SELECT job_id, ROUND(AVG(salary)), SUM(salary)
FROM EMPLOYEES e 
GROUP BY job_id
HAVING AVG(salary) >= 10000;

--3) EMPLOYEES 테이블에서 부서별로 인원수, 최저급여, 최고 급여, 급여의 합을 구하기
SELECT department_id, COUNT(*), MIN(salary), MAX(salary), SUM(salary) 
FROM EMPLOYEES e 
GROUP BY department_id;

--4) EMPLOYEES 테이블에서 각 부서별로 인원수,급여의 평균, 최저 급여, 최고 급여, 
--   급여의 합을 구하여 급여의 합이 많은 순으로 출력하기
SELECT DEPARTMENT_ID, COUNT(*), ROUND(AVG(salary)), MIN(salary), MAX(salary), SUM(salary) 
FROM EMPLOYEES e 
GROUP BY department_id
ORDER BY sum(SALARY) DESC;

--5) EMPLOYEES 테이블에서 Job_ID, 직업별 인원수, 급여의 합, 평균 급여를 구해서 
-- 	 평균 급여가 많은 직업 순으로 출력하기
SELECT job_id, count(*), SUM(salary), ROUND(AVG(salary))
FROM EMPLOYEES e 
GROUP BY JOB_ID 
ORDER BY ROUND(AVG(salary)) DESC;

--6) 직원들의 이름, 부서번호, 부서명을 출력하기
SELECT e.first_name, e.department_id, d.department_name 
FROM employees e,  departments d
WHERE e.department_id = d.department_id;

--7) 커미션을 받는 직원의 이름, 직업, 부서ID, 부서명을 출력하기
SELECT e.first_name, e.job_id, e.department_id, d.department_name
FROM EMPLOYEES e,  DEPARTMENTS d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

--8) 직원 이름과 그 직원의 관리자 이름을 출력하기
SELECT e.first_name AS 직원, m.first_name AS 관리자
FROM EMPLOYEES e, EMPLOYEES m
WHERE e.manager_id = m.employee_id;

--9) 이름에 H가 들어가는 직원들의 이름과 부서ID, 부서명을 출력하기
SELECT e.first_name, d.DEPARTMENT_ID, d.department_name
FROM EMPLOYEES e,  DEPARTMENTS d
WHERE e.department_id = d.department_id
AND e.first_name LIKE '%H%';

--10) 2005년 이후로 입사한 사원의 이름, 입사일, 부서명을 출력하기
SELECT e.first_name , e.HIRE_DATE, d.DEPARTMENT_NAME 
FROM EMPLOYEES e, DEPARTMENTS d  
WHERE e.hire_date >= '2005-01-01';




