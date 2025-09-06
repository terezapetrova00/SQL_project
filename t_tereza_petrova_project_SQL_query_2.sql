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