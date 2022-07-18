-- view : 가상 테이블(물리적으로 존재하지 않고 논리적으로 만들어진 테이블)
--          ㄴ 물리적인 테이블을 이용해서 생성합니다.
--			ㄴ 사용자(개발자)가 테이블처럼 select 를 조회를 할수 있는 테이블
--				자주 사용되는 join등을 미리 view 생성해서 사용함
--			ㄴ grant resource,connect to c##idev;   ->뷰 생성권한 없는 오류 생기면 추가 권한 부여하기. resource 에 view 생성은 제외입니다.

CREATE VIEW v_dept
AS
SELECT d.DEPARTMENT_ID, DEPARTMENT_NAME, e.EMPLOYEE_ID, e.FIRST_NAME, e.HIRE_DATE, e.JOB_ID 
FROM departments d, employees e
WHERE d.department_id = e.department_id;

SELECT * FROM v_dept WHERE job_id = 'ST_CLERK';