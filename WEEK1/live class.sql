SELECT * FROM products;
-- case 1.1 
SELECT DISTINCT productline FROM products;
-- case 1.2
SELECT productname,productline,buyprice FROM products ORDER BY buyprice ASC LIMIT 5;
-- case 1.3
SELECT 
	productname,
	productline,
	quantityinstock,
	buyprice,
	msrp - 0.1*msrp AS saleprice,
	msrp,
	quantityinstock * (msrp - 0.1*msrp) AS totalsales
FROM products ;
-- case 1.4 
SELECT 
	productname,
	quantityinstock,
	msrp - 0.1*msrp AS saleprice,
	((msrp - 0.1*msrp)* quantityinstock - 	buyprice* quantityinstock)  AS profit
FROM 
	products
ORDER BY profit DESC
LIMIT 10;
-- case 2
SELECT  * FROM customers;
-- case 2.1 
SELECT customername FROM customers WHERE customername LIKE '%Inc%' ;
-- case 2.2
SELECT
	customername,
	contactlastname,
	phone,
	city,
	country
FROM 
	customers
WHERE 
	lower(city) IN ('nyc','brickhaven','san francisco') OR
	lower(country) IN ('japan');
-- case 2.3
SELECT 
	customername,
	contactlastname,
	phone,
	country,
	creditlimit
FROM 
	customers
WHERE 
	country IN ('USA') AND
	creditlimit != 0;
-- case 2.4 
SELECT *
FROM 
	payments
ORDER BY amount DESC 
LIMIT 10;