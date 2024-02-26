## homework

## transform nycflight13

library(nycflights13)
library(tidyverse)
library(dplyr)

## ask 5 questions about this dataset
data("flights")
data("airlines")

## select filter arrange mutate summarise count

# ?flights = help()
## Q1. In the first quarter, which were the top 5 airlines with the longest flight delays? 
flights %>%
  filter(month %in% c(1,2,3), year == 2013) %>%
  select(month, carrier, dep_delay, arr_delay, origin, dest) %>%
  arrange(desc(dep_delay)) %>%
  head(5) %>%
  left_join(airlines, by="carrier")

## Q2. Top 5 most popular pairs of origin and destination stations in 2013
Pop_ori_dest <- flights %>%
  select(origin, dest, distance) %>%
  group_by(origin, dest) %>%
  summarise(mean_distance = mean(distance),
            times = n()) %>%
  arrange(desc(times)) %>%
  head(5)
  
## Q3. Top 5 popular airlines and not the most popular
Unpop_al <- flights %>%
  select(Airlines = "carrier") %>%
  count(Airlines) %>%
  arrange(n) %>%
  head(5) %>%
  left_join(airlines, by = c("Airlines" = "carrier"))

Pop_al <- flights %>%
  select(Airlines = "carrier") %>%
  count(Airlines) %>%
  arrange(desc(n)) %>%
  head(5) %>%
  left_join(airlines, by = c("Airlines" = "carrier"))

##Q4. The most Airtime of origin and dest  
at_oridest <- flights %>%
  filter(air_time != "") %>%
  select(carrier, origin, dest, air_time) %>%
  group_by(origin, dest) %>%
  summarise(mean_airtimes = mean(air_time),
            times = n()) %>%
  arrange(desc(mean_airtimes)) %>%
  head(10)

##Q5. Statistics from 2013 on flights that departed ahead of schedule
stat_fl_2013 <- flights %>%
  select(Airlines = "carrier", origin, dest, dep_delay ) %>%
  filter(dep_delay < 0) %>%
  group_by(Airlines, origin, dest) %>%
  summarise(Avg_depdelay = mean(dep_delay),
            max_depdelay = max(dep_delay),
            med_depdelay = median(dep_delay),
            min_depdelay = min(dep_delay),
            times = n(),
            var_depdelay = var(dep_delay),
            sd_depdelay = sd(dep_delay)) %>%
  arrange(desc(times))

## HW2 connect db to PostgreSQL server

restaurant_pizza <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "mifbsjfc",
  user = "mifbsjfc",
  password = "vSy6zstvlCouHP8IuI0YRZvoBT6irs_d",
  port = 5432
)

customers <- tibble(
  customerid = c(1, 2, 3, 4, 5),
  firstname = c('John', 'Mary', 'Jim', 'Tony', 'Taylor'),
  gender = c('Male', 'Female', 'Male', 'Male', 'Female'),
  age = c(18, 22, 28, 40, 35),
  email = c('john.s@gmail.com', 'mary.b@hotmail.com', 'jim.w@yahoo.com', 'tony.j@gmail.com', 'taylor.s@gmail.com')
)

orders <- tibble(
  orderid = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
  customerid = c(1,1,1,1,2,2,3,3,4,4,4,5),
  productid = c(1,4,5,7,5,7,3,4,1,2,6,1),
  orderdate = as.Date(c('2023-11-15','2023-11-15','2023-11-15','2023-11-15','2023-12-10','2023-12-10','2023-12-28','2023-12-28','2024-01-01','2024-01-01','2024-01-01','2024-01-07'))
)

products <- tibble(
  productid = c(1,2,3,4,5,6,7),
  productname = c('Hawaiian','Doublecheese','Pepperoni','Seafoodcocktail','Frenchfried','Friedchicken','Coke'),
  price = c(379, 299, 299, 450, 80, 100, 40)
)
  

## write table to database
dbWriteTable(restaurant_pizza, "customers", customers)
dbWriteTable(restaurant_pizza, "orders", orders)
dbWriteTable(restaurant_pizza, "products", products)


## get data
# Query 1 : Total purchases of all 5 customers
dbGetQuery(restaurant_pizza, 
"SELECT 
  firstname as name, 
  SUM(price) totalprice  
FROM orders
JOIN customers ON orders.customerid = customers.customerid
JOIN products ON orders.productid = products.productid
GROUP BY 1
ORDER BY 2 desc;
"
)

# Query 2 : Total sales of each product
dbGetQuery(restaurant_pizza,
"
SELECT 
  productname products, 
  count(productname) amount,
  SUM(price) totalprice
FROM orders
JOIN customers ON orders.customerid = customers.customerid
JOIN products ON orders.productid = products.productid
GROUP BY productname
ORDER BY 3 desc;
"
)

# Query 3 : Food menu orders from 2023 to 2024
dbGetQuery(restaurant_pizza,
"
SELECT
  EXTRACT(YEAR FROM orderdate) AS year,
  EXTRACT(MONTH FROM orderdate) AS month,
  price,
  productname
FROM orders
JOIN customers ON orders.customerid = customers.customerid
JOIN products ON orders.productid = products.productid
ORDER BY 1,2;
"
)

# Query 4 : three products that are most frequently ordered by males.
dbGetQuery(restaurant_pizza,
"
SELECT
  productname products,
  count(productname) amount,
  SUM(price) total_price
JOIN customers ON orders.customerid = customers.customerid
JOIN products ON orders.productid = products.productid
WHERE gender = 'Male'
GROUP BY productname
ORDER BY amount desc
Limit 3;
"
)

# Query 5 : Survey the age of customers
dbGetQuery(restaurant_pizza,
"
SELECT 
  AVG(age),
  SUM(age),
  MIN(age),
  MAX(age),
  COUNT(age)
FROM customers
"
)           

## db List Tables
dbListTables(restaurant_pizza)

## close connection
dbDisconnect(restaurant_pizza)

