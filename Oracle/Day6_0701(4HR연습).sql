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

-------------------------------------------------------------------
--jobs 테이블 : min_salary가 평균보다 작은 job에 대한 정보
SELECT avg(min_salary) FROM jobs j;
SELECT job_id, job_title, min_salary FROM JOBS j 
WHERE MIN_SALARY < (SELECT avg(MIN_SALARY) FROM JOBS j);

--아래 명령은 오류 => 그룹 함수는 반드시 select 문으로 사용함
SELECT job_id, job_title, min_salary FROM JOBS j
WHERE MIN_SALARY < AVG(MIN_SALARY); 

SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';
--job_id가 'IT_PROG'가 아닌 것 조회. sql에서는 != 대신에 <>, NOT = 키워드 씀
SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG'; 
SELECT min(salary) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';

--소수점 관련 함수 : round(반올림), trunc(버림), ceil(내림)

--그룹함수 조회할 때 group by를 써야 group by에 쓴 컬럼을 select 로 조회할 수 있음
--		group by 컬럼 외에는 다른 컬럼 select 할 수 없음 => join, 서브 쿼리

--1단계 : 사용할 그룹함수 실행하기 
SELECT department_id, avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID;

--2단계 : 조인하기
SELECT * FROM DEPARTMENTS d JOIN
	(SELECT DEPARTMENT_ID, avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID;

--3단계 : 컬럼 지정하기
SELECT d.department_ID, d.department_name, round(tavg.cavg,1) FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID
	ORDER BY tavg.cavg DESC

--4단계 : 정렬한 결과로 특정 위치 지정 : first n은 상위 n개를 조회
SELECT d.department_ID, d.department_name, round(tavg.cavg,1) FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID
	ORDER BY tavg.cavg DESC
	FETCH FIRST 1 ROWS ONLY;	--12c 버전부터 사용함
	
--rownum은 가상의 컬럼으로 조회된 결과에 순차적으로 오라클이 부여하는 값
--		가상 컬럼 사용을 위해 join이 한번 더 필요함
SELECT rownum, tcnt.* FROM
(SELECT department_id, count(*) cnt FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
		WHERE rownum < 5;
		
SELECT rownum, tcnt.* FROM 
(SELECT department_id, count(*) cnt FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
		WHERE rownum = 1;

-- rownum 사용할 때 결과 확인이 안되는 예시 : rownum 1부터 시작해서 찾아갈 수 있는 조건식만 가능
-- WHERE rownum = 3;
-- WHERE rownum > 5;
-- 그래서 한번 더 rownum을 포함한 조회 결과로 select를 함. 이때 rownum은 별칭 부여	
SELECT * FROM 
	(SELECT rownum rn, tcnt.* from
		(SELECT department_id, count(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn BETWEEN 5 AND 9;
--where rn = 3;
