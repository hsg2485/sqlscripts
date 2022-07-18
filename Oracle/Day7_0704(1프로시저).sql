-- PL/SQL : Procedure(절차,순서) , 기존의 단순한 SQL이 확장된 언어(sql로 만드는 프로그램)
--			변수,제어문(if,반복문)을 사용하여 프로그래밍언어와 같이 sql 실행의 흐름을 제어

--주의 : dbeaver는 프로시저의 디버깅 기능이 없음(디버깅 하려면 sql developer 사용)
DECLARE   -- 변수선언부  
	--vcustomid varchar2(20);
	--vage number(3,0);
	vname tbl_custom.name %TYPE;	--지정된 테이블의 컬럼과 동일 형식의 변수
	vage tbl_custom.age %TYPE;
BEGIN		--프로시저 시작
-- 프로시저 내부에는 주로 DML 명령문들을 작성.(함께 실행해야할 여러 SQL : 트랜잭션)
	SELECT name,age 
	INTO vname , vage	-- 프로시저 구문: 검색결과를 변수에 저장
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID ='hongGD';		-- 1개 행만 결과 조회되는 조건
									-- 여러개 행 조회될 때는 다른 cursor 필요
	
-- 변수값을 콘솔에 출력(프로시저 명령)
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || vname);	--||는 문자열 연결 연산
	DBMS_OUTPUT.PUT_LINE('고객나이 : ' || vage);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN   -- 예외 이름은 다양합니다. ex) no_data_found 
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
END;

-- 오라클 객체 프로시저 생성하기 : 검색할 값을 매개변수로 전달하기
CREATE OR REPLACE PROCEDURE search_custom(	--프로시저 이름 설정
	c_id IN tbl_custom.CUSTOM_ID %TYPE 	--매개변수 IN 
)										--리턴값 OUT 

IS 
	--일반 변수 선언
	vname tbl_custom.name %TYPE;	--지정된 테이블의 컬럼과 동일 형식의 변수
	vage tbl_custom.age %TYPE;
BEGIN		
	SELECT name,age 
	INTO vname , vage	
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID =c_id;		-- 1개 행만 결과 조회되는 조건
									

	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || vname);	
	DBMS_OUTPUT.PUT_LINE('고객나이 : ' || vage);
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
END;

--프로시저 실행
BEGIN
	search_custom('wonder');
END;

--출력(리턴값)이 있는 프로시저 정의
CREATE OR REPLACE PROCEDURE search_custom2(	--프로시저 이름 설정
	c_id IN tbl_custom.CUSTOM_ID %TYPE, 	--매개변수 IN
	c_name OUT tbl_custom.NAME %TYPE 
)										--리턴값 OUT 

IS 
	--일반 변수 선언
	--vname tbl_custom.name %TYPE;	--지정된 테이블의 컬럼과 동일 형식의 변수
	--vage tbl_custom.age %TYPE;
BEGIN		
	SELECT name
	INTO c_name	
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID =c_id;		-- 1개 행만 결과 조회되는 조건
									
	DBMS_OUTPUT.PUT_LINE('고객을 검색하였습니다. : ' || c_name);	
	EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN   
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
		c_name := 'no match';	--대입문 := 기호
END;

--출력(리턴값)이 있는 프로시저 실행 : 출력값 저장을 위한 변수 필요함
DECLARE
	vname tbl_custom.name %TYPE;
BEGIN
	search_custom2('momo',vname);	--vname은 프로시저 정의할 때 out으로 선언
--	vname := search_custom2('mina012'); 과 같은 형식 아님
	dbms_output.put_line('*고객 이름 : ' || vname);
END;

--BEGIN ~ END 에는 하나의 트랜잭션을 구성하는 DML(insert,update,delete 위주) 명령들로 구성
--		오류가 생기면 EXCEPTION 에서 rollback, 오류가 없을때만 commit;

--프로시저에 쓸 수 있는 몇가지 SQL
--동일한 구조를 갖는 테이블 만들기
CREATE TABLE tbl_temp
AS
SELECT * FROM tbl_custom WHERE CUSTOM_ID = '0';

--select한 결과를 insert 하기
INSERT INTO tbl_temp (SELECT * FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'wonder');

SELECT * FROM TBL_TEMP tt;

--Function 오라클 객체와 비교
--오라클 함수 : upper, lower, decode, round, to_date, to_char,...
--Function은 사용자 함수를 정의함. 테이블을 대상으로 하는 것이 아니라 특정 테이블을 조작하는 동작.


