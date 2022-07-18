-- 데이터베이스 트리거 : insert, update, delete 할 때 동작하는 프로시저
--		특정 테이블에 속해 있는 객체

CREATE OR REPLACE TRIGGER secure_custom
BEFORE UPDATE OR DELETE ON tbl_custom	--트리거 동작하는 테이블, SQL과 시점
BEGIN 
	IF to_char(sysdate, 'HH24:MI') BETWEEN '13:00' AND '15:00'
	THEN raise_application_error(-20000,'지금 오후 1시~3시는 작업할 수 없습니다.');
	END IF;
END;
--트리거 동작 테스트
DELETE FROM tbl_custom WHERE CUSTOM_ID = 'twice';

--트리거 비활성화 : disable, 활성화 : enable
ALTER TRIGGER secure_custom disable;	--enable

--트리거에 필요한 테이블 사전에 생성
CREATE TABLE TBL_TEMP 
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';

CREATE OR REPLACE TRIGGER cancel_buy
AFTER DELETE ON tbl_buy
FOR EACH ROW 	--만족(적용)하는 행이 여러개일 때
BEGIN 
	--구매 취소(tbl_buy 테이블에서 삭제)한 데이터 tbl_temp 임시 테이블에 insert: 여러행에 대한 작업(행 트리거)
	INSERT INTO TBL_TEMP 
	VALUES
	(:OLD.custom_id, :OLD.pcode, :OLD.quantity, :OLD.buy_date, :OLD.buyno);
END;
--트리거 동작 테스트
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
SELECT * FROM tbl_temp;

--추가 view 생성 연습
--grant resource, connect to c##idev; => 여기에는 view 생성 권한은 없음
--grant create view to c##idev; => 뷰 생성 권한 없는 오류 생기면 추가 권한 부여하기
GRANT CREATE VIEW TO c##idev; 
CREATE VIEW v_buy
AS
SELECT tb.custom_id, tb.pcode, tc.name, tc.email, tb.quantity
FROM tbl_buy tb, tbl_custom tc
WHERE tb.CUSTOM_ID = tc.CUSTOM_ID;
