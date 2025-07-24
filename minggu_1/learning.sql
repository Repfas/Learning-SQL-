/* mari kita belajar SQL dari sangat dasar
1. select --> mengambildata 
syntaxnya = SELECT * from nama_tabel;
*/
SELECT * from employee;
--MENGAMBIL DATA:
--syntax = SELECT nama_kolom1,nama_kolom2 from nama_tabel;
SELECT birth_day,first_name,sex,salary from employee;
-- MANIPULASI DATA:
-- just operate the data (add 'as' for change the title )
SELECT first_name,salary,salary*0.01 as tax_per_year from employee;
SELECT 
	emp_id,
	first_name,
	salary,
	ROUND(salary*2.5/100 ,2) AS bonus_tahunan,
	ROUND((salary + 2.5/100* salary)*1/100,2) AS tax FROM employee;
-- membatasi data (misal mau 5 baris) gunakan LIMIT
SELECT first_name,birth_day,salary FROM employee ORDER BY salary LIMIT 5;
SELECT 
	emp_id,
	sex,
	salary 
FROM employee 
ORDER BY emp_id 
DESC LIMIT 6;
-- cara mengakses data unik. Menggunakan DISTINCT
SELECT DISTINCT branch_id FROM employee
-- cara mencari sesuatu(beracuan nilai) gunakan WHERE
-- sebagai acuan dan dapat menggunakan logic math
SELECT 
	* 
FROM employee 
WHERE 
	birth_day > '1970-01-01' 
	AND sex = 'F';
SELECT 
	emp_id, 
	first_name, 
	last_name, 
	salary 
FROM employee 
WHERE 
	sex ='F'
	AND salary <= 75000 
	AND salary >= 50000 ;
-- MENCARI DENGAN OPERATOR IN SEBAGAI PENGGANTI OR:
SELECT 
	emp_id,
	first_name,
	super_id, 
	salary
FROM employee
WHERE 
	super_id IN (100,102,106);
-- MENCARI DATA DENGAN HURUF DEPAN TERTENTU. MENGGUNAKAN LIKE 'huruf%'
-- tanda persen(%) menandakan pencarian di bagian mana huruf tersebut
-- %A mencari A di akhir sedangkan  A% di awal sedangkan %A% merupakan yang ada huruf Anya
SELECT 
	first_name,
	last_name,
	sex,
	salary
FROM employee
WHERE first_name LIKE 'A%' 
OR last_name LIKE 'W%';
-- MENCARI DATA DIANTARA(0<X<100) MENGGUNAKAN BETWEEN

SELECT
	last_name,
	sex,
	salary
FROM employee
WHERE salary 
BETWEEN 75000 AND 110000;