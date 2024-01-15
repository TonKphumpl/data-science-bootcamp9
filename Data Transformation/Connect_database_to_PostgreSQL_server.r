restaurant_pizza <- dbConnect(
  PostgreSQL(),
  host = "floppy.db.elephantsql.com",
  dbname = "mifbsjfc",
  user = "mifbsjfc",
  password = "vSy6zstvlCouHP8IuI0YRZvoBT6irs_d",
  port = 5432
)

# table 1 : List of customers who ordered food in 2023 and the total price of the food.
orderdate <- c("2023-11-15","2023-11-15","2023-11-15","2023-11-15", "2023-12-10", "2023-12-10", "2023-12-28", "2023-12-28")
fullname <- c("John Smith", "John Smith","John Smith","John Smith", "Mary Brown", "Mary Brown", "Jim White", "Jim White")
gender <- c("Male", "Male","Male","Male", "Female", "Female", "Male","Male")
age <- c(18, 18, 18, 18, 22, 22, 28, 28)
quantity <- c(1,4,2,3,1,1,2,2)
totalprice <- c(40,900,758,1350,40,379,598,900)
productname <- c("Coke", "Frenchfried", "Hawaiian", "Seafoodcocktail", "Coke", "Frenchfried", "Pepperoni", "Seafoodcocktail")
ord_customers_2023 <- data.frame(date = orderdate, 
                                 name = fullname, 
                                 gender,
                                 ages = age,
                                 Amount = quantity,
                                 totalprice,
                                 Product = productname)

# table 2 : Top 3 most ordered food items
top3_food <- tribble(
  ~productname, ~quantity_order, ~total_price,
  "Hawaiian",          6,            2274,
  "Seafoodcocktail",   5,            2250,
  "Frenchfried",       5,            1279
)

# table 3 : What food will female customers order during the period 2023 - 2024?
food_fm_2023to2024 <- tibble(Fullname = fullname <- c("Mary Brown", "Mary Brown", "Taylor Swift"),
                         Gender = gender <- c("Female", "Female", "Female"),
                         Age = age <- c(22,22,35),
                         Product = productname <- c("Coke", "Frenchfried", "Hawaiian"))

# table 4 : Customers with the most purchase during 2023-2024
vip_customer <- tribble(
  ~fullname, ~totalprice,
  "John Smith", 3048
)
  

## write table to database
dbWriteTable(restaurant_pizza, "ord_customers_2023", ord_customers_2023)
dbWriteTable(restaurant_pizza, "top3_food_2023", top3_food)
dbWriteTable(restaurant_pizza, "food_fm_2023to2024", food_fm_2023to2024)
dbWriteTable(restaurant_pizza, "vip_customer", vip_customer)

## get data
dbGetQuery(restaurant_pizza, "select * from ord_customers_2023")
dbGetQuery(restaurant_pizza, "select * from top3_food_2023")
dbGetQuery(restaurant_pizza, "select * from food_fm_2023to2024")
dbGetQuery(restaurant_pizza, "select * from vip_customer")

## db List Tables
dbListTables(restaurant_pizza)
Output:
[1] "ord_customers_2023" "top3_food_2023"     "vip_customer"      
[4] "food_fm_2023to2024"

## close connection
dbDisconnect(restaurant_pizza)
