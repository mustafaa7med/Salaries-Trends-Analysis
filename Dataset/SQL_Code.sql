-- How the average base, overtime, other and total pay differ?
SELECT ROUND(AVG(BasePay)) AS AVG_BASE,
       ROUND(AVG(OvertimePay)) AS AVG_OVERTIME,
       ROUND(AVG(OtherPay)) AS AVG_OTHER,
       ROUND(AVG(TotalPay)) AS AVG_TOTAL
FROM Salaries;




-- What are the highest paid 10 jobs?
SELECT JobTitle, ROUND(TotalPay)
FROM (SELECT DISTINCT JobTitle,
					  TotalPay,
					  DENSE_RANK() OVER(PARTITION BY JobTitle ORDER BY TotalPay DESC) AS RNK
					  FROM Salaries) AS Ranked_Data
WHERE Ranked_Data.RNK = 1
LIMIT 10;




-- How salary trends overtime based on each job title?
SELECT Year, ROUND(AVG(TotalPay)) AS AVG_TOTAL_PAY,
			 ROUND(AVG(BasePay)) AS AVG_BASE_PAY,
			 ROUND(AVG(OvertimePay)) AS AVG_OVERTIME_PAY,
			 ROUND(AVG(OtherPay)) AS AVG_OTHER_PAY
FROM Salaries
GROUP BY Year
ORDER BY Year, AVG_TOTAL_PAY;




-- What are the 3 top highest paid jobs segregated by each year?
SELECT JobTitle,
	   Year,
	   TotalPay
FROM (SELECT JobTitle,
			 Year,
			 TotalPay,
			 RANK() OVER(PARTITION BY Year ORDER BY TotalPay DESC) AS RNK
	  FROM Salaries) AS RANKED_DATA
WHERE RANKED_DATA.RNK <= 3;




-- What are the top paid departments?
SELECT DISTINCT JobTitle,
                MAX(TotalPay) AS MAX_PAY
FROM Salaries
GROUP BY JobTitle
HAVING JobTitle LIKE '%DEPARTMENT%'
ORDER BY MAX_PAY DESC
LIMIT 10;