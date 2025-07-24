SELECT * FROM customers;
SELECT * FROM payments;
-- JOIN DATA 
-- A. INNER JOIN --> MENGGABUNGKAN DATA YANG KEYNYA MUNCUL PADA KEDUA TABEL YG AKAN DIGABUNGKAN
-- CONTOH
SELECT *
FROM customers
INNER JOIN payments
ON customers.customernumber = payments.customernumber;
-- B. LEFT JOIN --> MENGGABUNGKAN KEDUA KEY YANG MUNCUL BESERTA DATA SEBELAH KIRI PENGGABUNGAN 
-- LOGIC --> A OR (A AND B)
-- contoh
SELECT * 
FROM customers
LEFT JOIN payments
ON customers.customernumber = payments.customernumber;
-- C. RIGHT JOIN --> MENGGABUNGKAN KEDUA KEY YANG MUNCUL BESERTA DATA SEBELAH KANAN
SELECT * 
FROM customers 
RIGHT JOIN payments
ON customers.customernumber = payments.customernumber;
