
# COVID-19 Data Analysis and Exploration Project

## Overview

This repository contains two main components for analyzing COVID-19 data:

1. **Python Analysis**: A Jupyter Notebook that analyzes COVID-19 vaccination data to gain insights into global vaccination trends and their relationships with socio-economic indicators.
2. **SQL Analysis**: A SQL file that explores various aspects of COVID-19 data, including infection rates, death counts, and vaccination progress across different countries and continents.

You can find the Tableau visualizations for this analysis [here](https://public.tableau.com/app/profile/andor.varsanyi5689/viz/COVID-19_17283452139880/Dashboard).


## Python Analysis: COVID-19 Vaccination Data

### Project Overview

The Python component focuses on analyzing COVID-19 vaccination data using a dataset from the Our World in Data repository. The analysis explores connections between vaccination rates and factors like GDP per capita, life expectancy, human development index (HDI), and median age.

### Getting Started

#### Prerequisites

To run this analysis, you'll need to install the following Python packages:

- pandas
- numpy
- matplotlib
- seaborn
- scipy
- scikit-learn

Install these packages using:

```bash
pip install pandas numpy matplotlib seaborn scipy scikit-learn
```

### Dataset

The dataset used is `owid-covid-data.csv`, which contains global COVID-19 vaccination data. Ensure the CSV file is located in the same directory as the script.

### Key Analyses

- **Data Preprocessing**: Includes data inspection, date formatting, and handling null values.
- **Data Aggregation**: Groups data by continent and location, aggregating socio-economic indicators.
- **Exploratory Data Analysis (EDA)**: Conducts univariate and bivariate analyses.
- **Linear Regression Model**: Analyzes the impact of GDP per capita, HDI, and median age on vaccination ratios.

### Conclusions

- Higher HDI and GDP per capita correlate with higher vaccination rates.
- Regional disparities exist, with Africa showing lower vaccination rates.

### Future Work

- Explore additional socio-political factors impacting vaccination rates.
- Refine the regression model by incorporating more variables.

## SQL Analysis: COVID-19 Data Exploration

### Data Source

The SQL component uses data from two main tables:
1. **CovidDeaths**: Information about COVID-19 cases and deaths.
2. **CovidVaccinations**: Information about COVID-19 vaccinations.

### Project Structure

The project consists of a single SQL file containing various queries for different analyses.

### Key Analyses

1. **Initial Data Exploration**: Retrieves key fields from the CovidDeaths table.
2. **Death Percentage Calculation**: Calculates the likelihood of dying if contracting COVID-19 in the United States.
3. **Infection Rate Analysis**: Identifies countries with the highest infection rates.
4. **Death Count Analysis**: Shows countries and continents with the highest death counts.
5. **Global COVID Numbers**: Summarizes total cases, deaths, and death percentage worldwide.
6. **Vaccination Progress**: Analyzes the percentage of the population vaccinated.
7. **Advanced Queries**: Uses CTEs and Temp Tables for partitioned data calculations.
8. **Data Storage for Visualization**: Creates a view for processed data visualization.

### Skills Demonstrated

- SQL Queries
- Joins
- CTEs (Common Table Expressions)
- Temp Tables
- Window Functions
- Aggregate Functions
- Creating Views

## How to Use

1. Ensure you have access to a SQL database with the COVID-19 data tables (CovidDeaths and CovidVaccinations).
2. Copy the SQL code from the provided file.
3. Execute the queries in your SQL environment.
4. Modify the queries as needed for your specific analysis requirements.

## Contributors

Andor Varsanyi

## License

This project is licensed under the MIT License.
