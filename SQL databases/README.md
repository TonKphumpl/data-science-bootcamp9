**SQL Database**
-----------------------------------------------------

I gained proficiency in writing and utilizing sophisticated Structured Query Language (SQL) statements. 
The program equipped me with the skills to effectively manipulate and analyze data, allowing me to retrieve specific information from tables through via using clauases and effortlessly combine data from multiple sources using JOIN clause.
This experience also provided me with valuable knowledge on various SQL functions, enabling me to filter, aggregate, and format data with ease.

**Tools**

- [Replit](https://replit.com/~)

  ![image](https://github.com/TonKphumpl/data-science-bootcamp9/assets/139863067/79151632-539b-4602-aeec-5438d158d2e7)

- [SQLite online](https://sqliteonline.com/)

  ![image](https://github.com/TonKphumpl/data-science-bootcamp9/assets/139863067/1bc48753-67e9-4f1b-b247-dd9a9ae91c82)


**Skills** 

- [Intro to Database and CRUD](https://www.notion.so/Sprint-02-Intro-to-Database-and-CRUD-1c083b871ce64f7788232156fd74c39d?pvs=4).
- [SQL for Data Analyst 101](https://www.notion.so/Sprint-02-SQL-for-Data-Analyst-101-47941286266b4617b122148596ce79de?pvs=4).
- [SQL for Data Analyst 102](https://www.notion.so/Sprint-02-SQL-for-Data-Analyst-102-1cdeed2dab9645cdb902bdefc8a95147?pvs=4).
- [SQL for Data Analyst 103](https://www.notion.so/Sprint-02-SQL-for-Data-Analyst-103-73bb48039b234bc29ad670d95ad9f739?pvs=4).

Mini Project:
-

[Pizza Restaurant](https://replit.com/@PhumpanlopKliny/sqlhomeworkbatch09TonPhumpl).
 
I build tables( customers, products, orders ) for simulate pizza restaurant and write 4 subquery for extracting data

- Query1 : List of customers who ordered food in 2023 and the total price of the food.
- Query2 : Top 3 most ordered food items
- Query3 : What food will female customers order during the period 2023 - 2024?
- Query4 : Customers with the most purchases.

**SQL Code**

- Query1 : List of customers who ordered food in 2023 and the total price of the food.
  
      SELECT 
            orderdate,
            firstname || " " || lastname AS fullname,
            gender,
            age,
            quantity,
            totalprice,
            productname
      FROM (SELECT  * FROM customers
            JOIN orders   ON customers.customerid = orders.customerid
            JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
      WHERE STRFTIME("%Y", orderdate) = '2023'
      GROUP BY firstname, lastname, productname
      ORDER BY orderdate ASC;

- Query2 : Top 3 most ordered food items 

      SELECT 
            productname,
            SUM(quantity) AS quantity_order,
            SUM(totalprice) AS total_price
      FROM (SELECT  * FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
      GROUP BY productname
      ORDER BY quantity_order DESC
      Limit 3;

- Query3: What food will female customers order during the period 2023 - 2024?

      SELECT 
            firstname || " " || lastname AS fullname,
            gender,
            age,
            productname
      FROM (SELECT  * FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
      WHERE gender = 'Female'
      AND STRFTIME("%Y", orderdate) BETWEEN '2023' AND '2024'
      GROUP BY firstname, lastname, productname
      ORDER BY orderdate ASC;

- Query4 : Customers with the most purchases.

      SELECT 
            firstname || " " || lastname AS fullname,
            SUM(totalprice)
      FROM (SELECT  * FROM customers
      JOIN orders   ON customers.customerid = orders.customerid
      JOIN products ON orders.productid = products.productid) AS Detail_OrdersCustomers_2023
      GROUP BY firstname, lastname
      ORDER BY SUM(totalprice) DESC
      Limit 1;

[Create connection with RPostgreSQL](https://www.notion.so/Data-transformation-and-PostgreSQL-fe27e3c22a684267a63e25b8f0e3a314?pvs=4).

![Screenshot 2024-02-25 232641](https://github.com/TonKphumpl/data-science-bootcamp9/assets/139863067/2cc05bc6-6f44-4558-8cfb-767327d839e5)

![image](https://github.com/TonKphumpl/data-science-bootcamp9/assets/139863067/efc513fe-d138-46e0-b3b4-5a781d3f7d13)


