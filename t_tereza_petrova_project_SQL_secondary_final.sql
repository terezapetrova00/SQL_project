DROP TABLE IF EXISTS t_tereza_petrova_project_SQL_secondary_final;

CREATE TABLE t_tereza_petrova_project_SQL_secondary_final AS
SELECT 
    e.year,
    c.country AS country,
    e.gdp,
    e.gini,
    e.taxes,
    e.population
FROM economies e
JOIN countries c 
    ON e.country = c.country   -- join přes název státu
WHERE c.continent = 'Europe'
  AND e.year BETWEEN (SELECT MIN(year) FROM t_tereza_petrova_project_SQL_primary_final)
                  AND (SELECT MAX(year) FROM t_tereza_petrova_project_SQL_primary_final)
ORDER BY e.year, c.country;