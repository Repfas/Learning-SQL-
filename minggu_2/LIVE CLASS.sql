-- BAHAS SOAL LIVE CLASS 
SELECT * FROM orderdetails;
SELECT * FROM products;
SELECT * FROM payments;
-- 1. CARILAH JUMLAH STOCK yang ada digudang
SELECT 
	SUM(quantityinstock) AS total_stock
FROM products;
-- 2. carilah jumlah variasi barang kurang dari 5 berdasarkan produk yang dijual
SELECT 
	productline AS jenisminiatur,
	COUNT(productname) AS jumlahvariasiproduct
FROM products 
GROUP BY productline
HAVING COUNT(productname) <5;
-- 3. bandingkan stock barang dengan rata ratanya 
SELECT 
	productname AS namaProduk,
	quantityinstock AS stockBarang,
	AVG(quantityinstock) AS rerataBarang
FROM products
GROUP BY productname,quantityinstock;
-- WINDOWS FUNCTION
-- 1. MENAMPILKAN STOCK DAN RATA RATA BERDASARKAN PRODUCTLINE
-- MUST BE ASK WHY THE PRODUCT SHOULD DIBANDINGKAN BERDASARKAN PRODUCTLINE
SELECT 
	productname AS namaProduk,
	productline,
	quantityinstock AS stockBarang,
	AVG(quantityinstock) OVER(PARTITION BY productline) AS reratastock
FROM products;
-- 2. MELAKUKAN RANK PERBANDINGAN HARGA DAN KUALITAS BARANG
SELECT 
	productcode,
	priceeach,
	quantityordered,
	DENSE_RANK() OVER(ORDER BY priceeach DESC) AS priceRank,
	DENSE_RANK() OVER(ORDER BY quantityordered DESC) AS qtyRank
FROM orderdetails
ORDER BY qtyRank;
-- 2. 
	