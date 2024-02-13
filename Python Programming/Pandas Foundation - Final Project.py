# -*- coding: utf-8 -*-

# -- Project --

# # Final Project - Analyzing Sales Data
# 
# **Date**: 12 February 2024
# 
# **Author**: Phumpanlop Klinyoo
# 
# **Course**: `Pandas Foundation`


# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# preview top 5 rows
df.head(5)

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# We can use `pd.to_datetime()` function to convert columns 'Order Date' and 'Ship Date' to datetime.


# example of pd.to_datetime() function
pd.to_datetime(df['Order Date'].head(), format='%m/%d/%Y')

# TODO - convert order date and ship date to datetime in the original dataframe
df['Order Date1'] = pd.to_datetime(df['Order Date'], format='%m/%d/%Y')
df['Ship Date1'] = pd.to_datetime(df['Ship Date'], format='%m/%d/%Y')
df.head()

# TODO - count nan in postal code column
df.isna().sum()

# TODO - filter rows with missing values
clean_df = df.dropna()
clean_df.isna().sum()

# TODO - Explore this dataset on your owns, ask your own questions
df.head()

# ## Data Analysis Part
# 
# Answer 10 below questions to get credit from this course. Write `pandas` code to find answers.


# TODO 01 - how many columns, rows in this dataset
df.shape

# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum()

# TODO 03 - your friend ask for `California` data, filter it and export csv for him

California_df = df[ df['State'] == 'California' ]

California_df.to_csv('California_df.csv')

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file

start_date = '2017-01-01 00:00:00'
end_date = '2017-12-31 00:00:00'

df_2017 = df[(df['Order Date1'] >= start_date) & (df['Order Date1'] <= end_date) ]
df_2017_cali_tex = df_2017[(df_2017['State'] == 'California') | (df_2017['State'] == 'Texas') ]

df_2017_cali_tex.to_csv('df_2017_cali_tex.csv')

# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017

df_2017['Sales'].agg(['sum', 'mean', 'std'])

# TODO 06 - which Segment has the highest profit in 2018
start_date = '2018-01-01 00:00:00'
end_date = '2018-12-31 00:00:00'

df_2018 = df[(df['Order Date1'] >= start_date) & (df['Order Date1'] <= end_date) ]
df_2018.groupby('Segment')['Profit'].sum().head(1)

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019

start_date = '2019-04-15 00:00:00'
end_date = '2019-12-31 00:00:00'

top_leastsales_state = df[(df['Order Date1'] >= start_date) & (df['Order Date1'] <= end_date) ]
top_leastsales_state.groupby('State')['Sales'].sum().sort_values(ascending=True).head()

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 

start_date = '2019-01-01 00:00:00'
end_date = '2019-12-31 00:00:00'

sales_2019 = df[(df['Order Date1'] >= start_date) & (df['Order Date1'] <= end_date) ]
region_sales_2019 = sales_2019.groupby('Region')['Sales'].sum()

totalsales_2019 = sales_2019['Sales'].sum()

region_sales_2019_percent = (region_sales_2019 / totalsales_2019) * 100

west = region_sales_2019_percent[3]
central = region_sales_2019_percent[0]

print(west + central)

# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020

start_date = '2019-01-01 00:00:00'
end_date = '2020-12-31 00:00:00'

df_2019_2020 = df[(df['Order Date1'] >= start_date) & (df['Order Date1'] <= end_date) ]
filter_df_2019_2020 = df_2019_2020[ ['Product Name', 'Quantity', 'Sales', 'Order Date1'] ]
filter_df_2019_2020.reset_index().groupby('Product Name')\
                                 .agg({'Product Name': 'count', 'Sales': 'sum'})\
                                 .rename(columns= {'Product Name': 'Total Orders', 'Sales': 'Total Sales'})\
                                 .sort_values('Total Orders', ascending=False)\
                                 .head(10)
                                 

# TODO 10 - plot at least 2 plots, any plot you think interesting :)

# 1. Ship Mode
ship_mode = df[ ['Ship Mode'] ].value_counts().plot(kind='bar', color=['green', 'orange', 'yellow', 'red'])

print(['ship_mode'])

# 2. Sales vs. Profit

df[['Sales', 'Profit']].plot(x='Sales', y='Profit', kind="scatter", color="orange")

# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions

import numpy as np

# Q1. Orders with a profit of more than 0 
df['Profit > 0 ?'] = np.where(df['Profit'] > 0, 1, 0)


# Q2. Which orders have a discount?
df['Have or not discount'] = np.where(df['Discount'] == 0, 0, 1)


