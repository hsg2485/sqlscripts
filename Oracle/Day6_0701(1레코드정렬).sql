-- select �⺻ ����
-- select �÷�1, �÷�2, ... from ���̺�� where �˻� ���ǽ�
--				order by ���� �÷� (�⺻�� ����:asc, ����:desc)

SELECT * FROM tbl_buy tb; --INSERT ������ ������ ��� ���
SELECT * FROM TBL_CUSTOM tc;
SELECT * FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'
						ORDER BY buy_date DESC;	--WHERE ~ ORDER BY ����

--��ȸ�� �÷� ������ �� distinct Ű���� : �ߺ����� 1���� ��� ���
SELECT custom_id FROM TBL_BUY tb;	--���Ű� ID ��ȸ
SELECT DISTINCT custom_id FROM TBL_BUY tb;