-- �ۼ��� : �Ѽ���
-- ���ΰ� group by �� �����ؼ� select �� �˻��ϴ� ������ 10�� �����
-- group by ����ε� ������ �� �� ����. ex) �μ� �ο��� ���� ���� �μ���?

--1) EMPLOYEES ���̺��� �μ� �ο��� 10���� ���� �μ��� �μ���ȣ, �ο��� ���ϱ�
SELECT department_id, COUNT(*)
FROM EMPLOYEES e 
GROUP BY department_id
HAVING COUNT(*) > 10;

--2) EMPLOYEES ���̺��� ������ �޿��� ����� 10000 �̻��� ������ ���ؼ� 
--	 ����ID, ��� �޿�, �޿��� ���� ���ϱ�
SELECT job_id, ROUND(AVG(salary)), SUM(salary)
FROM EMPLOYEES e 
GROUP BY job_id
HAVING AVG(salary) >= 10000;

--3) EMPLOYEES ���̺��� �μ����� �ο���, �����޿�, �ְ� �޿�, �޿��� ���� ���ϱ�
SELECT department_id, COUNT(*), MIN(salary), MAX(salary), SUM(salary) 
FROM EMPLOYEES e 
GROUP BY department_id;

--4) EMPLOYEES ���̺��� �� �μ����� �ο���,�޿��� ���, ���� �޿�, �ְ� �޿�, 
--   �޿��� ���� ���Ͽ� �޿��� ���� ���� ������ ����ϱ�
SELECT DEPARTMENT_ID, COUNT(*), ROUND(AVG(salary)), MIN(salary), MAX(salary), SUM(salary) 
FROM EMPLOYEES e 
GROUP BY department_id
ORDER BY sum(SALARY) DESC;

--5) EMPLOYEES ���̺��� Job_ID, ������ �ο���, �޿��� ��, ��� �޿��� ���ؼ� 
-- 	 ��� �޿��� ���� ���� ������ ����ϱ�
SELECT job_id, count(*), SUM(salary), ROUND(AVG(salary))
FROM EMPLOYEES e 
GROUP BY JOB_ID 
ORDER BY ROUND(AVG(salary)) DESC;

--6) �������� �̸�, �μ���ȣ, �μ����� ����ϱ�
SELECT e.first_name, e.department_id, d.department_name 
FROM employees e,  departments d
WHERE e.department_id = d.department_id;

--7) Ŀ�̼��� �޴� ������ �̸�, ����, �μ�ID, �μ����� ����ϱ�
SELECT e.first_name, e.job_id, e.department_id, d.department_name
FROM EMPLOYEES e,  DEPARTMENTS d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

--8) ���� �̸��� �� ������ ������ �̸��� ����ϱ�
SELECT e.first_name AS ����, m.first_name AS ������
FROM EMPLOYEES e, EMPLOYEES m
WHERE e.manager_id = m.employee_id;

--9) �̸��� H�� ���� �������� �̸��� �μ�ID, �μ����� ����ϱ�
SELECT e.first_name, d.DEPARTMENT_ID, d.department_name
FROM EMPLOYEES e,  DEPARTMENTS d
WHERE e.department_id = d.department_id
AND e.first_name LIKE '%H%';

--10) 2005�� ���ķ� �Ի��� ����� �̸�, �Ի���, �μ����� ����ϱ�
SELECT e.first_name , e.HIRE_DATE, d.DEPARTMENT_NAME 
FROM EMPLOYEES e, DEPARTMENTS d  
WHERE e.hire_date >= '2005-01-01';

-------------------------------------------------------------------
--jobs ���̺� : min_salary�� ��պ��� ���� job�� ���� ����
SELECT avg(min_salary) FROM jobs j;
SELECT job_id, job_title, min_salary FROM JOBS j 
WHERE MIN_SALARY < (SELECT avg(MIN_SALARY) FROM JOBS j);

--�Ʒ� ����� ���� => �׷� �Լ��� �ݵ�� select ������ �����
SELECT job_id, job_title, min_salary FROM JOBS j
WHERE MIN_SALARY < AVG(MIN_SALARY); 

SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG';
--job_id�� 'IT_PROG'�� �ƴ� �� ��ȸ. sql������ != ��ſ� <>, NOT = Ű���� ��
SELECT min(salary) FROM EMPLOYEES e WHERE JOB_ID <> 'IT_PROG'; 
SELECT min(salary) FROM EMPLOYEES e WHERE NOT JOB_ID = 'IT_PROG';

--�Ҽ��� ���� �Լ� : round(�ݿø�), trunc(����), ceil(����)

--�׷��Լ� ��ȸ�� �� group by�� ��� group by�� �� �÷��� select �� ��ȸ�� �� ����
--		group by �÷� �ܿ��� �ٸ� �÷� select �� �� ���� => join, ���� ����

--1�ܰ� : ����� �׷��Լ� �����ϱ� 
SELECT department_id, avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID;

--2�ܰ� : �����ϱ�
SELECT * FROM DEPARTMENTS d JOIN
	(SELECT DEPARTMENT_ID, avg(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID;

--3�ܰ� : �÷� �����ϱ�
SELECT d.department_ID, d.department_name, round(tavg.cavg,1) FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID
	ORDER BY tavg.cavg DESC

--4�ܰ� : ������ ����� Ư�� ��ġ ���� : first n�� ���� n���� ��ȸ
SELECT d.department_ID, d.department_name, round(tavg.cavg,1) FROM DEPARTMENTS d 
	JOIN
	(SELECT DEPARTMENT_ID, avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON d.DEPARTMENT_ID = tavg.department_ID
	ORDER BY tavg.cavg DESC
	FETCH FIRST 1 ROWS ONLY;	--12c �������� �����
	
--rownum�� ������ �÷����� ��ȸ�� ����� ���������� ����Ŭ�� �ο��ϴ� ��
--		���� �÷� ����� ���� join�� �ѹ� �� �ʿ���
SELECT rownum, tcnt.* FROM
(SELECT department_id, count(*) cnt FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
		WHERE rownum < 5;
		
SELECT rownum, tcnt.* FROM 
(SELECT department_id, count(*) cnt FROM EMPLOYEES
		GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt
		WHERE rownum = 1;

-- rownum ����� �� ��� Ȯ���� �ȵǴ� ���� : rownum 1���� �����ؼ� ã�ư� �� �ִ� ���ǽĸ� ����
-- WHERE rownum = 3;
-- WHERE rownum > 5;
-- �׷��� �ѹ� �� rownum�� ������ ��ȸ ����� select�� ��. �̶� rownum�� ��Ī �ο�	
SELECT * FROM 
	(SELECT rownum rn, tcnt.* from
		(SELECT department_id, count(*) cnt FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn BETWEEN 5 AND 9;
--where rn = 3;
