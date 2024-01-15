create table customers (
  customerid int unique primary key,
  firstname varchar(10),
  lastname varchar(10),
  gender varchar(1),
  age int,
  email varchar(20),
  phone int unique
);

create table orders (
  orderid int unique primary key,
  customerid int,
  productid int,
  quantity int,
  totalprice int,
  orderdate date
);

create table products (
  productid int unique primary key,
  productname varchar(10),
  price int,
  category varchar(10)
);

insert into customers values 
  (1, 'John', 'Smith', 'Male', 18, 'john.s@gmail.com', 0965412387),
  (2, 'Mary', 'Brown', 'Female', 22, 'mary.b@gmail.com', 0865412981),
  (3, 'Jim', 'White', 'Male', 28, 'jim.w@gmail.com', 023654189),
  (4, 'Tony', 'Ja', 'Male', 40, 'tony.j@gmail.com', 0658974126),
  (5, 'Taylor', 'Swift', 'Female', 35, 'taylor.s@gmail.com', 0369745826)
;

insert into orders values
  (1, 1, 1, 2, 758, '2023-11-15'),
  (2, 1, 4, 3, 1350, '2023-11-15'),
  (3, 1, 5, 4, 900, '2023-11-15'),
  (4, 1, 7, 1, 40, '2023-11-15'),
  (5, 2, 5, 1, 379, '2023-12-10'),
  (6, 2, 7, 1, 40, '2023-12-10'),
  (7, 3, 3, 2, 598, '2023-12-28'),
  (8, 3, 4, 2, 900, '2023-12-28'),
  (9, 4, 1, 2, 758, '2024-01-01'),
  (10, 4, 2, 2, 598, '2024-01-01'),
  (11, 4, 6, 3, 300, '2024-01-01'),
  (12, 5, 1, 2, 758, '2024-01-07')
;

insert into products values
  (1, 'Hawaiian', 379, 'Pizza'),
  (2, 'Doublecheese', 299, 'Pizza'),
  (3, 'Pepperoni', 299, 'Pizza'),
  (4, 'Seafoodcocktail', 450, 'Pizza'),
  (5, 'Frenchfried', 80, 'Snack'),
  (6, 'Friedchicken', 100, 'Snack'),
  (7, 'Coke', 40, 'Drink')
;

.mode box
-- Query1 : List of customers who ordered food in 2023 and the total price of the food.
-- Supqueries
    SELECT 
      orderdate,
      firstname || " " || lastname AS fullname,
      gender,
      age,
      quantity,
      totalprice,
      productname
    FROM (SELECT  *
          FROM customers
          JOIN orders   ON customers.customerid = orders.customerid
          JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
    WHERE STRFTIME("%Y", orderdate) = '2023'
    GROUP BY firstname, lastname, productname
    ORDER BY orderdate ASC;

--Query2 : Top 3 most ordered food items
-- Supqueries
SELECT 
  productname,
  SUM(quantity) AS quantity_order,
  SUM(totalprice) AS total_price
FROM (SELECT  *
      FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
GROUP BY productname
ORDER BY quantity_order DESC
Limit 3;

--Query3 : What food will female customers order during the period 2023 - 2024?
-- Supqueries
SELECT 
  firstname || " " || lastname AS fullname,
  gender,
  age,
  productname
FROM (SELECT  *
      FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
WHERE gender = 'Female'
AND STRFTIME("%Y", orderdate) BETWEEN '2023' AND '2024'
GROUP BY firstname, lastname, productname
ORDER BY orderdate ASC;

--Query4 : Customers with the most purchases.
--Subqueries
SELECT 
  firstname || " " || lastname AS fullname,
  SUM(totalprice)
FROM (SELECT  *
      FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
GROUP BY firstname, lastname
ORDER BY SUM(totalprice) DESC
Limit 1;

  




    


  


  











