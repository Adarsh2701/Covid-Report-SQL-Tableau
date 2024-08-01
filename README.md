# Covid Report (SQL Tableau)

# Context
A new coronavirus, designated 2019-nCoV, was first identified in Wuhan, the capital of China's Hubei province. People developed pneumonia without a clear cause and for which existing vaccines or treatments were not effective. The virus has shown evidence of human-to-human transmission, and the transmission rate (rate of infection) appeared to escalate in mid-January 2020. As of 30 January 2020, approximately 8,243 cases have been confirmed.

# Project Overview
This project involves analyzing COVID-19 data to gain insights into the spread and impact of the virus. The analysis was performed using SQL for data processing and Tableau for data visualization. The project includes the following components:

Data Processing: SQL scripts to clean and process the COVID-19 data.

Data Visualization: Tableau dashboard to visualize the COVID-19 data.

Data Sources: Two CSV files containing COVID-19 death and vaccination data.

# Files in the Repository
CovidDeath.csv: Contains data related to COVID-19 deaths.

CovidVaccinations.csv: Contains data related to COVID-19 vaccinations.

Covid_report.sql: SQL script used to process and analyze the COVID-19 data.

Covid_Report.twbx: Tableau workbook containing the dashboard.

# Instructions for Reproducing the Analysis
Prerequisites

SQL Server or any other SQL database management system.

Tableau Desktop for visualization.

Git to clone the repository.

# Data Dictionary
CovidDeath.csv

continent: Continent of the reported cases.

location: Location (country/region) of the reported cases.

date: Date of the reported cases.

population: Population of the location.

new_deaths: Number of new deaths reported.

total_deaths: Total number of deaths reported.

CovidVaccinations.csv

location: Location (country/region) of the reported vaccinations.

date: Date of the reported vaccinations.

new_vaccinations: Number of new vaccinations reported.

total_vaccinations: Total number of vaccinations reported.

# Tableau Dashboard
The Tableau dashboard provides the following insights:

Total Cases and Deaths: Visual representation of the total number of COVID-19 cases and deaths over time.

Vaccination Progress: Visualization of the vaccination progress across different regions.

Rolling People Vaccinated: Analysis of the cumulative number of people vaccinated over time.

# Conclusion
This project provides a comprehensive analysis of the COVID-19 pandemic, utilizing SQL for data processing and Tableau for data visualization. The insights derived from the analysis can help understand the spread and impact of the virus, as well as the progress of vaccination efforts.
