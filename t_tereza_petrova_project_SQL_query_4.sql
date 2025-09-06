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