# SQL_project

V tomto repozitáři můžete nalézt dvě průvodní tabulky:
1) t_tereza_petrova_project_sql_primary_final.sql - tato tabulka agreguje data z datových sad czechia_payroll, czechia_price, czechia_payroll_industry_branch, czechia_payroll_value_type, czechia_payroll_calculation a czechia_price_category. Slouží především k analýze dat v oblasti mezd agregovaně a v jednotlivých odvětvích a k analýze v oblasti analýzy vývoje cen potravin agregovaně a též v jednotlivých kategoriích. Jedná se o primární tabulku v rámci této datové analýzy
2) t_tereza_petrova_project_SQL_secondary_final.sql - tato tabulka agreguje data z datových sad economies a countries. Tato tabulka obsahuje informace o HDP, Gini koeficientu, daňovém zatížení a populaci v jednotlivých státech Evropy. Jedná se o sekundární, spíše podpůrnou tabulku

Dále je v tomto repozitáři obsažen soubor t_tereza_petrova_SQL_queries.sql, který obsahuje kódy v sql k jednotlivým zkoumaným otázkám. Níže je k dispozici bližší komentář:

1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? - Nerostou, v průběhu sledovaného období v některých odvětvích dokonce klesají (např. rok 2024 a rok 2026 v administrativních a podpůrných činnostech, takovýchto příkladů je ale napříč všemi odvětvími v rámci sledovaného období poměrně dost)   
    
2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? - V roce 2006 si bylo možné za průměrnou mzdu zakoupit 1 200,92 kg chleba (v roce 2018 to bylo 1 250,39 kg), u mléka to bylo v roce 2006 1 341,14 l (v roce 2018 to bylo 1 529,33 l). U chleba to za 12 let sledovaného období není příliš významný nárůst (pouze cca 4 %), u mléka je nárůst poměrně signifikantní (cca 14 %). Bohužel nejsou k dispozici data ohledně cen potravin za pozdější období
   
3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? - Jedná se o cukr krystalový (průměrný roční růst je dokonce záporný, -1,92 %). Opět jsou data ohledně cen potravin dostupná pouze do roku 2018, takže výsledná data nejsou příliš aktuální
   
4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? - Ano, v roce 2013 dosáhl růst cen potravin 5,1 %, růst mezd činil záporných -6,76 %
   
5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem? - Pro zkoumání této otázky máme k dispozici časovou řadu od roku 2006 do roku 2018 (opět způsobeno chybějícími daty za ceny potraviny, údaje o mzdách jsou kompletní (od roku 2000 do roku 2021), údaje o HDP chybějí za rok 2021. Pokud se podíváme na roky, kdy došlo k vyššímu růstu HDP (např. nad 5 % - týká se to let 2006, 2007, 2015, 2017 - roky, kdy jsme schopni průměrné ceny potravin analyzovat - tam jsou dostupná data od roku 2006 do roku 2018). Analýza průměrných mezd a průměrných cen potravin v letech následujících nám naznačuje, že tyto veličiny nejsou primárně závislé pouze na HDP a nedá se určit přímá závislost (např. v roce 2015 byl růst HDP 5,39 %, v roce 2016 činil průměrný růst cen potravin -1,19 %, průměrný růst mezd 7,04 %
