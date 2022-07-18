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
	(tbl_seq1.nextval, '이하니', 'honey@naver.com', '010-9889-0567', '1122');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '이세종', 'jong@daum.net', '010-2354-6773', '2345');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '최행운', 'lucky@korea.com', '010-5467-8792', '9876');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '나길동', 'nadong@kkk.net', '010-3456-8765', '3456');
insert into book_member(mem_idx, name, email, tel, password) values 
	(tbl_seq1.nextval, '강감찬', 'haha@korea.net', '010-3987-9087', '1234');

insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1101', '코스모스', '칼세이건', '사이언스북스', '2006-12-01');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('B1101', '해커스토익', '이해커', '해커스랩', '2018-07-10');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('C1101', '푸른사자 와니니', '이현', '창비', '2015-06-20');
insert into tbl_book(bcode, title, writer, publisher, pdate) values
	('A1102', '페스트', '알베르트 까뮈', '민음사', '2011-03-01');

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

--참고하기 : '대여' 기본적인 동작은 대여날짜는 오늘, 반납기한은 오늘+14를 기본값으로 할 수 있도록 함
--alter table "C##IDEV".TBL_BOOKRENT modify rent_date date default sysdate;
--alter table "C##IDEV".TBL_BOOKRENT modify exp_date date default sysdate+14;
--insert into TBL_BOOKRENT (rent_no, mem_idx, bcode)
--	values (bookrent_seq.nextval, 10002, 'A1102');

--컬럼 디폴트 값 없애고 싶을 때
--alter table "C##IDEV".TBL_BOOKRENT modify rent_date date default null;

------------------'도서대여 처리사항'-----------------
/*
 * 도서를 추가합니다. ‘B1102’ , ‘스트라이크 던지기’, ‘박철순’ ,’KBO’ , ‘2020-11-10’’
반납된 도서의 연체일수를 계산하여 delay_days 컬럼값을 update 합니다.
현재 연체 중인 회원의 이름,전화번호를 검색합니다.
현재 대출중인 도서의 도서명코드와 도서명 검색합니다. (return_date가 null이면 대여중, null이 아니면 반납된 도서)
현재 도서를 대여한 회원의 IDX와 회원이름을 검색합니다.
현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한을 검색합니다.
회원  IDX ‘10002’는 도서 대출이 가능한지 프로시저를 작성합니다.
도서명에 ‘스트’ 라는 글자가 들어가는 도서를 검색하여 도서 대출이 가능한지 프로시저를 작성합니다.
6과 7을 이용해서 insert 를 하는 프로시저를 작성합니다
 */

--도서를 추가합니다. ‘B1102’ , ‘스트라이크 던지기’, ‘박철순’ ,’KBO’ , ‘2020-11-10’
INSERT INTO TBL_BOOK(bcode, title, writer, publisher, pdate) VALUES 
	('B1102', '스트라이크 던지기', '박철순', 'KBO', '2020-11-10');

--반납된 도서의 연체일수를 계산하여 delay_days 컬럼값을 update 합니다.
UPDATE TBL_BOOKRENT SET DELAY_DAYS = RETURN_DATE - EXP_DATE
	WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT tb;

--대출중인 도서의 연체일수 계산해서 회원IDX, 도서코드, 연체일수 조회하기
--sysdate는 년월일 패턴이 지정되지 않아 그냥하면 long값으로 계산됨
SELECT MEM_IDX, bcode, to_date(to_char(sysdate,'yyyy-mm-dd')) - exp_date 
	FROM TBL_BOOKRENT tb WHERE return_date IS NULL;
		-----또는
SELECT MEM_IDX, bcode, trunc(sysdate) - exp_date 	--trunc(sysdate)는 sysdate의 시간부분은 버림
	FROM TBL_BOOKRENT tb WHERE return_date IS NULL;

--현재 연체 중인 회원의 이름,전화번호를 검색합니다. (오늘 날짜 sysdate 기준으로 확인하기)
--현재 기준으로 연체중인 것은 반납기한 < 현재날짜
SELECT NAME, TEL FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
	ON bm.MEM_IDX = tb.MEM_IDX AND sysdate > EXP_DATE  AND return_date IS NULL;

--현재 대출중인 도서의 도서명코드와 도서명 검색합니다
SELECT tb.BCODE, TITLE FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2 
	ON tb.BCODE = tb2.BCODE AND return_date IS NULL;

--현재 도서를 대여한 회원의 IDX와 회원이름을 검색합니다.
SELECT bm.MEM_IDX, NAME FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb 
	ON bm.MEM_IDX = tb.MEM_IDX AND return_date IS NULL;

--대출중인 도서의 회원이름, 도서명, 반납기한 검색(DM 제출)
SELECT bm.NAME, tb.TITLE, tb2.EXP_DATE FROM BOOK_MEMBER bm, TBL_BOOK tb, TBL_BOOKRENT tb2
	WHERE tb2.MEM_IDX = bm.MEM_IDX AND tb2.BCODE = tb.BCODE AND return_date IS null;
		--또는--
SELECT name, title, exp_date FROM TBL_BOOKRENT tb  
	JOIN TBL_BOOK tb2 ON tb.BCODE = tb.BCODE 
	JOIN BOOK_MEMBER bm ON tb.MEM_IDX = bm.MEM_IDX
	WHERE return_date IS NULL;

