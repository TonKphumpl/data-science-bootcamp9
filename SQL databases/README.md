**SQL Database**
-----------------------------------------------------

I gained proficiency in writing and utilizing sophisticated Structured Query Language (SQL) statements. The program equipped me with the skills to effectively manipulate and analyze data, allowing me to retrieve specific information from tables through via using clauases

- SELECT  
- WHERE
- Aggregate function 
- Group by
- Having
- Order by
  
and effortlessly combine data from multiple sources using JOIN clause

- Inner join
- Left join

This experience also provided me with valuable knowledge on various SQL functions, enabling me to filter, aggregate, and format data with ease.

**SQL Code in SQLite**

- Select column and build new column
  
      SELECT 
	      invoicedate,
          billingaddress,
          total,
          ROUND(total + (total*0.07), 2) AS total_incl_vat
      FROM invoices

- Create eu_customers table 

        CREATE TABLE eu_customers AS 
            SELECT firstname, country, email 
            FROM customers
            WHERE country IN ('USA', 'France', 'Italy');

- Use WHERE Clause for filter rows

        SELECT 
	        name,
            composer,
            bytes/(1024*1024) AS MB
        FROM tracks
        --WHERE bytes/(1024*1024) >= 8 AND composer LIKE 'Smith%'; 
        --WHERE composer IS NULL; -- Missing value
        --WHERE bytes/(1024*1024) BETWEEN 9 AND 10 -- Inclusive
        LIMIT 5;

- Use aggregate function with measurement columns

        SELECT
            COUNT(*) AS total_songs,
            ROUND(AVG(bytes), 2) AS avg_bytes,
            ROUND(SUM(bytes)/(1024*1024), 2) aS sum_mb,
            MIN(bytes) AS min_bytes,
            MAX(bytes) as max_bytes
        FROM tracks;

- Clean NULL values

        SELECT 
            company,
            --REPLACE NULL
            COALESCE(company, "B2C") AS clean_company, 
            CASE
            	  WHEN company IS NULL THEN "B2C"
                ELSE "B2B"
            END AS segment
        FROM customers;

- HAVING VS. WHERE
  
       SELECT
          CASE
              WHEN company IS NULL THEN "B2C"
              ELSE "B2B"
          END AS segment,
          country,
          COUNT(*) AS num_customers
        FROM customers
        WHERE country IN ('Belgium', 'France', 'Italy')
        GROUP BY 1,2
        HAVING num_customers > 1;

- ORDER BY
 
        SELECT 
          name, 
          ROUND(milliseconds/ 60000.0, 2) AS minute
        FROM tracks
        ORDER BY minute DESC
        LIMIT 5;

- JOIN Tables

        SELECT 
            ar.Name AS artists_name,
            al.Title AS albums_name,
            tr.Name AS tracks_name,
            ge.Name AS genres,
            milliseconds,
            bytes,
            unitprice
        FROM artists 	    AS ar
        INNER JOIN albums AS al ON ar.ArtistId = al.ArtistId -- PK = FK
        INNER JOIN tracks AS tr ON tr.AlbumId  = al.AlbumId
        INNER JOIN genres AS ge ON ge.GenreId  = tr.Genre

- Subqueries

        SELECT firstname, lastname, email, COUNT(*)
        FROM (
            SELECT * FROM customers
          	WHERE country = 'USA'
        ) AS t1
        JOIN (
        	SELECT * FROM invoices
         	WHERE STRFTIME("%Y-%m", invoicedate) = "2009-10"
        ) AS t2
        ON t1.Customerid = t2.Customerid
        GROUP by 1,2,3;
