create table book_member(
mem_idx number(5,0) not null primary key,
name varchar2(20) not null,
email varchar2(20) not null,
tel varchar2(20),
password varchar2(10),
unique(email, tel)
);

create table tbl_book(
bcode char(5) not null primary key,
title varchar2(30) not null,
writer varchar2(20),
publisher varchar2(20),
pdate date);

create table tbl_bookrent(
rent_no number(5,0) not null primary key,
mem_idx number(5,0) not null,
bcode char(5) not null,
rent_date date not null,
exp_date date not null,
return_date date,
delay_days number(3,0),
foreign key(mem_idx) references book_member(mem_idx),
foreign key(bcode) references tbl_book(bcode));

create sequence tbl_seq1 start with 10001;

create sequence tbl_seq2 start with 1;

insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '���ϴ�', 'honey@naver.com', '010-9889-0567', '1122');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '�̼���', 'jong@daum.net', '010-2354-6773', '2345');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '�����', 'lucky@korea.com', '010-5467-8792', '9876');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '���浿', 'nadong@kkk.net', '010-3456-8765', '3456');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '������', 'haha@korea.net', '010-3987-9087', '1234');

insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1101', '�ڽ���', 'Į���̰�', '���̾𽺺Ͻ�', '2006-12-01');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('B1101', '��Ŀ������', '����Ŀ', '��Ŀ����', '2018-07-10');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('C1101', 'Ǫ������ �ʹϴ�', '����', 'â��', '2015-06-20');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1102', '�佺Ʈ', '�˺���Ʈ �', '������', '2011-03-01');

insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10001, 'B1101', '2021-09-01', '2021-09-15', '2021-09-14', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10002, 'C1101', '2021-09-12', '2021-09-26', '2021-09-29', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10003, 'B1101', '2021-09-03', '2021-09-17', '2021-09-17', null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10004, 'C1101', '2022-06-30', '2022-07-14', null, null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10001, 'A1101', '2022-07-04', '2022-07-18', null, null);
insert into tbl_bookrent(rent_no, mem_idx, bcode, rent_date, exp_date, return_date, delay_days) values
	(tbl_seq2.nextval, 10003, 'A1102', '2021-07-06', '2022-07-20', '2022-07-13', null);

--�����ϱ� : '�뿩' �⺻���� ������ �뿩��¥�� ����, �ݳ������� ����+14�� �⺻������ �� �� �ֵ��� ��
--alter table "C##IDEV".TBL_BOOKRENT modify rent_date date default sysdate;
--alter table "C##IDEV".TBL_BOOKRENT modify exp_date date default sysdate+14;
--insert into TBL_BOOKRENT (rent_no, mem_idx, bcode)
--	values (bookrent_seq.nextval, 10002, 'A1102');

--�÷� ����Ʈ �� ���ְ� ���� ��
--alter table "C##IDEV".TBL_BOOKRENT modify rent_date date default null;

------------------'�����뿩 ó������'-----------------
/*
 * ������ �߰��մϴ�. ��B1102�� , ����Ʈ����ũ �����⡯, ����ö���� ,��KBO�� , ��2020-11-10����
�ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷����� update �մϴ�.
���� ��ü ���� ȸ���� �̸�,��ȭ��ȣ�� �˻��մϴ�.
���� �������� ������ �������ڵ�� ������ �˻��մϴ�. (return_date�� null�̸� �뿩��, null�� �ƴϸ� �ݳ��� ����)
���� ������ �뿩�� ȸ���� IDX�� ȸ���̸��� �˻��մϴ�.
���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ������� �˻��մϴ�.
ȸ��  IDX ��10002���� ���� ������ �������� ���ν����� �ۼ��մϴ�.
������ ����Ʈ�� ��� ���ڰ� ���� ������ �˻��Ͽ� ���� ������ �������� ���ν����� �ۼ��մϴ�.
6�� 7�� �̿��ؼ� insert �� �ϴ� ���ν����� �ۼ��մϴ�
 */

