SELECT * FROM employee;
-- SELECT adalah syntax yang digunakan untuk memilih tabel mana yang diambil
-- * digunakan untuk memilih kolom yang akan diakses. dapat digantikan dengan nama kolom yang ada
-- **employees itu nama tabelnya FROM adalah syntax untuk mengakses tabel tersebut
-- ; digunakan untuk jeda
SELECT 
	first_name, salary 
FROM 
	employee;

-- untuk merekayasa data:
-- 1. 
SELECT
	first_name, salary, salary * 2 AS bonus_tahunan
FROM 
	employee;
-- AS digunakan untuk mengganti judul kolom
-- 2.
SELECT 
	*
FROM
	employee
LIMIT 
	7;
-- LIMIT DIGUNAKAN UNTUK MEMBATASI DATA YANG AKAN DITAMPILKAN 
-- 3.
SELECT
DISTINCT 
	sex
FROM
	employee;
-- DISTINCT digunakan untuk mencari data tanpa ada duplikat
-- 4.
SELECT
	first_name, salary, birth_day
FROM 
	employee
ORDER BY
	birth_day DESC;
SELECT 
	first_name,birth_day, salary
FROM 
	employee
ORDER BY
	salary ASC;
-- ORDER BY adalah urutan. ASC urutan dari kecil ke besar dan DESC sebaliknya dari besar ke kecil
-- FILTERING DATA 
-- 1. Filter data berdasarkan operator perbandingan (<=, <, >= , =,!=)
SELECT
	first_name,birth_day, salary 
FROM 
	employee
WHERE birth_day >= '1970-01-01' AND sex = 'M';
-- hanya bisa menggunakan tanda petik 1 untuk string 
-- 2. Mengecek keanggotaan(IN)
SELECT 
	first_name,birth_day,salary
FROM 
	employee
WHERE sex IN ('M') ;
SELECT 
	first_name,birth_day, salary
FROM 
	employee
WHERE 
	super_id IN (102,106)
ORDER BY last_name ASC;
-- 3. Mencari sesuatu yang berhubungan misalkan mau cari huruf depan J
-- gunakan LIKE (%XXX% UNTUK TIDAK TAHU LOKASINYA, % MENANDAKAN AWAL/ AKHIR, _ MENANDAKAN POSISI KE)
SELECT
	first_name,birth_day, salary, branch_id
FROM 
	employee
WHERE last_name LIKE 'K%'
ORDER BY salary DESC ;
-- 4. mencari data diantara menggunakan BETWEEN ... AND ...
SELECT
	first_name,salary
FROM 
	employee
WHERE salary BETWEEN 40000 AND 100000
ORDER BY last_name DESC;