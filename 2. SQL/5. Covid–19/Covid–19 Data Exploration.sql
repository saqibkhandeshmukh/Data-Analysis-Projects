--- create database ---
	create database "covid_19 data exploration"
	
--- create table covid_deaths ---
	create table covid_deaths
	(
		iso_code varchar(200),
		continent varchar(200),
		location varchar(200),
		date date,
		population int8,
		total_cases int8,
		new_cases int8,
		new_cases_smoothed float,
		total_deaths int8,
		new_deaths int8,
		new_deaths_smoothed float,
		total_cases_per_million float,
		new_cases_per_million float,
		new_cases_smoothed_per_million float,
		total_deaths_per_million float,
		new_deaths_per_million float,
		new_deaths_smoothed_per_million float,
		reproduction_rate float,
		icu_patients int8,
		icu_patients_per_million float,
		hosp_patients int8,
		hosp_patients_per_million float,
		weekly_icu_admissions int8,
		weekly_icu_admissions_per_million float,
		weekly_hosp_admissions int8,
		weekly_hosp_admissions_per_million float
	)
	
--- importing data into covid_deaths ---	
	copy covid_deaths (iso_code, continent, location, date, population, total_cases,new_cases,
					   new_cases_smoothed, total_deaths, new_deaths, new_deaths_smoothed,
					   total_cases_per_million, new_cases_per_million, new_cases_smoothed_per_million,
					   total_deaths_per_million, new_deaths_per_million, new_deaths_smoothed_per_million,
					   reproduction_rate, icu_patients, icu_patients_per_million, hosp_patients,
					   hosp_patients_per_million, weekly_icu_admissions, weekly_icu_admissions_per_million,
					   weekly_hosp_admissions, weekly_hosp_admissions_per_million)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\5. Covid–19\covid_deaths.csv'
	delimiter ','
	csv header
	
--- details of covid_deaths ---
	select * from covid_deaths
	select count(*) as rows from covid_deaths
	select count(*) as columns from information_schema.columns where table_name = 'covid_deaths'
	select column_name, data_type from information_schema.columns where table_name = 'covid_deaths'
	
--- create table covid_vaccinations ---	
	create table covid_vaccinations
	(
		iso_code varchar(200),
		continent varchar(200),
		location varchar(200),
		date date,
		total_tests int8,
		new_tests int8,
		total_tests_per_thousand float,
		new_tests_per_thousand float,
		new_tests_smoothed int8,
		new_tests_smoothed_per_thousand float,
		positive_rate numeric,
		tests_per_case numeric,
		tests_units varchar(200),
		total_vaccinations int8,
		people_vaccinated int8,
		people_fully_vaccinated int8,
		total_boosters int8,
		new_vaccinations int8,
		new_vaccinations_smoothed int8,
		total_vaccinations_per_hundred float,
		people_vaccinated_per_hundred float,
		people_fully_vaccinated_per_hundred float,
		total_boosters_per_hundred float,
		new_vaccinations_smoothed_per_million int8,
		new_people_vaccinated_smoothed int8,
		new_people_vaccinated_smoothed_per_hundred float,
		stringency_index numeric,
		population_density float,
		median_age numeric,
		aged_65_older float,
		aged_70_older float,
		gdp_per_capita numeric,
		extreme_poverty numeric,
		cardiovasc_death_rate float,
		diabetes_prevalence float,
		female_smokers numeric,
		male_smokers numeric,
		handwashing_facilities numeric,
		hospital_beds_per_thousand numeric,
		life_expectancy numeric,
		human_development_index float,
		excess_mortality_cumulative_absolute numeric,
		excess_mortality_cumulative numeric,
		excess_mortality numeric,
		excess_mortality_cumulative_per_million numeric
	)
	
--- importing data into covid_vaccinations ---	
	copy covid_vaccinations (iso_code, continent, location, date, total_tests, new_tests, total_tests_per_thousand,
							 new_tests_per_thousand, new_tests_smoothed, new_tests_smoothed_per_thousand, positive_rate,
							 tests_per_case, tests_units, total_vaccinations, people_vaccinated, people_fully_vaccinated,
							 total_boosters, new_vaccinations, new_vaccinations_smoothed, total_vaccinations_per_hundred,
							 people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred, total_boosters_per_hundred,
							 new_vaccinations_smoothed_per_million, new_people_vaccinated_smoothed,
							 new_people_vaccinated_smoothed_per_hundred, stringency_index, population_density, median_age,
							 aged_65_older, aged_70_older, gdp_per_capita, extreme_poverty, cardiovasc_death_rate, diabetes_prevalence,
							 female_smokers, male_smokers, handwashing_facilities, hospital_beds_per_thousand, life_expectancy,
							 human_development_index, excess_mortality_cumulative_absolute, excess_mortality_cumulative, excess_mortality,
							 excess_mortality_cumulative_per_million)
	from 'D:\SKD\Data Analyst\3. SQL\3. Project\5. Covid–19\covid_vaccinations.csv'
	delimiter ','
	csv header
	
--- details of covid_vaccinations ---
	select * from covid_vaccinations
	select count(*) as rows from covid_vaccinations
	select count(*) as columns from information_schema.columns where table_name = 'covid_vaccinations'
	select column_name, data_type from information_schema.columns where table_name = 'covid_vaccinations'
	
