## connect to PostgreSQL server
library(RPostgreSQL)
library(tidyverse)

## create connection
con <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "mifbsjfc",
  user = "mifbsjfc",
  password = "vSy6zstvlCouHP8IuI0YRZvoBT6irs_d",
  port = 5432
)

## db List Tables
dbListTables(con)

dbWriteTable(con, "products", products)

## get data
df <- dbGetQuery(con, "select id, product_name from products")

## HW02 - restaurant pizza SQL
## create 3-5 dataframes => write table into server






