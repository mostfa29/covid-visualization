


-- dbo.Sheet1$









-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
select location, Sum(Cast(new_cases as int)) as totalCases, Sum(Cast(new_deaths as int)) as totalDeaths, 
COALESCE(Sum(Cast(new_deaths as float)) / NULLIF(Sum(Cast(new_cases as float)),0), 0)*100 as DeathPercentage
from dbo.Sheet1$
where continent is not null  
group by location
order by 1,2




-- Total Cases vs Population
-- Shows what percentage of population infected with Covid
select location, population,Sum(Cast(new_cases as int)) as totalCases,
COALESCE(Sum(Cast(new_cases as float)) / population, 0)*100 as InfectionPercentage
from dbo.Sheet1$
where continent is not null  
group by location,population
order by 1,2



-- top 5 Countries with Highest Infection Rate compared to Population
SELECT Top 5 location, population, SUM(new_cases) as totalCases,  (SUM(new_cases) / population) * 100 AS cases_population_percentage
FROM dbo.Sheet1$
where continent is not null  
GROUP BY location,population
ORDER BY cases_population_percentage DESC


-- top 5 Countries with Highest Death Count per Population
SELECT Top 5  location, population, SUM(new_deaths) as totalDeaths,  (SUM(new_deaths) / population) * 100 AS cases_population_percentage
FROM dbo.Sheet1$
where continent is not null  
GROUP BY location,population
ORDER BY cases_population_percentage DESC





-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population
SELECT location, population, SUM(new_deaths) as totalDeaths,  (SUM(new_deaths) / population) * 100 AS deathPercentagePerContinent
FROM dbo.Sheet1$
where continent is  null and location !='Low income' and location !='Lower middle income' and location !='World' and location !='Upper middle income' and location !='High income'
GROUP BY location,population
ORDER BY deathPercentagePerContinent DESC




-- GLOBAL NUMBERS

-- Total Population vs Infection
-- Shows Percentage of Population that has infected with covid
SELECT location, population, SUM(cast(new_cases as float)) as totalCases,  (SUM(cast(new_cases as float)) / population) * 100 AS InfectionPercentage
FROM dbo.Sheet1$
where continent is  null and  location ='World'
GROUP BY location,population
ORDER BY InfectionPercentage DESC


-- Total Population vs Deaths
-- Shows Percentage of Population that has died with covid
SELECT  location, population, max(cast (total_deaths as float)),  (max(cast (total_deaths as float)) / population )*100  AS deathPercentage
FROM dbo.Sheet1$
where continent is  null and  location ='World'
GROUP BY location,population
ORDER BY deathPercentage DESC


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT  location, population, max(cast (people_vaccinated as float)),  (max(cast (people_vaccinated as float)) / population )*100  AS vacinationPercentage
FROM dbo.Sheet1$
where continent is  null and  location ='World'
GROUP BY location,population
ORDER BY vacinationPercentage DESC



-- Creating View to store data for later visualizations
CREATE VIEW [Likelihood Of Covid Death Based On Country]
 AS
select location, Sum(Cast(new_cases as int)) as totalCases, Sum(Cast(new_deaths as int)) as totalDeaths, 
COALESCE(Sum(Cast(new_deaths as float)) / NULLIF(Sum(Cast(new_cases as float)),0), 0)*100 as DeathPercentage
from dbo.Sheet1$
where continent is not null  
group by location

Create view [population infected by country ] as
select location, population,Sum(Cast(new_cases as int)) as totalCases,
COALESCE(Sum(Cast(new_cases as float)) / population, 0)*100 as InfectionPercentage
from dbo.Sheet1$
where continent is not null  
group by location,population



create view [top 5 infected countries] as 
SELECT Top 5 location, population, SUM(new_cases) as totalCases,  (SUM(new_cases) / population) * 100 AS cases_population_percentage
FROM dbo.Sheet1$
where continent is not null  
GROUP BY location,population


create view [top 5 highest covid deaths countries] as 
SELECT Top 5  location, population, SUM(new_deaths) as totalDeaths,  (SUM(new_deaths) / population) * 100 AS cases_population_percentage
FROM dbo.Sheet1$
where continent is not null  
GROUP BY location,population


create view [continent covid death per population] as 
SELECT location, population, SUM(new_deaths) as totalDeaths,  (SUM(new_deaths) / population) * 100 AS deathPercentagePerContinent
FROM dbo.Sheet1$
where continent is  null and location !='Low income' and location !='Lower middle income' and location !='World' and location !='Upper middle income' and location !='High income'
GROUP BY location,population


create view [total percentage of people died from covid] as
SELECT  location, population, max(cast (total_deaths as float)) as totalDeaths,  (max(cast (total_deaths as float)) / population )*100  AS deathPercentage
FROM dbo.Sheet1$
where continent is  null and  location ='World'
GROUP BY location,population


create view [total of people vaccinated] as 
SELECT  location, population, max(cast (people_vaccinated as float)) as totalPeopleVaccinated,  (max(cast (people_vaccinated as float)) / population )*100  AS vacinationPercentage
FROM dbo.Sheet1$
where continent is  null and  location ='World'
GROUP BY location,population
