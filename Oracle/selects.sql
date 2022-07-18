select * from member_tbl_02;
select * from money_tbl_02;


-- 회원매출조회 : 조인과 group by

-- step 1) 회원별 매출합계
SELECT custno, sum(price) FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO;

-- step 2) 정렬 기준 확인하기
SELECT custno, sum(price) asum FROM MONEY_TBL_02 mt 
GROUP BY CUSTNO
ORDER BY asum desc;

-- step 3) custno 컬럼으로 스텝2)와 고객테이블 조인하여 고객정보 전체 가져오기
SELECT * FROM MEMBER_TBL_02 mt ,
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.custno = sale.custno ;
-- 또는
SELECT * FROM MEMBER_TBL_02 mt JOIN
		(SELECT custno, sum(price) AS asum FROM MONEY_TBL_02 mt 
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
ON mt.custno = sale.custno ;


-- step 4) 제시한 요구사항에 따라 컬럼결과 변경하기
SELECT  mt.CUSTNO , 
	mt.CUSTNAME , 
	decode(mt.GRADE,'A','VIP','B','일반','C','직원') AS agrade, 
	sale.asum 
FROM MEMBER_TBL_02 mt ,
		(SELECT CUSTNO, sum(price) AS asum FROM MONEY_TBL_02  
		GROUP BY CUSTNO
		ORDER BY asum desc) sale
WHERE mt.CUSTNO = sale.CUSTNO ;