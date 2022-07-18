-- view : ���� ���̺�(���������� �������� �ʰ� �������� ������� ���̺�)
--          �� �������� ���̺��� �̿��ؼ� �����մϴ�.
--			�� �����(������)�� ���̺�ó�� select �� ��ȸ�� �Ҽ� �ִ� ���̺�
--				���� ���Ǵ� join���� �̸� view �����ؼ� �����
--			�� grant resource,connect to c##idev;   ->�� �������� ���� ���� ����� �߰� ���� �ο��ϱ�. resource �� view ������ �����Դϴ�.

CREATE VIEW v_dept
AS
SELECT d.DEPARTMENT_ID, DEPARTMENT_NAME, e.EMPLOYEE_ID, e.FIRST_NAME, e.HIRE_DATE, e.JOB_ID 
FROM departments d, employees e
WHERE d.department_id = e.department_id;

SELECT * FROM v_dept WHERE job_id = 'ST_CLERK';