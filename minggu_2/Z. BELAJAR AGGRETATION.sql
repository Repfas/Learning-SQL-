-- FUNGSI AGGRETASI(MEMPERSINGKAT PERHITUNGAN)
SELECT * FROM payments;
-- 1. AVG(Rata rata)
SELECT round(AVG(amount),2) as rata_rata_penjualan FROM payments;
-- 2. Count(menghitung banyaknya data)
-- a. kalau mau menghitung banyaknya data keseluruhan
SELECT count(amount) FROM payments;
-- b.kalau mau menghitung banyaknya data unik
SELECT COUNT(DISTINCT customernumber) FROM payments;
-- 3. SUM
SELECT SUM(amount) AS TotalPenjualan FROM payments;
-- 4. MAX
SELECT MAX(amount) AS penjualanTertinggi From payments;
-- 5. Min 
SELECT MIN (amount) AS penjualanTerendah FROM payments;
-- STDDEV (standar deviasi)
SELECT STDDEV(amount) AS standarDeviasi FROM payments;
-- Var
SELECT VARIANCE(amount) AS variance FROM payments;
SELECT (VARIANCE(amount)^0.5) AS standarDeviasi FROM payments; 

-- SEMUA AGRETASI AKAN MENGABAIKAN NILAI NULL KECUALI COUNT(*)

