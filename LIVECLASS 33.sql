-- 1.1 
SELECT * FROM products ORDER by productcode;
SELECT * FROM orderdetails;
SELECT *
FROM products
LEFT JOIN orderdetails 
	ON products.productcode = orderdetails.productcode
WHERE orderdetails.ordernumber IS NULL
ORDER BY products.productcode;
-- 1.2
WITH sold_20_percent AS
	(SELECT 
		products.productname,
		products.quantityinstock,
		SUM(orderdetails.quantityordered) AS n_item_sold,
		products.quantityinstock + SUM(orderdetails.quantityordered) AS total_stock
	FROM products
	JOIN orderdetails
		ON products.productcode = orderdetails.productcode
	GROUP BY products.productname, products.quantityinstock)
SELECT 
	productname, 
	quantityinstock, 
	n_item_sold, total_stock, 
	CAST(n_item_sold AS FLOAT)/(CAST(total_stock AS FLOAT))*100 AS percent_items_sold
FROM sold_20_percent 
WHERE CAST(n_item_sold AS FLOAT)/(CAST(total_stock AS FLOAT))*100 <20 
ORDER BY percent_items_sold ASC
;
-- 1.3 
WITH minimum_price AS 
	(SELECT
		products.productname,
		products.msrp,
		orderdetails.priceeach,
		0.8*msrp AS min_price,
		(orderdetails.priceeach/(msrp))*100 AS percent_price_each
	FROM products
	JOIN orderdetails
		ON products.productcode = orderdetails.productcode)
SELECT 
	productname, msrp,priceeach, min_price,percent_price_each
FROM minimum_price
WHERE percent_price_each <80;

-- 1.4
WITH product_rev AS
	(SELECT 
		productcode,
		SUM(quantityordered * priceeach) AS total_sales_product
	FROM orderdetails
	GROUP BY productcode
	ORDER BY total_sales_product),
	productline_revenue AS 
	(SELECT 
		products.productline,
		SUM(total_sales_product) AS revenue_productline
	FROM products
	JOIN product_rev 
		ON products.productcode = product_rev.productcode
	GROUP BY products.productline)
SELECT productline, revenue_productline
FROM productline_revenue
WHERE revenue_productline > (SELECT AVG( revenue_productline) FROM productline_revenue);
-- 2.1
SELECT 
	customers.customername,
	AVG(payments.amount) AS avg_payments
FROM customers
JOIN payments
	ON customers.customernumber = payments.customernumber
GROUP BY 1 
ORDER BY avg_payments DESC;
-- 2.2
SELECT 
	customers.customername, 
	products.productname,
	SUM(orderdetails.quantityordered) AS jumlah_produck
FROM customers 
JOIN orders
	ON customers.customernumber = orders.customernumber
JOIN orderdetails
	ON orders.ordernumber = orderdetails.ordernumber
JOIN products
	ON orderdetails.productcode = products.productcode
GROUP BY 1,2;
-- 2.3
CREATE TEMPORARY TABLE total_payment_cust AS 
	(SELECT 
		customers.customernumber,
		customers.customername,
		customers.country,
		SUM(payments.amount) AS total_payments 
	FROM customers
	JOIN payments
		ON payments.customernumber = customers.customernumber
	GROUP BY 1,2,3
	);
SELECT * FROM total_payment_cust
WHERE LOWER(country) IN ('new zealand','australia','singapore','japan','hong kong','philippines');
	

		
