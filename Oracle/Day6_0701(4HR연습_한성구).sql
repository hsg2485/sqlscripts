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




