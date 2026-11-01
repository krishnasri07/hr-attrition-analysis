-- ============================================================
-- Phase 4: Exploratory Analysis (SQL)
-- HR Analytics & Employee Attrition Project
--
-- Run each section in DB Browser's Execute SQL tab.
-- These are read-only SELECTs — safe to run in any order,
-- nothing here modifies employees_clean.
-- ============================================================


-- ============================================================
-- SECTION A: Headline KPIs (Dashboard Page 1 numbers)
-- ============================================================

SELECT
    COUNT(*) AS total_employees,
    SUM(AttritionFlag) AS employees_left,
    ROUND(100.0 * SUM(AttritionFlag) / COUNT(*), 2) AS attrition_rate_pct,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(AVG(MonthlyIncome), 0) AS avg_monthly_income,
    ROUND(AVG(YearsAtCompany), 1) AS avg_years_at_company
FROM employees_clean;


-- ============================================================
-- SECTION B: Mean vs Median (shows income skew — important stat)
-- ============================================================

-- Median MonthlyIncome (overall)
SELECT AVG(MonthlyIncome) AS median_monthly_income
FROM (
    SELECT MonthlyIncome FROM employees_clean
    ORDER BY MonthlyIncome
    LIMIT 2 - (SELECT COUNT(*) FROM employees_clean) % 2
    OFFSET (SELECT (COUNT(*) - 1) / 2 FROM employees_clean)
);

-- Median YearsAtCompany (overall)
SELECT AVG(YearsAtCompany) AS median_years_at_company
FROM (
    SELECT YearsAtCompany FROM employees_clean
    ORDER BY YearsAtCompany
    LIMIT 2 - (SELECT COUNT(*) FROM employees_clean) % 2
    OFFSET (SELECT (COUNT(*) - 1) / 2 FROM employees_clean)
);

-- Mean vs Median income, split by Attrition (leavers vs stayers)
WITH ranked AS (
    SELECT
        Attrition,
        MonthlyIncome,
        ROW_NUMBER() OVER (PARTITION BY Attrition ORDER BY MonthlyIncome) AS rn,
        COUNT(*) OVER (PARTITION BY Attrition) AS cnt
    FROM employees_clean
)
SELECT
    e.Attrition,
    COUNT(*) AS n,
    ROUND(AVG(e.MonthlyIncome), 0) AS mean_income,
    (SELECT ROUND(AVG(r.MonthlyIncome), 0) FROM ranked r
     WHERE r.Attrition = e.Attrition AND r.rn IN ((r.cnt+1)/2, (r.cnt+2)/2)) AS median_income
FROM employees_clean e
GROUP BY e.Attrition;

-- Mean tenure, leavers vs stayers (simple and very tellable in interviews)
SELECT
    Attrition,
    COUNT(*) AS n,
    ROUND(AVG(YearsAtCompany), 2) AS avg_years_at_company,
    ROUND(AVG(TotalWorkingYears), 2) AS avg_total_working_years
FROM employees_clean
GROUP BY Attrition;


-- ============================================================
-- SECTION C: Attrition Rate by Category (Dashboard Page 1 & 2)
-- ============================================================

SELECT Department, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY Department ORDER BY attrition_rate_pct DESC;

SELECT JobRole, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY JobRole ORDER BY attrition_rate_pct DESC;

SELECT OverTime, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY OverTime ORDER BY attrition_rate_pct DESC;

SELECT AgeBand, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY AgeBand ORDER BY AgeBand;

SELECT TenureBand, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY TenureBand ORDER BY TenureBand;

SELECT SalaryBand, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY SalaryBand ORDER BY attrition_rate_pct DESC;

SELECT JobSatisfaction, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY JobSatisfaction ORDER BY JobSatisfaction;

SELECT WorkLifeBalance, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY WorkLifeBalance ORDER BY WorkLifeBalance;

SELECT MaritalStatus, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY MaritalStatus ORDER BY attrition_rate_pct DESC;

SELECT BusinessTravel, COUNT(*) AS total, SUM(AttritionFlag) AS left_count,
       ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean GROUP BY BusinessTravel ORDER BY attrition_rate_pct DESC;

-- Promotion gap: years since last promotion, leavers vs stayers
SELECT Attrition, COUNT(*) AS n,
       ROUND(AVG(YearsSinceLastPromotion), 2) AS avg_years_since_promotion
FROM employees_clean GROUP BY Attrition;


-- ============================================================
-- SECTION D: Cross-Tabulation (OverTime x JobSatisfaction x Attrition)
-- This answers: "Is overtime associated with attrition, and does it
-- get worse when combined with low satisfaction?" — exactly the kind
-- of question the project brief calls out.
-- ============================================================

SELECT
    OverTime,
    JobSatisfaction,
    COUNT(*) AS total,
    SUM(AttritionFlag) AS left_count,
    ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean
GROUP BY OverTime, JobSatisfaction
ORDER BY OverTime, JobSatisfaction;


-- ============================================================
-- SECTION E: High-Risk Segment Identification
-- Combines multiple risk factors to find the worst-affected group
-- (feeds directly into Dashboard Page 3 "High-Risk Segments")
-- ============================================================

SELECT
    OverTime,
    MaritalStatus,
    WorkLifeBalance,
    COUNT(*) AS total,
    SUM(AttritionFlag) AS left_count,
    ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct
FROM employees_clean
GROUP BY OverTime, MaritalStatus, WorkLifeBalance
HAVING COUNT(*) >= 15   -- avoid tiny, unstable sample sizes
ORDER BY attrition_rate_pct DESC
LIMIT 10;


-- ============================================================
-- SECTION F: Department x Job Role performance view
-- (feeds Dashboard Page 3 "Department performance")
-- ============================================================

SELECT
    Department,
    JobRole,
    COUNT(*) AS total,
    SUM(AttritionFlag) AS left_count,
    ROUND(100.0*SUM(AttritionFlag)/COUNT(*),2) AS attrition_rate_pct,
    ROUND(AVG(MonthlyIncome),0) AS avg_income,
    ROUND(AVG(YearsAtCompany),1) AS avg_tenure
FROM employees_clean
GROUP BY Department, JobRole
ORDER BY Department, attrition_rate_pct DESC;