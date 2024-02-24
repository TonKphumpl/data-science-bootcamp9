/*SELECT 
	firstname AS fname, 
    lastname AS lname,
    firstname || " " || lastname AS fullname -- alias create name
FROM customers;*/

/*SELECT 
	invoicedate,
    billingaddress,
    total,
    ROUND(total + (total*0.07), 2) AS total_incl_vat
FROM invoices;*/

SELECT 
	invoicedate,
    -- String Format (Date) Time
    STRFTIME("%Y", invoicedate) AS year,
    STRFTIME("%m", invoicedate) AS month,
    STRFTIME("%d", invoicedate) AS day,
    STRFTIME("%Y-%m", invoicedate) AS monthid
FROM invoices
WHERE monthid = "2009-09";

-- CREATE TABLE eu_customers 
CREATE TABLE eu_customers AS 
    SELECT firstname, country, email 
    FROM customers
    --WHERE country = 'USA';
    --WHERE LOWER(country) = 'UNITED KINGDOM';
    --WHERE UPPER(country) = 'UNITED KINGDOM';
    --WHERE country = 'USA' OR country = 'Brazil' OR country = 'Belgium'; 
    WHERE country IN ('USA', 'France', 'Italy');

DROP TABLE eu_customers;

SELECT 
	name,
    composer,
    bytes/(1024*1024) AS MB
FROM tracks
--WHERE bytes/(1024*1024) >= 8 AND composer LIKE 'Smith%'; -- LIKE IN SQLITE => CASE INSENSITIVE
--WHERE composer IS NULL; -- Missing value
--WHERE bytes/(1024*1024) BETWEEN 9 AND 10 -- Inclusive
LIMIT 5;

/*SELECT
	COUNT(*),
    COUNT(name),
    COUNT(composer), -- contains NULL
    COUNT(name) - COUNT(composer) AS null_in_composer_field
FROM tracks;*/

-- 	AGGREGATE FUNCTION
/*SELECT
	COUNT(*) AS total_songs,
    ROUND(AVG(bytes), 2) AS avg_bytes,
    ROUND(SUM(bytes)/(1024*1024), 2) aS sum_mb,
    MIN(bytes) AS min_bytes,
    MAX(bytes) as max_bytes
FROM tracks;*/

-- BUILD NEW COLUMN BY USE CONDITION
CREATE TABLE num_songs AS
    SELECT
        -- IF ELSE IN SQL
        CASE
            WHEN bytes/(1024*1024) >= 8 THEN "Large"
            WHEN bytes/(1024*1024) >= 3 THEN "Medium"
            --WHEN bytes/(1024*1024) < 3 THEN "Small"
            ELSE "Small"
        END AS segment,
        COUNT(*) AS num_songs
    FROM tracks
    GROUP BY segment;
    
-- Clean NULL values
/*SELECT 
	company,
    --REPLACE NULL
    COALESCE(company, "B2C") AS clean_company, 
    CASE
    	WHEN company IS NULL THEN "B2C"
        ELSE "B2B"
    END AS segment
FROM customers;*/

-- HAVING VS. WHERE
-- USE GROUP BY > 1 COLUMN
/*SELECT
	CASE
    	WHEN company IS NULL THEN "B2C"
        ELSE "B2B"
    END AS segment,
    country,
    COUNT(*) AS num_customers
FROM customers
WHERE country IN ('Belgium', 'France', 'Italy')
GROUP BY 1,2
HAVING num_customers > 1*/
-- USE HAVING WITH TABLE HAS GROUPED BY OR FILTERED COMPLETE  
-- WHERE clause come first HAVING clause
--HAVING country IN ('Belgium', 'France', 'Italy')

-- ORDER BY
SELECT 
	name, 
    ROUND(milliseconds/ 60000.0, 2) AS minute
FROM tracks
ORDER BY minute DESC
LIMIT 5;

--join syntax
/*SELECT 
	ar.Name AS artists_name,
    al.Title AS albums_name,
    tr.Name AS tracks_name,
    ge.Name AS genres,
    milliseconds,
    bytes,
    unitprice
FROM artists 	  AS ar
INNER JOIN albums AS al
	ON ar.ArtistId = al.ArtistId -- PK = FK
INNER JOIN tracks AS tr
	ON tr.AlbumId = al.AlbumId
INNER JOIN genres AS ge
	ON ge.GenreId = tr.GenreId;*/

--AGGREGATE + JOIN 
SELECT 
	ge.Name,
    COUNT(*) AS count_tracks,
    AVG(milliseconds) AS avg_milliseconds
FROM artists 	  AS ar
        JOIN albums AS al ON ar.ArtistId = al.ArtistId -- PK = FK
        JOIN tracks AS tr ON tr.AlbumId = al.AlbumId
        JOIN genres AS ge ON ge.GenreId = tr.GenreId
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;

--VIRTUAL TABLE => VIEW
CREATE VIEW genre_stats AS
    SELECT 
        ge.Name,
        COUNT(*) AS count_tracks,
        AVG(milliseconds) AS avg_milliseconds
    FROM artists 	  AS ar
            JOIN albums AS al ON ar.ArtistId = al.ArtistId -- PK = FK
            JOIN tracks AS tr ON tr.AlbumId = al.AlbumId
            JOIN genres AS ge ON ge.GenreId = tr.GenreId
    GROUP BY 1
    ORDER BY 3 DESC;
    
/*--SUBQUERIES
SELECT firstname, country
FROM (SELECT * FROM customers) AS sub
WHERE country = 'United Kingdom';

--WITH : COMMON TABLE EXPRESSION
WITH sub AS (SELECT * FROM customers)
SELECT firstname, country
FROM sub
WHERE country = 'United Kingdom';*/

--EXAMPLE SUBQUERIES + WITH CLAUSE
	--QUERY American customers who purchase our products in 2009-10 (invoices)
--basic query
SELECT
	firstname,
    lastname,
    email,
    count(*) count_order
FROM customers c
JOIN invoices i on c.customerid = i.CustomerId
WHERE country = 'USA'and STRFTIME("%Y-%m", i.InvoiceDate) = "2009-10"
GROUP by 1,2,3;

--WITH CLAUSES
WITH usa_customers as (
	SELECT * FROM customers
  	WHERE country = 'USA'
), invoice_2009 AS (
	SELECT * FROM invoices
 	WHERE STRFTIME("%Y-%m", invoicedate) = "2009-10"
)

SELECT firstname, lastname, email, COUNT(*)
FROM usa_customers t1
JOIN invoice_2009  t2
ON t1.Customerid = t2.Customerid
GROUP by 1,2,3;

--standard subqueries
SELECT firstname, lastname, email, COUNT(*)
FROM (
	SELECT * FROM customers
  	WHERE country = 'USA'
) AS t1
JOIN (
	SELECT * FROM invoices
 	WHERE STRFTIME("%Y-%m", invoicedate) = "2009-10"
)  AS t2
ON t1.Customerid = t2.Customerid
GROUP by 1,2,3;
