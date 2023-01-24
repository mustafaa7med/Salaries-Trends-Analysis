# San Francisco Governmental-Based Jobs Salaries
## Understanding how salaries are in the government of San Francisco and how it differs.

With many states in the US being kinda different from each other, especially in terms of salaries, I was curious to analyze the county of California and in particular governmental-based jobs.


### Questions answered in this project

- How do the average base, overtime, other, and total pay differ?
- What are the highest-paid 10 jobs?
- How does salary trend over time based on each job title?
- What are the 3 top highest-paid jobs segregated by each year?
- What are the top-paid departments?

### Dataset and Tech Stack
- You can download the dataset through the following link on Kaggle
[Kaggle](https://www.kaggle.com/datasets/kaggle/sf-salaries)
- **Tech Stack:** SQLite
- **Functionalities:** SELECT, Subqueries, GROUP BY, Analytical SQL (RANK, DENSE_RANK, ROWS BETWEEN, AGGREGATE FUNCTIONS, OVER, PARTITION BY)

------------------------------------------------------

```sql
-- How the average base, overtime, other and total pay differ?
SELECT ROUND(AVG(BasePay)) AS AVG_BASE,
       ROUND(AVG(OvertimePay)) AS AVG_OVERTIME,
       ROUND(AVG(OtherPay)) AS AVG_OTHER,
       ROUND(AVG(TotalPay)) AS AVG_TOTAL
FROM Salaries;
```
**Output:**

|  AVG_BASE    |  AVG_OVERTIME  |   AVG_OTHER    |   AVG_TOTAL    |
|     :---:    |     :---:      |     :---:      |     :---:      |
| 66054        | 5066           |       3649     |  74768         |

**Insight:**
- Overtime and other pay benefits are not a huge factor in terms of the total pay.

------------------------------------------------------

```sql
-- What are the highest paid 10 jobs?
SELECT JobTitle, ROUND(TotalPay)
FROM (SELECT DISTINCT JobTitle,
					  TotalPay,
					  DENSE_RANK() OVER(PARTITION BY JobTitle ORDER BY TotalPay DESC) AS RNK
					  FROM Salaries) AS Ranked_Data
WHERE Ranked_Data.RNK = 1
LIMIT 10;
```
**Output:**

|  JobTitle    |  MAX_SALARY    |
|     :---:    |     :---:    |
| ADMINISTRATIVE ENGINEER | 149322.23 |
| ADMINISTRATIVE ANALYST III | 92847 |
| ADMINISTRATIVE SERVICES MANAGER | 92002 |
| ADMINISTRATIVE ANALYST | 79754.03 |
| ADMINISTRATIVE ANALYST II | 75585.82 |
| ACUPUNCTURIST | 67594.4 |
| ACCOUNTANT | 65392.01 |
| ACPO,JuvP, Juv Prob (SFERS) | 62290.78 |
| ACCOUNT CLERK | 60838.2 |
| ACCOUNTANT INTERN | 58799.53 |

**Insight:**
- Half of the top highest paid employees do have an administrative role.

------------------------------------------------------

```sql

-- How salary trends overtime based on each job title?
SELECT Year, ROUND(AVG(TotalPay)) AS AVG_TOTAL_PAY,
			 ROUND(AVG(BasePay)) AS AVG_BASE_PAY,
			 ROUND(AVG(OvertimePay)) AS AVG_OVERTIME_PAY,
			 ROUND(AVG(OtherPay)) AS AVG_OTHER_PAY
FROM Salaries
GROUP BY Year
ORDER BY Year, AVG_TOTAL_PAY;
```

**Output:**

|  Year  |  AVG_TOTAL_PAY |  AVG_BASE_PAY |  AVG_OVERTIME_PAY |  AVG_OTHER_PAY |  
|     :---:  |   :---:    |   :---:    |   :---:    |   :---:    |    
|  2011 | 71744 | 63596 | 4531 | 3617 | 
|  2012 | 74113 | 65436 | 5023 | 3653 | 
|  2013 | 77611 | 68510 | 5282 | 3820 | 
|  2014 | 75464 | 66557 | 5401 | 3505 | 

**Insight:**
- The average pay rate has increased from 2011 till 2013 yet it declined.
- Despite the increase in the average pay rate of overtime yet the base salary itself got declined.

------------------------------------------------------

```sql
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
```
**Output:**

|  JobTitle   |  Year   |  TotalPay   | 
|     :---:  |     :---:  |     :---:  |  
|  GENERAL MANAGER-METROPOLITAN TRANSIT AUTHORITY | 2011 | 567595.43 |
|  CAPTAIN III (POLICE DEPARTMENT) | 2011 | 538909.28 |
|  CAPTAIN III (POLICE DEPARTMENT) | 2011 | 335279.91 |
|  Lieutenant, Fire Suppression | 2012 | 362844.66 |
|  Captain 3 | 2012 | 350403.41 |
|  EMT/Paramedic/Firefighter |2012 | 337204.86 | 
|  Battalion Chief, Fire Suppress | 2013 | 347102.32 |
|  Chief of Police |  2013 | 339282.07 |
|  Chief, Fire Department |  2013 | 336922.01 |
|  Deputy Chief 3 |  2014 | 471952.64 |
|  Asst Med Examiner |   2014 | 390111.98 |
|  Asst Med Examiner |   2014 | 344187.46 |

**Insight:**
- The trend among the top 3 jobs in 2011 and 2014 is fluctuating from top to bottom.
- Yet the salary is kind of on a similar scale in terms of 2012 and 2013.
- Captain III recorded the top 2 and 3 highest paid roles in 2011 while Asst Med Examiner recorded the highest 2 and 3 in 2014.

------------------------------------------------------

```sql
-- What are the top paid departments?
SELECT DISTINCT JobTitle,
                MAX(TotalPay) AS MAX_PAY
FROM Salaries
GROUP BY JobTitle
HAVING JobTitle LIKE '%DEPARTMENT%'
ORDER BY MAX_PAY DESC
LIMIT 10;
```
**Output:**

|  JobTitle   |  MAX_PAY   |
|     :---:  |     :---:  |
| CAPTAIN III (POLICE DEPARTMENT) | 538909.28 |
| Chief, Fire Department | 336922.01 |
| DEPUTY CHIEF OF DEPARTMENT,(FIRE DEPARTMENT) | 326373.19 | 
| BATTALION CHIEF, (FIRE DEPARTMENT) | 315981.05 |
| CHIEF OF DEPARTMENT, (FIRE DEPARTMENT) | 302377.73 |
| ASSISTANT CHIEF OF DEPARTMENT, (FIRE DEPARTMENT) | 299494.17 | 
| DEPARTMENT HEAD V | 292671.62 |
| COMMANDER III, (POLICE DEPARTMENT) | 286213.86 | 
| DEPUTY CHIEF III (POLICE DEPARTMENT) | 264074.6 |
| INSPECTOR III, (POLICE DEPARTMENT) | 258588.39 |

**Insight:**
- Overall, both Police and Fire departments do have the highest-paid employees.
------------------------------------------------------

## 🔗 Get In Touch
[![Email](https://img.shields.io/badge/Email_Me-000?style=for-the-badge&logo=ko-fi&logoColor=white)](mailto:mustafaa7med@gmail.com)

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mustafaa7med)
