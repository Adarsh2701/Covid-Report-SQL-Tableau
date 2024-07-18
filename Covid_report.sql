SELECT * FROM covid.percentpopulationvaccinated;

-- Print all the data 
 SELECT *
 FROM covid.coviddeaths
 order by location;

-- Select Data that we are going to be starting with

SELECT continent,location,date,total_cases,new_cases,total_deaths, population
 FROM covid.coviddeaths
 Where continent is not null 
 order by 1,2;

 
-- Total Cases vs Total Deaths

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    ROUND(((total_deaths / total_cases) * 100), 2) DeathPercentae
FROM
    covid.coviddeaths
    Where continent is not null ; 

-- Shows likelihood of dying if you contract covid in your country

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    ROUND(((total_deaths / total_cases) * 100), 2) DeathPercentae
FROM
    covid.coviddeaths
    where location like '%india%'; 
    
    
-- Total Population vs Total Deaths

SELECT 
    location,
    date,
    population,
    total_deaths,
    ((total_deaths / population) * 100) PercentPopulationInfected
FROM
    covid.coviddeaths
    Where continent is not null ; 

-- Shows likelihood of dying if you contract covid in your country

SELECT 
    location,
    date,
    population,
    total_deaths,
    ((total_deaths / population) * 100) PercentPopulationInfected
FROM
    covid.coviddeaths
    where location like '%india%'; 
    
-- Countries with Highest Infection Rate compared to Population

SELECT 
    location,
    population,
    MAX(total_cases) HighestInfectionCount,
    MAX((total_cases / population)) * 100 PercentPopulationInfected
FROM
    covid.coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY location , population
ORDER BY PercentPopulationInfected DESC; 
    
-- Countries with Highest Death Count per Population 

SELECT 
    location, MAX(total_deaths) AS Total_Death_Count
FROM
    covid.coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY location
ORDER BY Total_Death_Count DESC; 

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

SELECT 
    location, MAX(total_deaths) AS Total_Death_Count
FROM
    covid.coviddeaths
WHERE
    continent IS  NULL
GROUP BY location
ORDER BY Total_Death_Count DESC; 

SELECT 
    continent, MAX(total_deaths) AS Total_Death_Count
FROM
    covid.coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC; 

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From covid.coviddeaths
where continent is not null 
order by 1,2;

-- joining both the table coviddeaths, covidvaccinations

select * from
covid.coviddeaths dea 
join covid.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date;

-- Total Population vs Vaccinations

select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location,dea.Date)
from
covid.coviddeaths dea 
join covid.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null ;

-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location,dea.Date)
from
covid.coviddeaths dea 
join covid.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
) 
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query
-- DROP Table if exists PercentPopulationVaccinated

Create Table PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
);

Insert into covid.PercentPopulationVaccinated
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location,dea.Date)
from
covid.coviddeaths dea 
join covid.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date;
-- where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
From covid.PercentPopulationVaccinated;

SELECT COUNT(*) FROM covid.PercentPopulationVaccinated;


-- Creating View to store data for later visualizations

Create View PercentPopulation as
select dea.continent,dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(vac.new_vaccinations) over (Partition by dea.location order by dea.location,dea.Date)
from
covid.coviddeaths dea 
join covid.covidvaccinations vac
on dea.location = vac.location
and dea.date = vac.date;
-- where dea.continent is not null

select * from PercentPopulation