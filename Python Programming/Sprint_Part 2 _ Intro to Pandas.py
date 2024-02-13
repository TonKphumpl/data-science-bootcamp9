# -*- coding: utf-8 -*-

# -- Sheet --

# # Basic Pandas


import pandas as pd

# pd.dataframe()
# pd.pivot_table()

# ## Create DataFrame


# create dataframe from scratch

raw_data = {
    "name": ["Ton", "Joe", "Mary", "John", "Anna"],
    "age": [23, 25, 20, 22, 31],
    "gender": ["M", "M", "F", "M", "F"]
}

df = pd.DataFrame(raw_data)

df

# ## Add a new column


df['city'] = ['London', 'London', 'London', 'Manchester', 'Manchester']

df

df.shape

# ## Drop column and row


# ### Column




# drop column city
df = df.drop('city', axis=1)

df

# ### Row


# drop rows or index = 2
df = df.drop(2, axis=0)

df

# ### Reset index


# reset index
df = df.reset_index(drop=True)
df

# ## Rename columns


# column names
df.columns

# ### Convert : Index to List


# index => list
list(df.columns)

# rename columns
df.columns = ['nickname', 'age', 'sex']
df

# ## Series vs DataFrame


type(df['nickname'])

type(df)

# ### Create series


# create a new series
s1 = pd.Series(['Mary', 20, 'F'], index=['nickname', 'age', 'sex'])
print(s1)
print(type(s1))

# append s1 to df
df = df.append(s1, ignore_index=True)
df

s2 = pd.Series(['London', 'London', 'London', 'Manchester', 'Liverpool'])
df['city'] = s2
df

# ## Write CSV file


# write csv file
df.to_csv('mydata.csv')

# ## Upload data to datalore


# import csv file
df2 = pd.read_csv('data/data.csv')
df2

# ## Read Excel data


# import excel file
import pandas as pd
df3 = pd.read_excel('data/data.xlsx')

df3

# ## JSON : JavaScript Object Notation


# import json
df4 = pd.read_json('data/data.json')
df4

df4['myFavorite'].dtype

