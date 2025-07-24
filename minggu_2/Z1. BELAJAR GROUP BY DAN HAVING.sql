-- GROUPING --> MELAKUKAN AGGRETASI BERDASARKAN KATEGORI/DATA UNIK.
SELECT * FROM payments;
SELECT * FROM products;
-- SYNTAX --> SELECT AGGR(DATA) AS ... FROM ... GROUP BY KATEGORI
SELECT 
	customernumber,
	SUM(amount) AS Total_Pembayaran 
FROM payments
GROUP BY customernumber
ORDER BY customernumber;
-- UNTUK GROUPING 2 KATEGORI
SELECT 
	productline,
	productscale,
	SUM(buyprice)
FROM 
	products
GROUP BY 
	productline,
	productscale
ORDER BY productline,productscale ASC;
-- grouping HAVING --> UNTUK MENGETAHUI JUMLAH YANG DIINGINKAN 
-- perbedaan WHERE dan having adalah having digunakan untuk aggretasi sedangkan where tidak bisa digunakan aggretasi
SELECT
	productline,
	productscale,
	SUM(buyprice)
FROM products
GROUP BY 
	productline,
	productscale
HAVING 
	SUM(buyprice) > 100
ORDER BY
	productline, productscale ASC;
-- Window Function
-- bisa melakukan perhitungan keseluruhan tanpa terkategorikan
SELECT 
	customernumber,
	amount,
	ROUND(AVG(amount) OVER(),2) AS average_amount
FROM payments
ORDER BY customernumber;
-- partition by --> digunakan untuk menampilkan perkelompok
SELECT
	customernumber,
	ROUND(AVG(amount) OVER(PARTITION BY customernumber),2) AS average_amount_cust,
	ROUND(AVG(amount) OVER(),2) AS average_amount
FROM payments
ORDER BY customernumber;
-- membedakan group by dan parititon
SELECT
	customernumber,
	AVG(amount) AS average_amount_cust
FROM payments
GROUP BY customernumber
ORDER BY customernumber;
SELECT
	customernumber
	amount,
	AVG(amount) OVER(PARTITION BY customernumber ) AS average_amount_cust
FROM payments
ORDER BY amount DESC ;
-- FRAME CLAUSE (jika dilakukan pengurutan ORDER BY terdapat aturan FLAME terhadap batas batasnya)
SELECT
	customernumber
	amount,
	AVG(amount) OVER(PARTITION BY customernumber ORDER BY amount DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS average_amount_cust
FROM payments