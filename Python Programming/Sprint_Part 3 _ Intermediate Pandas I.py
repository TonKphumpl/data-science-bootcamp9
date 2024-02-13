# -*- coding: utf-8 -*-

# -- Sheet --

# # Intermediate Pandas


# ## Preview penguins dataframe


import pandas as pd

penguins = pd.read_csv("penguins.csv")

# ### First 5 rows


# preview first 5 rows
penguins.head()

# ### Last 5 rows


# preview last 5 rows
penguins.tail()

# ### Shape of dataframe


# shape of dataframe
penguins.shape

# ### information of dataframe


# information of dataframe
penguins.info()

# ## Select columns


# ### Select 1 column


# select 1 column
penguins.species.head()

# ### Select > 1 columns


# select > 1 columns
penguins[ ['species', 'island', 'sex'] ].tail(8)

# ## iloc : integer location based indexing 


# integer location based indexing (iloc)
mini_penguins = penguins.iloc[ 0:5, 0:3 ]
mini_penguins

# penguins.iloc[ [0,1,2] ]
# penguins.iloc[ 0:3 ]
# penguins.iloc[ 0:5 ]
# penguins.iloc[ 0:5, [0,1,5] ]

# ## Filter dataframe with 1 condition


# filter rows by a condition
penguins[ penguins['island'] == 'Torgersen' ]

penguins[ penguins['bill_length_mm'] < 34 ]

# ## Filter dataframe > 1 condition


# filter more than one condition
# And & , Or |
filter_penguins = penguins[ (penguins['island'] == 'Torgersen') | (penguins['bill_length_mm'] < 35) ]

# ## Query


# filter with .query()
# And & , Or |
penguins.query('island == "Torgersen" & bill_length_mm < 35') # "island == 'Torgersen"

# ## Missing Values


# ### Check missing values


# check missing in each column
penguins.isna().sum()

# ### Filter missing values in column


# filter missing values in column sex 
penguins[penguins['sex'].isna()]

# ### Remove missing values


# drop na
clean_penguins = penguins.dropna()

clean_penguins.head(10)

# ## Fill missing values


# fill missing values
top5_penguins = penguins.head(5)

avg_value = top5_penguins['bill_length_mm'].mean()
print(avg_value)

top5_penguins = top5_penguins['bill_length_mm'].fillna(value=avg_value)
top5_penguins

# ## Sort dataframe


# ### Single column


# sort bill_length_mm low to high, high to low
# low to high => True(default), high to low => False
penguins.dropna().sort_values('bill_length_mm', ascending=False).head(10)

# ### Multiple columns


# sort multiple columns
penguins.dropna().sort_values(['island', 'bill_length_mm'])

# ## Unique and Count


# ### Unique values


# Unique values
penguins['species'].unique()

# ### Count values


# #### Single column


# count values
penguins['species'].value_counts()

# #### Multiple columns


# count more than one columns
result = penguins[ ['island', 'species'] ].value_counts().reset_index()

result.columns = ['island', 'species', 'count']

result

