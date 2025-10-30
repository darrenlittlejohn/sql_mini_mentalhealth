# SQL_mini_project_unmet_mental_health_needs_as_predictor_of_exit_from_work

## Concept Development Notes
My thinking on this project is to first locate data focused on mental health, addiction, and labor—data that could lead to insights about productivity. The goal is to help stakeholders understand whether there are differences across industries or communities in addiction and treatment patterns.

The project aligns with existing research showing that **mental health significantly impacts workforce outcomes.**

This is the starting point of the thinking process. AI generated about a dozen hypotheses around mental health and employment, seeking business questions that remain unanswered. The most relevant question, based on both available data and personal interest, is this one—**unmet mental health need as a predictor of exit from work.**

My background in healthcare and research psychology (graduate and undergraduate) includes training in statistics, research design, and data interpretation. That academic base has supported research for bestselling books on addiction, as well as podcasts, blogs, and related media. This project continues that applied research tradition.

The goal is to identify something personally meaningful and professionally relevant: to examine employer awareness of mental health and addiction, what programs exist, what is being done, and what has been shown to

## Executive Problem Statement (Ask)
Do adults who report unmet need for mental health care show higher rates of being unemployed or out of the labor force?

## Business Outcome Hypothesis (Value Thesis)
Unmet mental health need may predict workforce detachment. If untreated mental health need is associated with higher unemployment or labor-force exit, it represents a measurable retention and vacancy-cost risk for employers.

## Decision Use-Cases & KPIs
- **Retention risk** (probability of exiting employment due to unmet mental health need)  
- **Vacancy cost** (replacement and backfill expense associated with workforce detachment)  
- **Coverage capacity** (operational strain caused by workforce loss)

## Scope & Constraints
- **Population:** U.S. adults aged 18–64  
- **Years:** 2002–2019 (as available from NSDUH public-use data)  
- **Exclusions:** Retired individuals, institutionalized populations, or those without valid labor-force status codes

## Data Sources & Variables
- **NSDUH:**  
  - `AMHTXND2` — perceived unmet need for mental health treatment  
  - Employment status — full-time, part-time, unemployed, not in labor force  
  - `CAMHPROB1` — self-reported lifetime mental health problem (optional control variable)  
- **TEDS-A (contextual cross-check):**  
  - `EMPLOY` — employment status at admission  
  - `PSYPROB` — co-occurring mental health problem flag  

## Operational Definitions
- **Unmet Need:** Respondent indicated needing mental health care in the past year but did not receive it (`AMHTXND2 = Yes`).  
- **Workforce Detachment:** Respondent categorized as unemployed or not in the labor force.  
- **Working-Age Population:** Adults aged 18–64 to minimize retirement effects in “not in labor force.”  

## Analysis Plan (Plan/PACE)
1. **Filter** to working-age adults (18–64).  
2. **Group A:** AMHTXND2 = Yes (unmet mental health need).  
   **Group B:** AMHTXND2 = No (no unmet need).  
3. **Compute distributions** of employment status (full-time, part-time, unemployed, not in labor force) for each group.  
4. **Compare proportions** of unemployment and non-participation between groups.  
5. **Interpretation:** Higher detachment in Group A suggests association between unmet mental health need and workforce exit.  

## Risks & Assumptions
- NSDUH is cross-sectional; causality cannot be inferred.  
- Self-reported unmet need may differ from clinically validated diagnoses.  
- Economic cycles may influence employment status independently of mental health.  

## Deliverables & Formats
- Executive one-pager summarizing key findings  
- Visualization slide deck (labor-force detachment vs. unmet need)  
- SQL or Python notebook replicating analysis  
- Repository documentation (README + metadata)

## Milestones & Owners
| Milestone | Owner | Target Date |
|------------|--------|-------------|
| Data extraction & cleaning | Darren | TBD |
| Variable validation (NSDUH subset) | Darren | TBD |
| Initial EDA | Darren | TBD |
| Draft executive brief | Darren | TBD |
| Final deck & GitHub publish | Darren | TBD |

## Executive Summary
*(To be completed after results.)*

---

## Strategy from Conception Forward
Begin the search for usable, meaningful data. We started with questions linking mental health or addiction to workforce and productivity outcomes. The hypothesis is limited by available data but aims to explore current unknowns in this area. Our goal is to produce insights valuable to HR executives across industries and to government stakeholders involved in workforce and public health funding.

AI-assisted dataset exploration identified viable federal sources. Some SAMHSA data endpoints now return 403 errors, reflecting the loss of public access to behavioral health data. We were able to secure access to the following datasets:

- **National Survey on Drug Use and Health (NSDUH)**  
  <https://www.samhsa.gov/data/data-we-collect/teds-treatment-episode-data-set/datafiles/teds-a-2019>
- **Treatment Episode Data Set: Admissions (TEDS-A)**  
  <https://www.samhsa.gov/data/data-we-collect/teds-treatment-episode-data-set/datafiles/teds-a-2019>

---

