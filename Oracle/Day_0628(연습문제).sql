--�ۼ��� : �Ѽ���
CREATE TABLE students (
	Student_no char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age NUMBER(5),
	address varchar2(50)
	);
	
INSERT INTO students VALUES ('2021001','����',16,'���ʱ�');
--����
--INSERT INTO students(Student_no, name, age, address) VALUES ('2021001','����',16,'���ʱ�');
INSERT INTO students VALUES ('2019019','������',18,'������');

CREATE TABLE scores (
	Student_no char(7) NOT NULL,
	subject varchar2(20) NOT NULL,
	grade NUMBER(5) NOT NULL,	-- ����
	teacher varchar2(20) NOT NULL,
	semester char(7) NOT NULL,	-- �б�
	PRIMARY KEY (Student_no, subject),	--�⺻Ű ����(not null �׸��� unique)
	FOREIGN KEY (Student_no) REFERENCES students (student_no)
	); 
	--�ܷ�Ű ���� REFERENCES(����) Ű���� �ڿ� ���� ���̺�(���� �÷�)
	--FOREIGN KEY (Student_no) REFERENCES students
	--���� : �ܷ�Ű �÷��� ���� �÷� ��� �÷����� ������ (�����÷�) ���� ����
	--�ܷ�Ű �÷��� FOREIGN KEY Ű���� �ڿ� () �ȿ� �ۼ�
	--���� �÷��� ����? �⺻Ű �Ǵ� unique ���� ���� �÷��� ��
/*	alter table ~ add constraint
ALTER TABLE scores 
		ADD CONSTRAINT pk_scores PRIMARY KEY (Student_no,subject);
ALTER TABLE scores 
		ADD CONSTRAINT fk_scores FOREIGN KEY (Student_no)
		REFERENCES students(Student_no);
*/
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','����',89,'�̳���','2022_1');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','����',78,'��浿','2022_1');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','����',67,'�ڼ���','2021_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','����',92,'�̳���','2019_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','����',85,'������','2019_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','����',88,'�ڼ���','2020_1');

/*CREATE TABLE students0(
   stuno char(7) PRIMARY KEY,
   name nvarchar2(20) NOT NULL,
   age number(3) CHECK (age BETWEEN 10 AND 30),
   address nvarchar2(50)
);

INSERT INTO students0(stuno,name,age,address)
VALUES ('2021001','����',16,'���ʱ�');
INSERT INTO students0(stuno,name,age,address)
VALUES ('2019019','������',18,'������');

CREATE TABLE scores0(
   stuno char(7) NOT NULL,
   subject nvarchar2(20) NOT NULL,
   jumsu number(3) NOT NULL,   -- ����
   teacher nvarchar2(20) NOT NULL,
   term char(7) NOT NULL,   -- �б�
   PRIMARY KEY (stuno,subject),
   FOREIGN KEY (stuno) REFERENCES students0(stuno)
);

INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',89,'�̳���','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',78,'��浿','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','����',67,'�ڼ���','2021_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',92,'�̳���','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',85,'������','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','����',88,'�ڼ���','2020_1');
*/