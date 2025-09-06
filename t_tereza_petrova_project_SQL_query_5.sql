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