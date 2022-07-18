--DDL : create, drop, alter, TRUNCATE 
--	(����� user, table, sequence, view, ... �� truncate �� ���̺� ���)
--DML : select, insert, update, merge, delete => Ʈ��������� ������

/*
DROP TABLE STUDENTS;	--���� : students ���̺� ���� �����ϸ� 
		--���� : �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�.
DROP TABLE SCORES;
*/

--UPDATE ���̺�� SET �÷��� = ��, �÷��� = ��, �÷��� = ��, ... 
--	WHERE ���� �÷� �����
--DELETE FROM ���̺�� WHERE ���� �÷� �����
--������ ��: UPDATE �� DELETE �� WHERE ���� ����ϴ� ���� ������ ����
--		  ��� �����͸� ������ ���� DELETE ��ſ� TRUNCATE �����
--		  TRUNCATE �� ������ ���(rollback) �� �� ���� ������ DDL�� ����

SELECT * FROM STUDENTS s ;
-- UPDATE, DELETE, SELECT ���� WHERE �� �÷��� �⺻Ű �÷��̸�
-- 		����Ǵ� ��� �ݿ��Ǵ� ���� �? �ִ� 1��
--		�⺻Ű�� ������ ���̺��� ���� ����� ����(�ĺ�)
UPDATE STUDENTS SET age = 17 WHERE STUDENT_NO = 2021001;

--rollback �׽�Ʈ (�����ͺ��̽� �޴����� Ʈ����� ��带 manual�� ������)
UPDATE STUDENTS SET ADDRESS = '���ϱ�', age = 16 WHERE STUDENT_NO = 2021001;
ROLLBACK;	--���� UPDATE ������ ���
SELECT * FROM STUDENTS;		-- �ٽ� '���ʱ�', 17���� ����
UPDATE STUDENTS SET ADDRESS = '���ϱ�', age = 16 WHERE STUDENT_NO = 2021001;
COMMIT;
SELECT * FROM STUDENTS;	-- '���ϱ�', 16���� �ݿ���
ROLLBACK;
SELECT * FROM STUDENTS;	--�̹� COMMIT�� �� ��ɾ�� ROLLBACK ����
-------------------------------------------
-- Ʈ����� ���� ��� : ROLLBACK, COMMIT
DELETE FROM SCORES;
ROLLBACK;
SELECT * FROM SCORES;
DELETE FROM SCORES WHERE STUDENT_NO = 2019019;
SELECT * FROM SCORES;
--39���� �������� ��
-- �� ������� Ʈ����� ���� ����̰� ���� â������ SELECT ����� 2019019�� ����
-- �ٸ� ������� �ٸ� Ŭ���̾�Ʈ �̹Ƿ� ���� ����(���� Ŀ���� ����)�� ������
ROLLBACK;
SELECT * FROM STUDENTS;

-------------------------------------------
TRUNCATE TABLE SCORES;		--��� �����͸� ����. ROLLBACK ���� Ȯ��?
							-- �� : ROLLBACK �Ұ�
-- ��� �����͸� ���� ���� Ȯ���ϸ� �ٸ� �͵�� ������ �ѹ���� �ʰ� Ȯ���ϰ� TRUNCATE �ϱ�
-------------------------------------------
/*
 * INSERT
 * DELETE
 * COMMIT;		(1) ���� 51, 52
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2)	���� 54, 55
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3)	���� 57, 58
 * INSERT
 * UPDATE;
 * COMMIT;		(4)	���� 60, 61
 */
