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

/* Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? */

WITH food_filtered AS (
    SELECT 
        year, 
        food_category, 
        AVG(avg_price) AS avg_price
    FROM t_tereza_petrova_project_sql_primary_final
    WHERE food_category IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
    GROUP BY year, food_category
),
wages_per_year AS (
    SELECT 
        year, 
        AVG(avg_wage) AS avg_wage
    FROM t_tereza_petrova_project_sql_primary_final
    GROUP BY year
),
first_last_year AS (
    SELECT MIN(year) AS first_year, MAX(year) AS last_year
    FROM food_filtered
)
SELECT 
    f.food_category,
    f.year AS year,
    ROUND((w.avg_wage / f.avg_price)::numeric, 2) AS units_affordable
FROM food_filtered f
JOIN wages_per_year w ON f.year = w.year
WHERE f.year IN (SELECT first_year FROM first_last_year UNION SELECT last_year FROM first_last_year)
ORDER BY f.food_category, f.year;

/* Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? */

WITH price_growth AS (
    SELECT 
        food_category,
        year,
        AVG(avg_price) AS avg_price,
        LAG(AVG(avg_price)) OVER(PARTITION BY food_category ORDER BY year) AS prev_price
    FROM t_tereza_petrova_project_sql_primary_final
    GROUP BY food_category, year
)
SELECT 
    food_category, 
    AVG((avg_price - prev_price) / prev_price * 100) AS avg_annual_growth
FROM price_growth
WHERE prev_price IS NOT NULL
GROUP BY food_category
ORDER BY avg_annual_growth ASC
LIMIT 1;

/* Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? */

WITH yearly_growth AS (
    SELECT 
        year,
        AVG(avg_wage) AS avg_wage,
        AVG(avg_price) AS avg_price
    FROM t_tereza_petrova_project_sql_primary_final
    GROUP BY year
),
growth_calc AS (
    SELECT
        year,
        ((avg_price - LAG(avg_price) OVER(ORDER BY year)) / LAG(avg_price) OVER(ORDER BY year) * 100)::numeric AS price_growth,
        ((avg_wage - LAG(avg_wage) OVER(ORDER BY year)) / LAG(avg_wage) OVER(ORDER BY year) * 100)::numeric AS wage_growth,
        (
            ((avg_price - LAG(avg_price) OVER(ORDER BY year)) / LAG(avg_price) OVER(ORDER BY year) * 100)
            -
            ((avg_wage - LAG(avg_wage) OVER(ORDER BY year)) / LAG(avg_wage) OVER(ORDER BY year) * 100)
        )::numeric AS difference
    FROM yearly_growth
)
SELECT 
    year,
    ROUND(price_growth, 2) AS price_growth,
    ROUND(wage_growth, 2) AS wage_growth,
    ROUND(difference, 2) AS difference
FROM growth_calc
WHERE difference > 10
ORDER BY year;

/* Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem? */

WITH yearly_avg AS (
    SELECT 
        c.year,
        AVG(c.avg_price) AS avg_price,      
        AVG(c.avg_wage) AS avg_wage,        
        s.gdp
    FROM t_tereza_petrova_project_sql_primary_final c
    LEFT JOIN t_tereza_petrova_project_SQL_secondary_final s
        ON c.year = s.year AND s.country = 'Czech Republic'
    GROUP BY c.year, s.gdp
),
yearly_growth AS (
    SELECT
        year,
        avg_price,
        avg_wage,
        gdp,
        (avg_price - LAG(avg_price) OVER(ORDER BY year)) / LAG(avg_price) OVER(ORDER BY year) * 100 AS price_growth_pct,
        (avg_wage - LAG(avg_wage) OVER(ORDER BY year)) / LAG(avg_wage) OVER(ORDER BY year) * 100 AS wage_growth_pct,
        (gdp - LAG(gdp) OVER(ORDER BY year)) / LAG(gdp) OVER(ORDER BY year) * 100 AS gdp_growth_pct
    FROM yearly_avg
)
SELECT *
FROM yearly_growth
ORDER BY year;