-- ============================================================
-- Phase 3: Clean & Prepare Data
-- HR Analytics & Employee Attrition Project
--
-- What this script does:
--   1. Drops constant/zero-information columns
--      (EmployeeCount, Over18, StandardHours)
--   2. Creates derived segmentation columns:
--      AgeBand, TenureBand, SalaryBand
--   3. Creates a numeric AttritionFlag (1/0) for stats/DAX use
--   4. Outputs a clean table: employees_clean
--
-- Run this in DB Browser for SQLite -> Execute SQL tab.
-- After running, click "Write Changes" to save it to the .db file.
-- ============================================================

DROP TABLE IF EXISTS employees_clean;

CREATE TABLE employees_clean AS
SELECT
    EmployeeNumber,
    Age,
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '46-60'
    END AS AgeBand,

    Attrition,
    CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END AS AttritionFlag,

    BusinessTravel,
    Department,
    DistanceFromHome,
    Education,
    EducationField,
    EnvironmentSatisfaction,
    Gender,
    HourlyRate,
    JobInvolvement,
    JobLevel,
    JobRole,
    JobSatisfaction,
    MaritalStatus,

    MonthlyIncome,
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low (<3K)'
        WHEN MonthlyIncome BETWEEN 3000 AND 6999 THEN 'Medium (3K-7K)'
        WHEN MonthlyIncome BETWEEN 7000 AND 12999 THEN 'High (7K-13K)'
        ELSE 'Very High (13K+)'
    END AS SalaryBand,

    DailyRate,
    MonthlyRate,
    NumCompaniesWorked,
    OverTime,
    PercentSalaryHike,
    PerformanceRating,
    RelationshipSatisfaction,
    StockOptionLevel,
    TotalWorkingYears,
    TrainingTimesLastYear,
    WorkLifeBalance,

    YearsAtCompany,
    CASE
        WHEN YearsAtCompany BETWEEN 0 AND 2 THEN '0-2 yrs'
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 yrs'
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 yrs'
        ELSE '11+ yrs'
    END AS TenureBand,

    YearsInCurrentRole,
    YearsSinceLastPromotion,
    YearsWithCurrManager

FROM employees_raw;

-- ============================================================
-- Quick validation queries — run these after creating the table
-- to confirm the clean table looks right before moving on.
-- ============================================================

-- 1. Row count should still be 1,470
SELECT COUNT(*) AS total_rows FROM employees_clean;

-- 2. Confirm no nulls introduced in key derived columns
SELECT
    SUM(CASE WHEN AgeBand IS NULL THEN 1 ELSE 0 END) AS null_ageband,
    SUM(CASE WHEN TenureBand IS NULL THEN 1 ELSE 0 END) AS null_tenureband,
    SUM(CASE WHEN SalaryBand IS NULL THEN 1 ELSE 0 END) AS null_salaryband
FROM employees_clean;

-- 3. Sanity check: attrition rate should still be ~16.12%
SELECT
    ROUND(100.0 * SUM(AttritionFlag) / COUNT(*), 2) AS attrition_rate_pct
FROM employees_clean;

-- 4. Preview band distributions
SELECT AgeBand, COUNT(*) AS n FROM employees_clean GROUP BY AgeBand ORDER BY AgeBand;
SELECT TenureBand, COUNT(*) AS n FROM employees_clean GROUP BY TenureBand ORDER BY TenureBand;
SELECT SalaryBand, COUNT(*) AS n FROM employees_clean GROUP BY SalaryBand ORDER BY SalaryBand;