--������ �߰��մϴ�. ��B1102�� , ����Ʈ����ũ �����⡯, ����ö���� ,��KBO�� , ��2020-11-10��
INSERT INTO TBL_BOOK(bcode, title, writer, publisher, pdate) VALUES 
	('B1102', '��Ʈ����ũ ������', '��ö��', 'KBO', '2020-11-10');

--�ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷����� update �մϴ�.
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE
	WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT tb;

--�������� ������ ��ü�ϼ� ����ؼ� ȸ��IDX, �����ڵ�, ��ü�ϼ� ��ȸ�ϱ�
--sysdate�� ����� ������ �������� �ʾ� �׳��ϸ� long������ ����
SELECT MEM_IDX, bcode, to_date(to_char(sysdate,'yyyy-mm-dd')) - exp_date 
	FROM TBL_BOOKRENT tb WHERE return_date IS NULL;
		-----�Ǵ�
SELECT MEM_IDX, bcode, trunc(sysdate) - exp_date 	--trunc(sysdate)�� sysdate�� �ð��κ��� ����
	FROM TBL_BOOKRENT tb WHERE return_date IS NULL;

--���� ��ü ���� ȸ���� �̸�,��ȭ��ȣ�� �˻��մϴ�. (���� ��¥ sysdate �������� Ȯ���ϱ�)
--���� �������� ��ü���� ���� �ݳ����� < ���糯¥
SELECT NAME, TEL FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
	ON bm.MEM_IDX = tb.MEM_IDX AND sysdate > EXP_DATE  AND return_date IS NULL;

--���� �������� ������ �������ڵ�� ������ �˻��մϴ�
SELECT tb.BCODE, TITLE FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2 
	ON tb.BCODE = tb2.BCODE AND return_date IS NULL;

--���� ������ �뿩�� ȸ���� IDX�� ȸ���̸��� �˻��մϴ�.
SELECT bm.MEM_IDX, NAME FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
	ON bm.MEM_IDX = tb.MEM_IDX AND return_date IS NULL;

--�������� ������ ȸ���̸�, ������, �ݳ����� �˻�(DM ����)
SELECT bm.NAME, tb.TITLE, tb2.EXP_DATE FROM BOOK_MEMBER bm, TBL_BOOK tb, TBL_BOOKRENT tb2
	WHERE tb2.MEM_IDX = bm.MEM_IDX AND tb2.BCODE = tb.BCODE AND return_date IS null;
		--�Ǵ�--
SELECT name, title, exp_date FROM TBL_BOOKRENT tb  
	JOIN TBL_BOOK tb2 ON tb.BCODE = tb.BCODE 
	JOIN BOOK_MEMBER bm ON tb.MEM_IDX = bm.MEM_IDX
	WHERE return_date IS NULL;

--���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ������� �˻��մϴ�.
SELECT mem_idx, bcode, exp_date FROM TBL_BOOKRENT tb 
	WHERE SYSDATE > EXP_DATE;

