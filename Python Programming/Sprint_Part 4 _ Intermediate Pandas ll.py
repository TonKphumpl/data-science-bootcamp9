# -*- coding: utf-8 -*-

# -- Sheet --

import pandas as pd

penguins = pd.read_csv('penguins.csv')

# # Describe


# summerise dataframe
penguins.describe(include='all')

# ## Mean


# average, mean
penguins['bill_length_mm'].mean()

# ## Standard Deviation (SD)


penguins['bill_length_mm'].std()

# ## Median


penguins['bill_length_mm'].median()

# # Group by


# group by + sum/ mean
# penguins[penguins['species'] == 'Adelie']['bill_length_mm'].mean()

penguins.groupby('species')['bill_length_mm'].mean() # or .sum() | .median()

# # Group by aggregation


# ## Single Column


penguins.groupby('species')['bill_length_mm'].agg(['min', 'mean', 'median', 'std', 'max'])

# ## Multiple columns


# group by more than one column
result = penguins.groupby(['island', 'species'])['bill_length_mm'].agg(['min', 'mean', 'max']).reset_index()

result.to_csv('result.csv')

# # If your code is long


# If your code is long
penguins.groupby(['island', 'species'])['bill_length_mm'] \
        .agg(['min', 'mean', 'max']) \
        .reset_index()

# # Map


# map values MALE: m, FEMALE: f
# penguins['sex'].head()

penguins['sex_new'] = penguins['sex'].map( {'MALE': 'm', 'FEMALE': 'f'} ) \
                                     .fillna('other')

penguins.head()

# # Numpy


# pandas style
penguins['bill_length_mm'].mean()

# numpy
import numpy as np
np.mean(penguins['bill_length_mm'])

# other function of money
print(np.sum(penguins['bill_depth_mm']))
print(np.std(penguins['body_mass_g']))

# ## Where


import numpy as np

# ## Score


score = pd.Series([80, 55, 62, 95, 20])

print(score)

grade = np.where(score >= 80, 'passed', 'failed')

print(grade)

# ## Penguins


df = penguins.query("species == 'Adelie' ")[['species', 'island', 'bill_length_mm']].dropna()

df['new_column'] = np.where(df['bill_length_mm'] > 40, True, False)

df.head(10)

# # Merge Dataframe


left = {
    'key': [1, 2, 3, 4],
    'name': ['ton', 'joe', 'jane', 'anan'],
    'age': [23, 28, 30, 22]
}

right = {
    'key': [1, 2, 3, 4],
    'city': ['Bangkok', 'London', 'Seoul', 'Tokyo'],
    'zip': [1001, 2504, 2094, 9802]
}

df_left = pd.DataFrame(left)
df_right = pd.DataFrame(right)

df_left

import  pandas as pd
df_result = pd.merge(df_left, df_right, on='key')

df_result

# # Intro to Pandas Plots


# ## Histogram


# ### 1 column


# histogram one column
penguins['body_mass_g'].plot(kind='hist');

# ### 2 columns


# histogram two columns
penguins[['body_mass_g', 'bill_length_mm']].plot(kind='hist', bins=30)

penguins['bill_length_mm'].plot(kind='hist', bins=30, color="orange");

# ## Bar Plot


# bar plot for species
penguins['species'].value_counts().plot(kind='bar', color=['salmon', 'orange', 'gold'])

# ## Scatter plot


# scatter plot
penguins[['bill_length_mm', 'bill_depth_mm']] \
        .plot(x='bill_length_mm', y='bill_depth_mm', kind="scatter", color="orange")

# # DataLore Visualization


penguins

