/*
Covid 19 Data Exploration 

This project uses SQL to analyze COVID-19 data, exploring various aspects such as infection rates, 
death counts, and vaccination progress across different countries and continents.
*/

-- Retrieving all data from CovidDeaths table for initial exploration
SELECT *
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 3,4

-- Selecting key fields to start our analysis
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2

-- Calculating death percentage in the United States
-- This shows the likelihood of dying if you contract COVID in the US
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE location LIKE '%states%' AND continent IS NOT NULL 
ORDER BY 1,2

-- Comparing total cases vs population
-- Shows what percentage of population got COVID
SELECT Location, date, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
ORDER BY 1,2

-- Identifying countries with highest infection rate compared to population
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject.CovidDeaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- Showing countries with highest death count per population
SELECT Location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Breaking things down by continent
-- Showing continents with the highest death count
SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global COVID numbers
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, 
       SUM(CAST(new_deaths AS INT))/SUM(New_Cases)*100 AS DeathPercentage
FROM PortfolioProject.CovidDeaths
WHERE continent IS NOT NULL 
ORDER BY 1,2

-- Analyzing total population vs vaccinations
-- Shows percentage of population that has received at least one Covid vaccine
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations,
       SUM(CONVERT(INT,CovidVaccinations.new_vaccinations)) OVER (PARTITION BY CovidDeaths.Location ORDER BY CovidDeaths.location, CovidDeaths.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths
JOIN PortfolioProject.CovidVaccinations
    ON CovidDeaths.location = CovidVaccinations.location AND CovidDeaths.date = CovidVaccinations.date
WHERE CovidDeaths.continent IS NOT NULL 
ORDER BY 2,3

-- Using CTE to perform calculation on Partition By in previous query
WITH PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
    SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations,
           SUM(CONVERT(INT,CovidVaccinations.new_vaccinations)) OVER (PARTITION BY CovidDeaths.Location ORDER BY CovidDeaths.location, CovidDeaths.Date) AS RollingPeopleVaccinated
    FROM PortfolioProject.CovidDeaths
    JOIN PortfolioProject.CovidVaccinations
        ON CovidDeaths.location = CovidVaccinations.location AND CovidDeaths.date = CovidVaccinations.date
    WHERE CovidDeaths.continent IS NOT NULL 
)
SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM PopvsVac

-- Using Temp Table to perform calculation on Partition By in previous query
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
RollingPeopleVaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations,
       SUM(CONVERT(INT,CovidVaccinations.new_vaccinations)) OVER (PARTITION BY CovidDeaths.Location ORDER BY CovidDeaths.location, CovidDeaths.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths
JOIN PortfolioProject.CovidVaccinations
    ON CovidDeaths.location = CovidVaccinations.location AND CovidDeaths.date = CovidVaccinations.date

SELECT *, (RollingPeopleVaccinated/Population)*100 AS PercentPopulationVaccinated
FROM #PercentPopulationVaccinated

-- Creating View to store data for later
CREATE VIEW PercentPopulationVaccinated AS
SELECT CovidDeaths.continent, CovidDeaths.location, CovidDeaths.date, CovidDeaths.population, CovidVaccinations.new_vaccinations,
       SUM(CONVERT(INT,CovidVaccinations.new_vaccinations)) OVER (PARTITION BY CovidDeaths.Location ORDER BY CovidDeaths.location, CovidDeaths.Date) AS RollingPeopleVaccinated
FROM PortfolioProject.CovidDeaths
JOIN PortfolioProject.CovidVaccinations
    ON CovidDeaths.location = CovidVaccinations.location AND CovidDeaths.date = CovidVaccinations.date
WHERE CovidDeaths.continent IS NOT NULL