--현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한을 검색합니다.
SELECT mem_idx, bcode, exp_date FROM TBL_BOOKRENT tb 
	WHERE SYSDATE > EXP_DATE;

--회원  IDX '10002'는 도서 대출이 가능한지 프로시저를 작성합니다.

	--일회용으로 실행하는 프로시저
	DECLARE
		vcnt NUMBER;
	BEGIN
		SELECT count(*) INTO vcnt 
		FROM TBL_BOOKRENT tb 
		WHERE MEM_IDX = 10002 AND return_date IS NULL; --rcnt가 0일때만 대여 가능	
		IF (vcnt = 0) THEN
			dbms_output.put_line('책 대여 가능합니다.');
		ELSE 
			dbms_output.put_line('대여중인 책을 반납해야 가능합니다.');
		END IF;
	END;
	
	--프로시저 오라클 객체
	CREATE OR REPLACE PROCEDURE CHECK_MEMBER(
		arg_mem IN book_member.MEM_IDX%TYPE,	--프로시저 실행할 때 값을 받을 매개 변수
		isOK OUT varchar2		--자바의 리턴값에 해당하는 부분
	)
		IS 
		vcnt NUMBER;
		vname varchar2(100);
		BEGIN
			--입력 매개변수가 없는 회원인가를 확인하는 sql과 exception 처리. arg_mem으로 회원테이블에서 name 조회
			--	없으면 exception 처리
			SELECT name INTO vname
				FROM BOOK_MEMBER bm WHERE MEM_IDX = arg_mem;
			SELECT count(*) 
			INTO vcnt 	--SELECT 조회 결과 저장할 변수. 여러개 , 로 나열할 수 있음
			FROM TBL_BOOKRENT tb 
			WHERE MEM_IDX = 10002 AND return_date IS NULL; --rcnt가 0일때만 대여 가능	
			IF (vcnt = 0) THEN
				dbms_output.put_line('책 대여 가능합니다.');
				isOK := '가능';
			ELSE 
				dbms_output.put_line('대여중인 책을 반납해야 가능합니다.');
				isOK := '불가능';
			END IF;
		EXCEPTION		-- 예외(오류)처리
		WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('회원이 아닙니다.');
		isOK :='no match';
		END;

	--프로시저 실행하기
	DECLARE
		vresult varchar2(20);
	BEGIN
		check_member(10003,vresult);
		dbms_output.put_line('결과 : ' || vresult);
	END;


--도서명 '페스트' 라는 도서를 검색하여 도서 대출이 가능한지 프로시저를 작성합니다.
DECLARE
	v_bcode varchar2(100);
	v_cnt NUMBER;
BEGIN
	SELECT title INTO v_bcode	--v_bcode는 'A1102'
		FROM TBL_BOOK tb WHERE TITLE = '페스트';
	SELECT count(*) INTO v_cnt --v_cnt 값이 1이면 v_bcode 책은 대출중
		FROM TBL_BOOKRENT tb2 
		WHERE BCODE = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_output.put_line('대여중인 책입니다.');
	ELSE 
		dbms_output.put_line('책 대여 가능합니다.');
	END IF;
END;

--프로시저 오라클 객체
CREATE OR REPLACE PROCEDURE CHECK_BOOK(
			arg_book IN tbl_book.title%TYPE,	-- 프로시저 실행할때 값을 받을 매개변수
			isOK OUT varchar2		-- 자바의 리턴값에 해당하는 부분.
	)
	IS 
	v_bcode varchar2(100);
 	v_cnt NUMBER;
 BEGIN
 	SELECT bcode INTO v_bcode		-- v_bcode는 'A1102'
 		FROM TBL_BOOK tb WHERE title = arg_book;
	-- 없는 책이름 입력하면 오류. bcode 값이 검색이 안됩니다.-> Exception 
 	SELECT count(*) INTO v_cnt		-- v_cnt 값이 1이면 v_bcode 책은 대출중
		FROM TBL_BOOKRENT tb2 WHERE BCODE = v_bcode AND return_date IS NULL; 
	 IF (v_cnt = 1) THEN 
		DBMS_OUTPUT.put_line('대여 중인 책 입니다.');
		isOK := 'FALSE' ;
  	 ELSE 
		DBMS_OUTPUT.put_line('책 대여 가능합니다.');
		isOK := 'TRUE' ;
  	 END IF;
  	 EXCEPTION		-- 예외(오류)처리
	 WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('찾는 책이 없습니다.');
		isOK :='no match';

END;

/* 위 코드랑 비교해서 오류 찾기!!!!!!!!!!!!!!!!
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
	--없는 책 이름 입력하면 오류. bcode 값이 검색이 안됨 => Exception
	SELECT COUNT(*) INTO v_cnt
		FROM TBL_BOOKRENT tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 1) THEN
		dbms_out.put_line("대여중인 책입니다.");
		isOK := 'FALSE';
	ELSE
		dbms_out.put_line("책 대여 가능합니다.");
		isOK := 'TRUE';
	END IF;
END;
*/



--프로시저 실행하기
DECLARE
	vresult varchar2(100);
BEGIN
	check_book('페스트', vresult);	--코스모스, 푸른사자 와니니는 FALSE
	dbms_output.put_line('결과 : ' || vresult);
END;






