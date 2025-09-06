/* Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? */

WITH aggregated AS (
    SELECT 
        year,
        industry_branch,
        AVG(avg_wage) AS avg_wage_per_industry
    FROM t_tereza_petrova_project_SQL_primary_final
    GROUP BY year, industry_branch
)
SELECT 
    year,
    industry_branch,
    avg_wage_per_industry,
    ROUND(
        ((avg_wage_per_industry - LAG(avg_wage_per_industry) OVER (PARTITION BY industry_branch ORDER BY year)) 
        / LAG(avg_wage_per_industry) OVER (PARTITION BY industry_branch ORDER BY year)) * 100
    , 2) AS wage_change_percent
FROM aggregated
ORDER BY industry_branch, year;