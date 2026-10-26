# Data Dictionary — IBM HR Analytics Employee Attrition Dataset

**Source:** IBM HR Analytics Employee Attrition & Performance (Kaggle, by Pavan Subhash)
**Rows:** 1,470 employees | **Columns:** 35 | **Missing values:** 0 | **Duplicates:** 0

## Target Variable
| Column | Type | Values | Notes |
|---|---|---|---|
| Attrition | Text | Yes / No | 237 Yes (16.12%), 1,233 No — imbalanced classes |

## Demographics
| Column | Type | Notes |
|---|---|---|
| Age | Integer | 18–60 |
| Gender | Text | Male / Female |
| MaritalStatus | Text | Single / Married / Divorced |
| DistanceFromHome | Integer | Miles |
| Education | Integer (1–5) | 1=Below College, 2=College, 3=Bachelor, 4=Master, 5=Doctor |
| EducationField | Text | Life Sciences, Medical, Marketing, etc. |

## Job & Department
| Column | Type | Notes |
|---|---|---|
| Department | Text | Sales, R&D, HR |
| JobRole | Text | 9 roles |
| JobLevel | Integer (1–5) | Seniority level |
| BusinessTravel | Text | Non-Travel / Travel_Rarely / Travel_Frequently |

## Compensation
| Column | Type | Notes |
|---|---|---|
| MonthlyIncome | Integer | Right-skewed — use median, not just mean |
| DailyRate, HourlyRate, MonthlyRate | Integer | Payroll-system rates, not directly comparable to MonthlyIncome |
| PercentSalaryHike | Integer | Last hike % |
| StockOptionLevel | Integer (0–3) | |

## Tenure & Career
| Column | Type | Notes |
|---|---|---|
| YearsAtCompany | Integer | |
| YearsInCurrentRole | Integer | |
| YearsSinceLastPromotion | Integer | |
| YearsWithCurrManager | Integer | |
| TotalWorkingYears | Integer | Full career, not just this company |
| NumCompaniesWorked | Integer | |

## Engagement & Satisfaction (all 1–4 Likert scales unless noted)
| Column | Scale meaning |
|---|---|
| JobSatisfaction | 1=Low, 2=Medium, 3=High, 4=Very High |
| EnvironmentSatisfaction | same scale |
| RelationshipSatisfaction | same scale |
| WorkLifeBalance | 1=Bad, 2=Good, 3=Better, 4=Best |
| JobInvolvement | 1=Low ... 4=Very High |
| PerformanceRating | 3=Excellent, 4=Outstanding (only 2 values present in data) |

## Work Conditions
| Column | Notes |
|---|---|
| OverTime | Yes / No |
| TrainingTimesLastYear | Integer, count of trainings |

## Dropped / Excluded Columns (near-zero information)
| Column | Reason |
|---|---|
| EmployeeCount | Constant = 1 for all rows |
| Over18 | Constant = 'Y' for all rows |
| StandardHours | Constant = 80 for all rows |

*(EmployeeNumber is kept as a unique row identifier but excluded from any statistical/aggregation analysis.)*

## Known Data Characteristics to Carry Into Analysis
- **Class imbalance:** 16.12% attrition rate — always read segment attrition rates as *relative lift* over this baseline, not as absolute majority shares.
- **MonthlyIncome is right-skewed** — report median alongside mean.
- **PerformanceRating has almost no variance** (only 3 and 4 appear) — likely uninformative for attrition analysis; note this rather than force a chart out of it.