--- data exploration ---
	select * from covid_deaths
	-- where date  between '2020-01-01' and '2021-04-30'
	-- where location ilike '%states%'
	-- where continent is not null
	order by 3, 4 

	--
	select * from covid_vaccinations
	-- where date  between '2020-01-01' and '2021-04-30'
	-- where location ilike '%states%'
	-- where continent is not null
	order by 3, 4
	
	-- select data that we are going to be using
	select
		location,
		date,
		total_cases,
		new_cases,
		total_deaths,
		population
	from covid_deaths
	order by 1, 2
	
	-- looking at total cases vs total deaths
	-- shows the likelihood of dying if you contract covid in your country
	select
		location,
		date,
		total_cases,
		total_deaths,
		(total_deaths::float/total_cases) * 100 as death_percentage
	from covid_deaths
	-- where date  between '2020-01-01' and '2021-04-30'
	 where location ilike '%states%'
	-- where continent is not null
	order by 1, 2 
	
	-- looking at total cases vs population
	-- showing what percentage of population got covid
	select
		location,
		date,
		population,
		total_cases,
		(total_cases::float/population) * 100 as percent_population_infected
	from covid_deaths
	-- where date  between '2020-01-01' and '2021-04-30'
	-- where location ilike '%states%'
	-- where continent is not null
	order by 1, 2

	-- looking at countries with highest infection rate compared to population
	select
		location,
		population,
		max(total_cases) as highest_infection_count,
		max(total_cases::float/population) * 100 as percent_population_infected
	from covid_deaths
	-- where date  between '2020-01-01' and '2021-04-30'
	-- where location ilike '%states%'
	-- where continent is not null
	group by 1, 2
	order by 4 desc
	
	-- showing countries with highest death count per population
	 select
	 	location,
		max(total_deaths) as death_count
	 from covid_deaths
	 -- where date  between '2020-01-01' and '2021-04-30'
	 -- where location ilike '%states%'
	 where continent is not null
	 group by 1
	 order by 2 desc

	-- 
	select
		location,
		max(total_deaths) as death_count
	from covid_deaths
	 -- where date  between '2020-01-01' and '2021-04-30'
	 -- where location ilike '%states%'
	 where continent is null
	 group by 1
	 order by 2 desc
	 
	 -- lets break things down by continent
	 -- showing the continents with the highest death count per population
	 select
	 	continent,
		max (total_deaths) as death_count
	 from covid_deaths
	 -- where date  between '2020-01-01' and '2021-04-30'
	 -- where location ilike '%states%'
	 where continent is not null
	 group by 1
	 order by 2 desc

	--
	select
		continent,
		max (total_deaths) as death_count
	from covid_deaths
	-- where date  between '2020-01-01' and '2021-04-30'
	-- where location ilike '%states%'
	-- where continent is null
	group by 1
	order by 2 desc
	 
	 -- global numbers
	select
	 	-- date,
	 	sum(new_cases) as total_cases,
		sum(new_deaths) as total_deaths,
		sum(new_deaths)::float/sum(new_cases) * 100 as death_percentage
	 from covid_deaths
	 -- where location like '%states%'
	 where continent is not null
	 -- group by date
	 order by 1, 2

	 -- looking at total population vs vaccinations
	 select *
	 from covid_deaths as d
	 join covid_vaccinations as v
	 	on d.location = v.location
	 and d.date = v.date

	 --
	 select
	 	d.continent,
		d.location,
		d.date,
		d.population,
		v.new_vaccinations
	 -- sum(v.new_vaccinations) over (partition by d.location order by d.location, d.date) as rolling_people_vaccinated
	 -- (rolling_people_vaccinated/population)*100
	 from covid_deaths as d
	 join covid_vaccinations as v
	 	on d.location = v.location
	 	and d.date = v.date
	 where d.continent is not null
	 order by 2, 3
	 
	 -- using cte
	 with pop_vs_vac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
	 as(
	 	select
			d.continent,
		 	d.location,
		 	d.date,
		 	d.population,
		 	v.new_vaccinations,
	 		sum (v.new_vaccinations) over (partition by d.location order by d.location, d.date) as rolling_people_vaccinated
	 		-- (rolling_people_vaccinated/population) *100
	 	from covid_deaths as d
	 	join covid_vaccinations as v
	 		on d.location =v.location
	 		and d.date = v.date
	 	where d.location is not null
	 	-- order by 2, 3
	 	)
	 select *,
	 	(rolling_people_vaccinated/population) *100
	 from pop_vs_vac
	 
	 -- temp table
	 drop table if exists percent_population_vaccinated

	 --
	 create temporary table percent_population_vaccinated
	 (
	 continent varchar(200),
	 location varchar(200),
	 date date,
	 population numeric,
	 new_vaccinations numeric,
	 rolling_people_vaccinated numeric
	 )

	 --
	 insert into percent_population_vaccinated
	 select
	 	d.continent,
		d.location,
		d.date,
		d.population,
		v.new_vaccinations,
	 	sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date) as rolling_people_vaccinated
	 	-- (rolling_people_vaccinated/population) *100
	 from covid_deaths as d
	 join covid_vaccinations as v
		on d.location=v.location
	 	and d.date=v.date 
	 -- where d.continent is not null
	 -- order by 2, 3

	 --
	 select *,
	 	(rolling_people_vaccinated/population) * 100 as percent_vaccinated
	 from percent_population_vaccinated

	 -- creating view to store data for late data visualizations
	 create view percent_population_vaccinated
	 as
	 	select
	 		d.continent,
			d.location,
			d.date,
			d.population,
			v.new_vaccinations,
	 		sum(v.new_vaccinations) over(partition by d.location order by d.location, d.date) as rolling_people_vaccinated
	 		-- (rolling_people_vaccinated/population) *100
	 	from covid_deaths as d
	 	join covid_vaccinations as v
			on d.location=v.location
	 		and d.date=v.date 
	 	where d.continent is not null
		-- order by 2, 3

	--
	select *
	from percent_population_vaccinated