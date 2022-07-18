--작성자 : 한성구
--회원 테이블

CREATE TABLE tbl_custom (
	custom_id varchar2(20) PRIMARY key,
	name nvarchar2(20) NOT NULL,
	email varchar2(20),
	age number(3),
	reg_date DATE DEFAULT sysdate
);

--상품 테이블
CREATE TABLE tbl_product (
	pcode varchar2(20) PRIMARY KEY,
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price number(9) NOT null
);

--구매 테이블
CREATE TABLE tbl_buy (
	custom_id varchar2(20) NOT NULL,
	pcode varchar2(20) NOT NULL,
	quantity number(5) NOT NULL,
	buy_date DATE DEFAULT sysdate
);
--Date 형식에 지정되는 패턴 설정하기
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

--2) tbl_custom 데이터 
INSERT INTO tbl_custom(custom_id,name,email,age,reg_date) 
	VALUES ('mina012','김미나','kimm@gmail.com',20,'2022-03-10 14:23:25'); 
INSERT INTO tbl_custom(custom_id,name,email,age,reg_date) 
	VALUES ('hongGD','홍길동','gil@korea.com',32,'2021-10-21 00:00:00'); 
INSERT INTO tbl_custom(custom_id,name,email,age,reg_date) 
	VALUES ('twice','박모모','momo@daum.net',29,'2021-12-25 00:00:00');
INSERT INTO tbl_custom(custom_id,name,email,age,reg_date) 
	VALUES ('wonder','이나나','lee@naver.com',40,default); --default는 생략 가능

--2) tbl_product 데이터 --실행함
INSERT INTO tbl_product(pcode,category,pname,price)
	VALUES ('IPAD011','A1','아이패드10',880000);
INSERT INTO tbl_product(pcode,category,pname,price)
	VALUES ('DOWON123a','B1','동원참치선물세트',54000);
INSERT INTO tbl_product(pcode,category,pname,price)
	VALUES ('dk_143','A2','모션데스크',234500);

--2) tbl_buy 데이터
INSERT INTO tbl_buy(custom_id,pcode,quantity,BUY_DATE)
	VALUES ('mina012','IPAD011',1,to_date('2022-02-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy(custom_id,pcode,quantity,BUY_DATE)
	VALUES ('hongGD','IPAD011',2,to_date('2022-06-29 20:37:47','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy(custom_id,pcode,quantity,BUY_DATE)
	VALUES ('wonder','DOWON123a',3,to_date('2022-02-06 00:00:00','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy(custom_id,pcode,quantity,BUY_DATE)
	VALUES ('mina012','dk_143',1,default);
INSERT INTO tbl_buy(custom_id,pcode,quantity,BUY_DATE)
	VALUES ('twice','DOWON123a',2,to_date('2022-02-09 08:49:55','YYYY-MM-DD HH24:MI:SS')); 

--3)
ALTER TABLE tbl_buy ADD buyNo number(8);

--4)
UPDATE tbl_buy SET buyNo = 1001 WHERE custom_id = 'mina012';
UPDATE tbl_buy SET buyNo = 1002 WHERE custom_id = 'hongGD';
UPDATE tbl_buy SET buyNo = 1003 WHERE custom_id = 'wonder';
UPDATE tbl_buy SET buyNo = 1004 
	WHERE custom_id = 'mina012' AND pcode = 'dk_143';
UPDATE tbl_buy SET buyNo = 1005 WHERE custom_id = 'twice';

--5)
ALTER TABLE tbl_buy ADD PRIMARY KEY(buyNo);

--6)
ALTER TABLE tbl_buy ADD CONSTRAINT custom_id FOREIGN KEY(custom_id) 
	REFERENCES tbl_custom(custom_id); 
ALTER TABLE tbl_buy ADD CONSTRAINT pcode FOREIGN KEY(pcode) 
	REFERENCES tbl_product(pcode); 
	
--7)
CREATE SEQUENCE tblbuy_seq START WITH 1006;	

--8)

INSERT INTO tbl_buy (buyno,custom_id,pcode,quantity,buy_date)
	VALUES (tblbuy_seq.nextval,'wonder','IPAD011',1,'2022-05-15');

--9.1)
SELECT * FROM tbl_custom WHERE age >= 30;
--9.2)
SELECT email FROM tbl_custom WHERE custom_id = 'twice';
--9.3)
SELECT pname FROM tbl_product WHERE category = 'A2';
--9.4)
SELECT max(price) FROM tbl_product;
--9.5)
SELECT sum(quantity) FROM TBL_BUY quantity WHERE pcode = 'IPAD011';
--9.6)
SELECT * FROM tbl_buy WHERE custom_id = 'mina012';
--9.7)
SELECT * FROM tbl_buy WHERE pcode LIKE '%0%';
--9.8)
SELECT * FROM tbl_buy WHERE LOWER(pcode) LIKE LOWER('%On%');

