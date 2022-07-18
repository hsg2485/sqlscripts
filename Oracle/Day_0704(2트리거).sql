-- �����ͺ��̽� Ʈ���� : insert, update, delete �� �� �����ϴ� ���ν���
--		Ư�� ���̺� ���� �ִ� ��ü

CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom	--Ʈ���� �����ϴ� ���̺�, SQL�� ����
BEGIN 
	IF to_char(sysdate, 'HH24:MI') BETWEEN '13:00' AND '15:00'
	THEN raise_application_error(-20000,'���� ���� 1��~3�ô� �۾��� �� �����ϴ�.');
	END IF;
END;
--Ʈ���� ���� �׽�Ʈ
DELETE FROM tbl_custom WHERE CUSTOM_ID = 'twice';

--Ʈ���� ��Ȱ��ȭ : disable, Ȱ��ȭ : enable
ALTER TRIGGER secure_custom disable;	--enable

--Ʈ���ſ� �ʿ��� ���̺� ������ ����
CREATE TABLE TBL_TEMP 
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';

CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW 	--����(����)�ϴ� ���� �������� ��
BEGIN 
	--���� ���(tbl_buy ���̺��� ����)�� ������ tbl_temp �ӽ� ���̺� insert: �����࿡ ���� �۾�(�� Ʈ����)
	INSERT INTO TBL_TEMP 
	VALUES
	(:OLD.custom_id, :OLD.pcode, :OLD.quantity, :OLD.buy_date, :OLD.buyno);
END;
--Ʈ���� ���� �׽�Ʈ
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
SELECT * FROM tbl_temp;

--�߰� view ���� ����
--grant resource, connect to c##idev; => ���⿡�� view ���� ������ ����
--grant create view to c##idev; => �� ���� ���� ���� ���� ����� �߰� ���� �ο��ϱ�
GRANT CREATE VIEW TO c##idev; 
CREATE VIEW v_buy
AS
SELECT tb.custom_id, tb.pcode, tc.name, tc.email, tb.quantity
FROM tbl_buy tb, tbl_custom tc
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID;
