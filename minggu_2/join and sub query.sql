SELECT * FROM Payments;
-- SUB QUERY --> MENCARI QUERY DALAM QUERY 
-- contoh(di dalam WHERE):
-- kalau di dalam WHERE, kondisi yang di WHERE dengan SELECT harus berrelasi
SELECT 
	customernumber,
	paymentdate,
	amount
FROM payments
WHERE amount > (SELECT STDDEV(amount) AS standar_deviasi 
				FROM payments)
ORDER BY amount DESC;
-- CONTOH DIDALAM SELECT (BISA MENCARI AGGREGAT TANPA GROUP BY DAN OVER)
SELECT 
	customernumber,
	amount,
	(SELECT AVG(amount) FROM payments)
FROM payments;
SELECT 
	customernumber,
	AVG(amount) AS RATA_RATA
FROM payments
GROUP BY customernumber
ORDER BY customernumber;
-- SUB QUERY DALAM FROM(TABEL SEMENTARA UNTUK MENGOLAH DATA SELANJUTNYA)
-- misal
SELECT 
	customernumber,
	paymentdate,
	amount
FROM (SELECT 
		customernumber,
		paymentdate,
		amount
	FROM payments
	WHERE amount > (SELECT STDDEV(amount) AS standar_deviasi 
					FROM payments)) AS tabel_transaksi
ORDER BY amount DESC
LIMIT 1 ;
-- membaca sub query dari FROM itu susah. jadi GUNAKANLAH CTE(COMMON TABLE EXPRESSION)
-- RUMUS:
-- WITH (NAMA TABEL) AS (
-- SELECT ... FROM ...(SESUAIKAN KONDISI)
-- )
-- SELECT ... FROM (NAMA TABEL) DAN LAKUKAN LOGIKA QUERY LAINNYA