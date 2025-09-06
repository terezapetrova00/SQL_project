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