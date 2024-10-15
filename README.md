
# Covid-19-vaccination-Python

## README: COVID-19 Vaccination Data Analysis

### Project Overview

This project focuses on analyzing COVID-19 vaccination data to gain insights into global vaccination trends and relationships with socio-economic indicators. We use a dataset from the Our World in Data repository to explore the connections between vaccination rates and factors like GDP per capita, life expectancy, human development index (HDI), and median age.

You can find the Tableau visualizations for this analysis [here](https://public.tableau.com/app/profile/andor.varsanyi5689/viz/COVID-19_17283452139880/Dashboard).

### Getting Started

#### Prerequisites

To run this analysis, you'll need to install the following Python packages:

- pandas
- numpy
- matplotlib
- seaborn
- scipy
- scikit-learn

You can install these packages by running:

```bash
pip install pandas numpy matplotlib seaborn scipy scikit-learn

### Dataset

The dataset used is `owid-covid-data.csv`, which contains global COVID-19 vaccination data. Make sure the CSV file is located in the same directory as the script.

### Importing Libraries and Data

We start by importing the necessary libraries and loading the data:

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats

df = pd.read_csv('owid-covid-data.csv')
```

### Data Preprocessing

#### Data Inspection:

- General statistics: `df.describe()`
- Info about data types and null values: `df.info()`

#### Date Format: Convert the date column to datetime format:

```python
df['date'] = pd.to_datetime(df['date'])
```

#### Handling Null Values: We dropped rows with missing data for cleaner analysis:

```python
vaccination_df = vaccination_df.dropna(how='any').reset_index(drop=True)
```

### Data Aggregation

We narrowed down the dataset by grouping it by continent and location (country) and aggregating relevant socio-economic indicators:

```python
vaccination_df = df.groupby(['continent', 'location']).agg({
    'people_vaccinated': 'max',
    'population': 'max',
    'gdp_per_capita': 'max',
    'population_density': 'max',
    'median_age': 'max',
    'human_development_index': 'max',
    'reproduction_rate': 'max',
    'life_expectancy': 'max'
}).reset_index()
```

### Key Metrics

We created a key metric: Vaccinated Population Ratio:

```python
vaccination_df['vaccinated_ratio'] = vaccination_df['people_vaccinated'] / vaccination_df['population']
```

### Exploratory Data Analysis (EDA)

We conducted both univariate and bivariate analyses to understand the distributions and relationships in the dataset.

#### Univariate Analysis

We visualized the distributions of numerical columns using histograms and box plots, and we analyzed the skewness and kurtosis of the data.

#### Bivariate Analysis

We analyzed relationships between variables using:

- Pairplots
- Correlation heatmaps
- Boxplots

### Multivariate Analysis

We explored relationships across multiple variables using scatter plots and pairplots:

```python
sns.scatterplot(x='gdp_per_capita', y='vaccinated_ratio', size='population', hue='continent', data=vaccination_df)
```

### Linear Regression Model

We used a Linear Regression model to analyze the impact of GDP per capita, HDI, and median age on vaccination ratios:

```python
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error, r2_score

X = vaccination_df[['gdp_per_capita', 'human_development_index', 'median_age']]
y = vaccination_df['vaccinated_ratio']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = LinearRegression()
model.fit(X_train, y_train)

y_pred = model.predict(X_test)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)
```

### Model Results

- R-squared: 0.368 (36.8% of variance explained)

#### Key Influences:

- HDI had the largest positive impact on vaccination rates.

### Conclusions

- Countries with higher HDI and GDP per capita tend to have higher vaccination rates.
- Regional disparities exist, with Africa showing lower vaccination rates and Europe leading across most indicators.
- There is a positive correlation between vaccination rates and life expectancy, GDP per capita, and HDI.

### Future Work

- Explore additional socio-political factors impacting vaccination rates.
- Refine the regression model by incorporating more variables to improve accuracy.

### License

This project is licensed under the MIT License.
