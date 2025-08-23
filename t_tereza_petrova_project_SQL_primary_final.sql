DROP TABLE IF EXISTS t_tereza_petrova_project_SQL_primary_final;

CREATE TABLE t_tereza_petrova_project_SQL_primary_final AS
SELECT 
    p.payroll_year AS year,
    ib.name AS industry_branch,           
    AVG(p.value) AS avg_wage,            
    cat.name AS food_category,
    AVG(cp.value) AS avg_price            
FROM czechia_payroll p
JOIN czechia_payroll_value_type vt 
    ON p.value_type_code = vt.code
JOIN czechia_payroll_calculation calc
    ON p.calculation_code = calc.code
JOIN czechia_payroll_industry_branch ib
    ON p.industry_branch_code = ib.code
LEFT JOIN czechia_price cp
    ON EXTRACT(YEAR FROM cp.date_from) = p.payroll_year
LEFT JOIN czechia_price_category cat
    ON cp.category_code = cat.code
GROUP BY p.payroll_year, ib.name, cat.name
ORDER BY p.payroll_year, ib.name, cat.name;





