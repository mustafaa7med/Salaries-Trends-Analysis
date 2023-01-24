# San Francisco Governmental Based Jobs Salaries
## Understanding how salaries are in the government of San Francisco and how it differs.

With many states in the US being kinda different from each other especially in terms of salaries, I was courios to analyize one of the states and in particular
a governmental based jobs.


### Questions answered in this project

- How the average base, overtime, other and total pay differ between different job title?
- What is the highest pay rate in comparison with other job title
- What is the avgerage salary among every 3 employees in the same job differ?
- Ranking top 10 highest paid governmental jobs.
- How salary trends overtime based on each job title?

### Dataset and Tech Stack
- You can download the dataset through the following link on Kaggle
[Kaggle](https://www.kaggle.com/datasets/kaggle/sf-salaries)
- **Tech Stack:** SQLite

```sql
-- How the average base, overtime, other and total pay differ between different job title?

SELECT ROUND(AVG(BasePay)) AS AVG_BASE,
       ROUND(AVG(OvertimePay)) AS AVG_OVERTIME,
       ROUND(AVG(OtherPay)) AS AVG_OTHER,
       ROUND(AVG(TotalPay)) AS AVG_TOTAL
FROM Salaries;
```
**Result:**

| AVG_BASE    |  AVG_OVERTIME  |   AVG_OTHER    |   AVG_TOTAL    |
|     :---:    |     :---:      |     :---:      |     :---:      |
| git status   | git status     | Center-aligned | Center-aligned |
