--DDL : create, drop, alter, TRUNCATE 
--	(대상은 user, table, sequence, view, ... 단 truncate 는 테이블만 사용)
--DML : select, insert, update, merge, delete => 트랜잭션으로 관리됨

/*
DROP TABLE STUDENTS;	--오류 : students 테이블 먼저 삭제하면 
		--원인 : 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다.
DROP TABLE SCORES;
*/

--UPDATE 테이블명 SET 컬럼명 = 값, 컬럼명 = 값, 컬럼명 = 값, ... 
--	WHERE 조건 컬럼 관계식
--DELETE FROM 테이블명 WHERE 조건 컬럼 관계식
--주의할 점: UPDATE 와 DELETE 는 WHERE 없이 사용하는 것은 위험한 동작
--		  모든 데이터를 삭제할 때는 DELETE 대신에 TRUNCATE 사용함
--		  TRUNCATE 는 실행을 취소(rollback) 할 수 없기 때문에 DDL에 속함

SELECT * FROM STUDENTS s ;
-- UPDATE, DELETE, SELECT 에서 WHERE 의 컬럼이 기본키 컬럼이면
-- 		실행되는 결과 반영되는 행은 몇개? 최대 1개
--		기본키의 목적은 테이블의 여러 행들을 구분(식별)
UPDATE STUDENTS SET age = 17 WHERE STUDENT_NO = 2021001;

--rollback 테스트 (데이터베이스 메뉴에서 트랜잭션 모드를 manual로 변경함)
UPDATE STUDENTS SET ADDRESS = '성북구', age = 16 WHERE STUDENT_NO = 2021001;
ROLLBACK;	--위의 UPDATE 실행을 취소
SELECT * FROM STUDENTS;		-- 다시 '서초구', 17세로 복구
UPDATE STUDENTS SET ADDRESS = '성북구', age = 16 WHERE STUDENT_NO = 2021001;
COMMIT;
SELECT * FROM STUDENTS;	-- '성북구', 16세로 반영됨
ROLLBACK;
SELECT * FROM STUDENTS;	--이미 COMMIT이 된 명령어는 ROLLBACK 못함
-------------------------------------------
-- 트랜잭션 관리 명령 : ROLLBACK, COMMIT
DELETE FROM SCORES;
ROLLBACK;
SELECT * FROM SCORES;
DELETE FROM SCORES WHERE STUDENT_NO = 2019019;
SELECT * FROM SCORES;
--39라인 실행했을 때
-- 이 편집기는 트랜잭션 수동 모드이고 같은 창에서는 SELECT 결과가 2019019가 없음
-- 다른 편집기는 다른 클라이언트 이므로 이전 상태(최종 커밋한 상태)로 보여짐
ROLLBACK;
SELECT * FROM STUDENTS;

-------------------------------------------
TRUNCATE TABLE SCORES;		--모든 데이터를 지움. ROLLBACK 여부 확인?
							-- 답 : ROLLBACK 불가
-- 모든 데이터를 지울 것이 확실하면 다른 것들과 섞여서 롤백되지 않게 확실하게 TRUNCATE 하기
-------------------------------------------
/*
 * INSERT
 * DELETE
 * COMMIT;		(1) 라인 51, 52
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2)	라인 54, 55
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3)	라인 57, 58
 * INSERT
 * UPDATE;
 * COMMIT;		(4)	라인 60, 61
 */
