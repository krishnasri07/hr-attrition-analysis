# Insights Summary — HR Attrition Analysis

**Audience:** HR leadership · **Dataset:** 1,470 employees, 237 leavers (16.1%)

## Executive summary

Attrition is not spread evenly. It concentrates in **junior, lower-paid roles, in the first two years of employment, and among employees working overtime**. These factors also compound: employees with three or more risk factors leave at about three times the company rate. Overtime is the clearest lever HR controls, so it is the strongest candidate for a targeted intervention.

---

## 1. Where attrition is concentrated

| Segment | Employees | Left | Attrition rate | vs company (16.1%) |
|---|---|---|---|---|
| Sales Representative | 83 | 33 | 39.8% | 2.5× |
| Laboratory Technician | 259 | 62 | 23.9% | 1.5× |
| Human Resources (role) | 52 | 12 | 23.1% | 1.4× |
| Research Director | 80 | 2 | 2.5% | 0.2× |

Sales Representatives, Laboratory Technicians and HR staff together are **394 employees (27% of the workforce) but 107 leavers (45% of all leavers)**. These roles have low average pay ($2,600–$4,200). Pay alone does not explain the pattern, however: Research Scientists earn about the same as Laboratory Technicians (about $3,240) yet sit at the company average (16.1%).

By tenure: **29.8%** attrition in years 0–2, falling to **8.1%** at 11+ years. By age band: 35.8% for ages 18–25 versus 9.2% for ages 36–45.

## 2. Which factors are statistically associated with attrition

Ranked by effect size (Cramér's V; about 0.1 is small, 0.3 is medium):

| Factor | χ² | p-value | V | Highest-risk group |
|---|---|---|---|---|
| Overtime | 87.6 | < 0.001 | 0.24 | Overtime: 30.5% (vs 10.4%) |
| Job role | 86.2 | < 0.001 | 0.24 | Sales Representative: 39.8% |
| Marital status | 46.2 | < 0.001 | 0.18 | Single: 25.5% |
| Business travel | 24.2 | < 0.001 | 0.13 | Frequent travellers: 24.9% (vs 8.0% non-travel) |
| Environment satisfaction | 22.5 | < 0.001 | 0.12 | Level 1: 25.4% (vs 13.5% at level 4) |
| Job satisfaction | 17.5 | < 0.001 | 0.11 | Level 1: 22.8% (vs 11.3% at level 4) |
| Work-life balance | 16.3 | 0.001 | 0.11 | Level 1: 31.3% (only 80 employees) |
| Department | 10.8 | 0.005 | 0.09 | Sales: 20.6% |
| **Gender** | 1.1 | **0.29** | 0.03 | **No significant association** |

For numeric variables (Mann-Whitney U), leavers had a **lower median income** ($3,202 vs $5,204), were **younger** (median 32 vs 36) and had **less total experience** (7 vs 10 years). All at p < 0.001 with moderate effects (r ≈ 0.27–0.31).

## 3. What holds up after controlling for everything else (logistic regression)

| Factor | Odds ratio | 95% CI | Interpretation |
|---|---|---|---|
| Overtime | 4.98 | 3.60 – 6.89 | About 5× higher odds of leaving |
| Single | 2.71 | 1.97 – 3.73 | About 2.7× |
| Frequent travel | 2.22 | 1.55 – 3.19 | About 2.2× |
| Job satisfaction (per level) | 0.70 | 0.61 – 0.81 | About 30% lower odds per level |
| Environment satisfaction (per level) | 0.70 | 0.61 – 0.81 | About 30% lower odds per level |
| Monthly income (per $1,000) | 0.97 | 0.87 – 1.10 | **Not significant (p = 0.66)** |

**Interpretation of the income result:** pay looks important in simple comparisons, but income, job level and experience move together (Spearman 0.92 between income and job level), so the model cannot separate their effects. This does *not* show that pay is irrelevant; it shows pay cannot be isolated from seniority in this data.

## 4. Risk stacks

Counting five risk factors per employee (overtime, single, income under $3K, first two years, frequent travel):

| Risk factors | Employees | Attrition |
|---|---|---|
| 0 | 384 | 6.2% |
| 1 | 532 | 7.0% |
| 2 | 346 | 21.7% |
| 3 | 164 | 40.9% |
| 4 | 36 | 75.0% |
| 5 | 8 | 87.5% |

Grouped: **Low (0–1) 6.7%**, **Medium (2) 21.7%**, **High (3+) 48.6%**. The most severe named segment is **Overtime + Single + Income under $3K: 70.5% (44 employees)**.

Even among employees with the *highest* job satisfaction, overtime workers left at about 21% versus about 7% for non-overtime workers, suggesting overtime is associated with leaving regardless of how satisfied people say they are.

## 5. Hypotheses that were not supported

- **Promotion delay.** Median time since last promotion was 1 year for both leavers and stayers; the effect size was negligible (r = 0.08), and leavers actually had slightly *fewer* years since promotion on average (1.95 vs 2.23).
- **Gender.** No significant difference (14.8% women vs 17.0% men, p = 0.29).

Reporting these is deliberate: a result that fails to confirm a hypothesis is still a finding.

---

## Recommendations

| Priority | Action | Based on |
|---|---|---|
| 1 | **Review overtime** in the highest-risk roles (Sales Representatives, Laboratory Technicians): workload, scheduling, caps or compensation. Pilot in one team and measure the change in attrition. | Overtime is the strongest factor (OR ≈ 5) and is directly controllable |
| 2 | **Strengthen the first two years**: structured onboarding and check-ins at about 3, 6 and 12 months, especially for lower-paid hires | 29.8% attrition at 0–2 years; 38.1% for low-paid new hires |
| 3 | **Review pay for the lowest-paid junior roles**, framed as a test, not an assumption | Large raw pay gap, but entangled with seniority in the regression |
| 4 | **Track job and environment satisfaction** with short pulse surveys and act on low scores | Each satisfaction level is associated with about 30% lower odds of leaving |
| 5 | **Use the risk-factor view to prioritise supportive conversations**, not to penalise anyone | 48.6% attrition among employees with 3+ risk factors |

**Ethical note.** Marital status helps *describe* who is at higher risk in this data but is a protected characteristic in many jurisdictions. It should not be used for individual employment decisions. Interventions should target controllable conditions (overtime, onboarding, workload, satisfaction), not personal circumstances.

## Limitations

- Observational data: associations only, not causes.
- Fictional dataset: the method transfers; the specific numbers do not describe a real company.
- No hire or exit dates, so no true trend over time.
- Risk factors were selected after exploring this data; stacking results and the regression are in-sample and unvalidated on held-out data.
- Several cells and categories are small (for example, 80 employees at work-life balance level 1; 8 employees with five risk factors) and should be read cautiously.

## Suggested next steps

1. Add hire and exit dates to enable survival analysis (time-to-exit).
2. Add exit-interview data to learn the stated reasons.
3. Estimate the financial cost of attrition by role to prioritise by impact.
4. Test the overtime recommendation in a pilot team, and compare with a control group.
5. If a predictive model is wanted, validate on a held-out sample.
