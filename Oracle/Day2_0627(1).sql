-- 데이터 타입 number 연습 테이블 
-- number : 자바에서 정수, 실수 타입에 해당
--			number(정밀도, 소수점 이하 자리수)

CREATE TABLE tbl_number(
	col1 NUMBER,		-- 정밀도 지정 안하면 최대 38자리
	col2 number(5),		-- 정수로 5자리
	col3 number(7,2),	-- 전체 7자리 수, 소수점 이하 2자리
	col4 NUMBER(2,5)	-- 소수점 이하 5자리, 유효숫자 2자리
);
-- 유효 숫자 : 12300 또는 00123 중에 첫번째 00은 유효값, 두번째 00은 불필요
-- 정상 실행 값 테스트 1
INSERT INTO tbl_number VALUES (1234567,12345,12345.67,0.00012);