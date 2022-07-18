--작성자 : 한성구
CREATE TABLE students (
	Student_no char(7) PRIMARY KEY,
	name nvarchar2(20) NOT NULL,
	age NUMBER(5),
	address varchar2(50)
	);
	
INSERT INTO students VALUES ('2021001','김모모',16,'서초구');
--정석
--INSERT INTO students(Student_no, name, age, address) VALUES ('2021001','김모모',16,'서초구');
INSERT INTO students VALUES ('2019019','강다현',18,'강남구');

CREATE TABLE scores (
	Student_no char(7) NOT NULL,
	subject varchar2(20) NOT NULL,
	grade NUMBER(5) NOT NULL,	-- 점수
	teacher varchar2(20) NOT NULL,
	semester char(7) NOT NULL,	-- 학기
	PRIMARY KEY (Student_no, subject),	--기본키 설정(not null 그리고 unique)
	FOREIGN KEY (Student_no) REFERENCES students (student_no)
	); 
	--외래키 설정 REFERENCES(참조) 키워드 뒤에 참조 테이블(참조 컬럼)
	--FOREIGN KEY (Student_no) REFERENCES students
	--참고 : 외래키 컬럼과 참조 컬럼 모두 컬럼명이 같으면 (참조컬럼) 생략 가능
	--외래키 컬럼은 FOREIGN KEY 키워드 뒤에 () 안에 작성
	--참조 컬럼의 조건? 기본키 또는 unique 제약 조건 컬럼만 됨
/*	alter table ~ add constraint
ALTER TABLE scores 
		ADD CONSTRAINT pk_scores PRIMARY KEY (Student_no,subject);
ALTER TABLE scores 
		ADD CONSTRAINT fk_scores FOREIGN KEY (Student_no)
		REFERENCES students(Student_no);
*/
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','국어',89,'이나연','2022_1');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','영어',78,'김길동','2022_1');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2021001','과학',67,'박세리','2021_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','국어',92,'이나연','2019_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','영어',85,'박지성','2019_2');
INSERT INTO scores (Student_no, subject, grade, teacher, semester)
VALUES ('2019019','과학',88,'박세리','2020_1');

/*CREATE TABLE students0(
   stuno char(7) PRIMARY KEY,
   name nvarchar2(20) NOT NULL,
   age number(3) CHECK (age BETWEEN 10 AND 30),
   address nvarchar2(50)
);

INSERT INTO students0(stuno,name,age,address)
VALUES ('2021001','김모모',16,'서초구');
INSERT INTO students0(stuno,name,age,address)
VALUES ('2019019','강다현',18,'강남구');

CREATE TABLE scores0(
   stuno char(7) NOT NULL,
   subject nvarchar2(20) NOT NULL,
   jumsu number(3) NOT NULL,   -- 점수
   teacher nvarchar2(20) NOT NULL,
   term char(7) NOT NULL,   -- 학기
   PRIMARY KEY (stuno,subject),
   FOREIGN KEY (stuno) REFERENCES students0(stuno)
);

INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','국어',89,'이나연','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','영어',78,'김길동','2022_1');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2021001','과학',67,'박세리','2021_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','국어',92,'이나연','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','영어',85,'박지성','2019_2');
INSERT INTO scores0(stuno,subject,jumsu,teacher,term)
VALUES ('2019019','과학',88,'박세리','2020_1');
*/