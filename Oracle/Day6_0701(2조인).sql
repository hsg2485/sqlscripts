-- 예제. custom_id 'mina012'이 구매한 내용 조회 : pcode 조회하고 pname은 알 수 없음
SELECT pcode FROM tbl_buy WHERE CUSTOM_ID = 'mina012';

--1. 서브쿼리 (select 안에 select를 사용함)
SELECT pname FROM TBL_PRODUCT tp	--외부 쿼리
	WHERE pcode = 		--조건식이 = 연산이므로 내부 쿼리는 1개 행 결과이어야 함
	(SELECT pcode FROM TBL_BUY tb WHERE custom_id = 'mina012' --내부 쿼리
							AND buy_date = '2022-02-06');
SELECT pname FROM TBL_PRODUCT tp 
	WHERE pcode IN 		--조건식이 IN 연산이므로 내부 쿼리는 여러개 행 결과 가능함
	(SELECT pcode FROM TBL_BUY tb WHERE custom_id = 'mina012');
	
--내부 쿼리 테스트
SELECT pcode FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'
							AND BUY_DATE = '2022-02-06';
SELECT pcode FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';

--서브 쿼리 문제점 : 외부 쿼리가 조건식을 모드행에 대해 검사할 때마다 내부쿼리가 실행되므로
--				 처리 속도에 문제가 생김 ==> 테이블의 조인 연산 사용으로 개선함

-- 2. SELECT 의 테이블 JOIN : 둘 이상의 테이블(주로 참조관계의 테이블)을 연결하여 데이터를 조회하는 명령
-- 동등 조인 : 둘 이상의 테이블은 공통된 컬럼을 갖고 이 컬럼값이 '같다(=)'를 이용하여 join 합니다.
-- 형식1 : select ~~~ from 테이블1 a,테이블2 b 
--					where a.공통컬럼1=b.공통컬럼1;

--예제를 위해 상품 추가
INSERT INTO tbl_product(pcode,category,pname,price)
	VALUES ('GALAXYS22','A1','갤럭시s22',555600);
--JOIN 키워드 없는 형식 1
SELECT * FROM TBL_PRODUCT tp ,TBL_BUY tb 	--조인할 테이블 2개
		WHERE tp.PCODE = tb.PCODE; --동등 조인. 조인 컬럼으로 = 연산식

--JOIN 키워드를 쓰는 명령문 형식 2(ANSI 표준)
SELECT * FROM TBL_PRODUCT tp 
		JOIN TBL_BUY tb
		ON tp.PCODE = tb.PCODE;	--동등 조인. 조인 컬럼으로 = 연산식
		
--간단 테스트 : tbl_custom 과 tbl_buy 를 조인 해보기
--1
SELECT * FROM TBL_CUSTOM tc , TBL_BUY tb 
	WHERE tc.CUSTOM_ID = tb.CUSTOM_ID;
--2
SELECT * FROM TBL_CUSTOM tc JOIN TBL_BUY tb ON tc.CUSTOM_ID = tb.CUSTOM_ID;

--조인한 결과에서 특정 컬럼만 조회
SELECT tc.custom_id,name,reg_date,pcode,quantity 
	FROM TBL_CUSTOM tc ,TBL_BUY tb
	WHERE tc.CUSTOM_ID = tb.CUSTOM_ID;

--조인조건 외에 다른 조건을 추가
SELECT tc.custom_id,name,reg_date,pcode,quantity 
	FROM TBL_CUSTOM tc ,TBL_BUY tb
	WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND tc.CUSTOM_ID = 'mina012';

--mina012가 구매한 상품명은 무엇인가 조회하기
SELECT tp.pname FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';
SELECT tp.pname FROM TBL_PRODUCT tp JOIN TBL_BUY tb
	ON tp.PCODE = tb.PCODE AND custom_id = 'mina012';
SELECT tp.pname FROM TBL_PRODUCT tp JOIN TBL_BUY tb
	ON tp.PCODE = tb.PCODE AND custom_id = 'mina012' 
						   AND buy_date = '2022-02-06';

--mina012가 구매한 상품명과 가격 조회하기
SELECT tp.name, tp.price FROM TBL_PRODUCT tp , TBL_BUY tb 
		WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';
--조인할 때, 이름이 같은 컬럼은 테이블명을 꼭 지정해야 함
	
--3개의 테이블을 조인할 수 있을까?
SELECT * FROM TBL_PRODUCT tp,
	(SELECT tc.custom_ID,name,email,age,REG_DATE,pcode,quantity,buy_date,buyno 
		FROM TBL_CUSTOM tc ,TBL_BUY tb 
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID) temp --첫번째 조인
WHERE tp.PCODE = temp.pcode;	--두번째 조인

SELECT * FROM TBL_BUY tb ,TBL_CUSTOM tc ,TBL_PRODUCT tp 
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND tp.PCODE = tb.PCODE;

--특정 컬럼만 조회하기
SELECT tb.custom_ID,tb.pcode,name,age,pname,quantity,buy_date
		FROM TBL_BUY tb ,TBL_CUSTOM tc,TBL_PRODUCT tp 
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND tp.PCODE = tb.PCODE;

--3. 외부 조인(outer join) : = 연산을 사용하는 조인이나 한쪽에 없는 값도 조인 결과로 포함
--JOIN 키워드 없는 형식 1
SELECT * FROM TBL_PRODUCT tp ,TBL_BUY tb 	--조인할 테이블 2개
		WHERE tp.PCODE = tb.PCODE(+); 
		--외부 조인 tbl_buy 테이블에 일치하는 pcode 값이 없어도 조인.
		--조인했을 때 null이 되는 테이블의 컬럼에 (+)기호

--JOIN 키워드를 쓰는 명령문 형식 2(ANSI 표준)
SELECT * FROM TBL_PRODUCT tp 
		LEFT OUTER JOIN TBL_BUY tb
		ON tp.PCODE = tb.PCODE;	--tbl_product가 왼쪽 테이블이며 그 값을 모두 포함하여 조인

SELECT * FROM TBL_BUY tb 
		RIGHT OUTER JOIN TBL_PRODUCT tp 
		ON tb.PCODE = tp.PCODE;
