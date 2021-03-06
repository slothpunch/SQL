RENAME TABLE null_covid_vaccinations TO covid_vaccinations;

USE project;

-- 1. Connect covid_deaths and covid_vaccinations
SELECT 
    *
FROM
    covid_deaths cd
        JOIN
    covid_vaccinations cv ON cd.date = cv.date
		AND cd.location = cv.location
WHERE cd.continent != '';

-- 2.
-- Select continent, location, date, population, new_vaccinations, and 
-- use the OVER function named as Rolling_People_Vaccinated (sum is new_vaccination, partition and order by location)

SELECT 
	cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) OVER(PARTITION BY cv.location ORDER BY cv.date)
FROM 
	project.covid_deaths cd
			JOIN 
	project.covid_vaccinations cv ON cd.date = cv.date 
			AND cd.location = cv.location
WHERE 
	cd.location != '';

-- 3.
-- Use 2. and CTE (a common table expression), calculate the vaccinated rate of people 
-- (the result of OVER clause/population) * 100, name it as vaccinated_rate

-- WITH table_name (col1, col2, ...) AS () SELECT

WITH VAC_ROL(continent, location, date, population, new_vaccinations, rolling_out_vaccinations)
AS (
SELECT 
	cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) OVER(PARTITION BY cv.location ORDER BY cv.date) AS rolling_out_vaccinations
FROM 
	project.covid_deaths cd
			JOIN 
	project.covid_vaccinations cv ON cd.date = cv.date 
			AND cd.location = cv.location
WHERE 
	cd.location != ''
) 
SELECT *, (rolling_out_vaccinations/population)*100 AS vaccinated_rate
FROM VAC_ROL ;

-- 4. 
-- CREATE a TEMP Table and use 3. to insert values into the TEMP table.
DROP TABLE IF EXISTS PercentagePopulationVaccinated;
CREATE TEMPORARY TABLE PercentagePopulationVaccinated 
(	
	continent VARCHAR(255),
    location VARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccination NUMERIC, 
    Rolling_People_Vaccinated NUMERIC
);

INSERT INTO PercentagePopulationVaccinated

SELECT 
	cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) OVER(PARTITION BY cv.location ORDER BY cv.date) AS rolling_out_vaccinations
FROM 
	project.covid_deaths cd
			JOIN 
	project.covid_vaccinations cv ON cd.date = cv.date 
			AND cd.location = cv.location
WHERE 
	cd.location != '';

SELECT *, (Rolling_People_Vaccinated/population)*100 AS Vaccinated_Percentage
FROM PercentagePopulationVaccinated;

-- 5.
-- Creating View to store data for later visulisation
CREATE VIEW PercentagePopulationVaccinated AS

SELECT 
	cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations,
    SUM(cv.new_vaccinations) OVER(PARTITION BY cv.location ORDER BY cv.date) AS rolling_out_vaccinations
FROM 
	project.covid_deaths cd
			JOIN 
	project.covid_vaccinations cv ON cd.date = cv.date 
			AND cd.location = cv.location
WHERE 
	cd.location != '';
    
SELECT * FROM project.percentagepopulationvaccinated;