--ȸ��  IDX '10002'�� ���� ������ �������� ���ν����� �ۼ��մϴ�.

	--��ȸ������ �����ϴ� ���ν���
	DECLARE
		vcnt NUMBER;
	BEGIN
		SELECT count(*) INTO vcnt 
		FROM TBL_BOOKRENT tb 
		WHERE MEM_IDX = 10002 AND return_date IS NULL; --rcnt�� 0�϶��� �뿩 ����	
		IF (vcnt = 0) THEN
			dbms_output.put_line('å �뿩 �����մϴ�.');
		ELSE 
			dbms_output.put_line('�뿩���� å�� �ݳ��ؾ� �����մϴ�.');
		END IF;
	END;
	
	--���ν��� ����Ŭ ��ü
	CREATE OR REPLACE PROCEDURE CHECK_MEMBER(
		arg_mem IN book_member.MEM_IDX%TYPE,	--���ν��� ������ �� ���� ���� �Ű� ����
		isOK OUT varchar2		--�ڹ��� ���ϰ��� �ش��ϴ� �κ�
	)
		IS 
		vcnt NUMBER;
		vname varchar2(100);
		BEGIN
			--�Է� �Ű������� ���� ȸ���ΰ��� Ȯ���ϴ� sql�� exception ó��. arg_mem���� ȸ�����̺��� name ��ȸ
			--	������ exception ó��
			SELECT name INTO vname
				FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
			SELECT count(*) 
			INTO vcnt 	--SELECT ��ȸ ��� ������ ����. ������ , �� ������ �� ����
			FROM TBL_BOOKRENT tb 
			WHERE MEM_IDX = 10002 AND return_date IS NULL; --rcnt�� 0�϶��� �뿩 ����	
			IF (vcnt = 0) THEN
				dbms_output.put_line('å �뿩 �����մϴ�.');
				isOK := '����';
			ELSE 
				dbms_output.put_line('�뿩���� å�� �ݳ��ؾ� �����մϴ�.');
				isOK := '�Ұ���';
			END IF;
		EXCEPTION		-- ����(����)ó��
		WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('ȸ���� �ƴմϴ�.');
		isOK :='no match';
		END;

	--���ν��� �����ϱ�
	DECLARE
		vresult varchar2(20);
	BEGIN
		check_member(10003,vresult);
		dbms_output.put_line('��� : ' || vresult);
	END;


--������ '�佺Ʈ' ��� ������ �˻��Ͽ� ���� ������ �������� ���ν����� �ۼ��մϴ�.
DECLARE
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT title INTO v_bcode	--v_bcode�� 'A1102'
		FROM TBL_BOOK tb WHERE TITLE = '�佺Ʈ';
	SELECT count(*) INTO v_cnt --v_cnt ���� 1�̸� v_bcode å�� ������
		FROM TBL_BOOKRENT tb2 
		WHERE BCODE = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('�뿩���� å�Դϴ�.');
	ELSE 
		dbms_output.put_line('å �뿩 �����մϴ�.');
	END IF;
END;

--���ν��� ����Ŭ ��ü
CREATE OR REPLACE PROCEDURE CHECK_BOOK(
			arg_book IN tbl_book.title%TYPE,	-- ���ν��� �����Ҷ� ���� ���� �Ű�����
			isOK OUT varchar2		-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�.
	)
	IS 
	v_bcode varchar2(100);
 	v_cnt NUMBER;
 BEGIN
 	SELECT bcode INTO v_bcode		-- v_bcode�� 'A1102'
 		FROM TBL_BOOK tb WHERE title = arg_book;
	-- ���� å�̸� �Է��ϸ� ����. bcode ���� �˻��� �ȵ˴ϴ�.-> Exception 
 	SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ������
		FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND return_date IS NULL; 
	 IF (v_cnt = 1) THEN 
		DBMS_OUTPUT.put_line('�뿩 ���� å �Դϴ�.');
		isOK := 'FALSE' ;
  	 ELSE 
		DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
		isOK := 'TRUE' ;
  	 END IF;
  	 EXCEPTION		-- ����(����)ó��
	 WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('ã�� å�� �����ϴ�.');
		isOK :='no match';

END;

/* �� �ڵ�� ���ؼ� ���� ã��!!!!!!!!!!!!!!!!
CREATE OR REPLACE PROCEDURE check_book(
	arg_book IN tbl_book.title%TYPE,
	isOK OUT varchar2
)
	IS 
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT bcode INTO v_bcode
		FROM TBL_BOOK tb WHERE title = arg_book;
	--���� å �̸� �Է��ϸ� ����. bcode ���� �˻��� �ȵ� => Exception
	SELECT COUNT(*) INTO v_cnt
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_out.put_line("�뿩���� å�Դϴ�.");
		isOK := 'FALSE';
	ELSE
		dbms_out.put_line("å �뿩 �����մϴ�.");
		isOK := 'TRUE';
	END IF;
END;
*/



--���ν��� �����ϱ�
DECLARE
	vresult varchar2(100);
BEGIN
	check_book('�佺Ʈ', vresult);	--�ڽ���, Ǫ������ �ʹϴϴ� FALSE
	dbms_output.put_line('��� : ' || vresult);
END;






