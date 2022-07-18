--주제: 행을 그룹화 함. 사용하는 순서는 아래처럼 함
--SELECT 문 
--[WHERE] 그룹화 하기 전에 사용할 조건식
--GROUP BY 그룹화에 사용할 컬럼명
--[HAVING] 그룹화 결과에 대한 조건식
--[ORDER BY] 그룹화 결과 정렬 컬럼명과 방식

SELECT PCODE, count(*) FROM TBL_BUY tb GROUP BY PCODE;
SELECT pcode, count(*), sum(quantity)
	FROM TBL_BUY tb 
	GROUP BY PCODE 
	ORDER BY 2;		--조회된 컬럼의 위치

SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	GROUP BY PCODE 
	ORDER BY cnt;	--그룹함수 결과의 별칭

--그룹화 후에 수량 합계가 3 이상만 조회	
SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	GROUP BY PCODE 
--	HAVING total >= 3	--having 에는 컬럼 별칭 사용 못함. 테이블 컬럼명은 사용할 수 있음
	HAVING sum(QUANTITY) >= 3
	ORDER BY cnt;	--그룹함수 결과의 별칭

--구매날짜 2022-04-01 이후인 것만 그룹하여 조회
SELECT pcode, count(*) cnt, sum(quantity) total
	FROM TBL_BUY tb 
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY pcode
	ORDER BY cnt;
--Day2 참고
--통계 함수 : count,avg,max,min. 통계함수는 그룹함수라고도 함
--			해당 함수 결과값을 구하기 위해 특정 컬럼 사용하여 여러 데이터를 그룹화한 후 실행

SELECT count(*) FROM employees e; --테이블 전체 데이터 갯수 : 107
SELECT max(salary) FROM employees e; -- salary 컬럼의 최대값 : 24000
SELECT min(salary) FROM employees e; -- 최소값 : 2100
SELECT avg(salary) FROM employees e; -- 평균값 : 6461.83...
SELECT min(salary) FROM employees e; -- 합계 : 691416
