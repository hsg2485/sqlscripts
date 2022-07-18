--����: ���� �׷�ȭ ��. ����ϴ� ������ �Ʒ�ó�� ��
--SELECT �� 
--[WHERE] �׷�ȭ �ϱ� ���� ����� ���ǽ�
--GROUP BY �׷�ȭ�� ����� �÷���
--[HAVING] �׷�ȭ ����� ���� ���ǽ�
--[ORDER BY] �׷�ȭ ��� ���� �÷���� ���

SELECT PCODE, count(*) FROM TBL_BUY tb GROUP BY PCODE;
SELECT pcode, count(*), sum(quantity)
	FROM TBL_BUY tb 
	GROUP BY PCODE 
	ORDER BY 2;		--��ȸ�� �÷��� ��ġ

SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	GROUP BY PCODE 
	ORDER BY cnt;	--�׷��Լ� ����� ��Ī

--�׷�ȭ �Ŀ� ���� �հ谡 3 �̻� ��ȸ	
SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	GROUP BY PCODE 
--	HAVING total >= 3	--having ���� �÷� ��Ī ��� ����. ���̺� �÷����� ����� �� ����
	HAVING sum(QUANTITY) >= 3
	ORDER BY cnt;	--�׷��Լ� ����� ��Ī

--���ų�¥ 2022-04-01 ������ �͸� �׷��Ͽ� ��ȸ
SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY pcode
	ORDER BY cnt;
--Day2 ����
--��� �Լ� : count,avg,max,min. ����Լ��� �׷��Լ���� ��
--			�ش� �Լ� ������� ���ϱ� ���� Ư�� �÷� ����Ͽ� ���� �����͸� �׷�ȭ�� �� ����

SELECT count(*) FROM employees e; --���̺� ��ü ������ ���� : 107
SELECT max(salary) FROM employees e; -- salary �÷��� �ִ밪 : 24000
SELECT min(salary) FROM employees e; -- �ּҰ� : 2100
SELECT avg(salary) FROM employees e; -- ��հ� : 6461.83...
SELECT min(salary) FROM employees e; -- �հ� : 691416
