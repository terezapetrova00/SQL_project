# SQL Projekt – Analýza mezd a cen potravin

Tento projekt se zabývá analýzou vývoje mezd a cen potravin v České republice a jejich vztahu k makroekonomickým ukazatelům evropských států.

---

## 1. Zadání projektu

Cílem projektu je:
- analyzovat vývoj mezd a cen potravin v ČR,
- zhodnotit kupní sílu obyvatel (např. kolik litrů mléka a kilogramů chleba lze koupit za průměrnou mzdu),
- porovnat vývoj mezd a cen potravin s makroekonomickými ukazateli vybraných evropských zemí (HDP, Gini koeficient, daňové zatížení, populace).

Projekt využívá SQL skripty a připravené tabulky k načítání, agregaci a analýze dat.

---

## 2. Popis tvorby primární a sekundární tabulky

### Primární tabulka
- **Soubor:** `t_tereza_petrova_project_sql_primary_final.sql`
- **Zdrojová data:** `czechia_payroll`, `czechia_price`, `czechia_payroll_industry_branch`, `czechia_payroll_value_type`, `czechia_payroll_calculation`, `czechia_price_category`
- **Účel:** Analýza vývoje mezd a cen potravin, jak agregovaně, tak podle odvětví (mzdy) nebo kategorií (potraviny)

### Sekundární tabulka
- **Soubor:** `t_tereza_petrova_project_SQL_secondary_final.sql`
- **Zdrojová data:** `economies`, `countries`
- **Obsahuje:** HDP, Gini koeficient, daňové zatížení, populaci evropských států
- **Účel:** Podpůrná tabulka pro porovnání makroekonomických ukazatelů s vývojem mezd a cen potravin

---

## 3. Výzkumné otázky a odpovědi

1. **Rostou mzdy ve všech odvětvích?**  
   - Ne. Například v roce 2004 a 2006 klesaly mzdy v administrativních a podpůrných činnostech. Podobné případy jsou napříč odvětvími.

2. **Kolik lze koupit chleba a mléka za průměrnou mzdu (2006 vs. 2018)?**  
   - **Chléb:** 2006 → 1 200,92 kg | 2018 → 1 250,39 kg (+4 %)  
   - **Mléko:** 2006 → 1 341,14 l | 2018 → 1 529,33 l (+14 %)

3. **Která kategorie potravin zdražuje nejpomaleji?**  
   - Cukr krystalový – průměrný roční růst −1,92 %.

4. **Existuje rok, kdy ceny rostly rychleji než mzdy (o více než 10 %)?**  
   - Ano, 2013: růst cen potravin +5,1 %, mzdy −6,76 %.

5. **Má vývoj HDP vliv na změny mezd a cen potravin?**  
   - Přímá závislost nebyla potvrzena. Například v roce 2015 HDP vzrostlo o +5,39 %, ale v roce 2016 ceny potravin poklesly o −1,19 % a mzdy vzrostly o +7,04 %.
