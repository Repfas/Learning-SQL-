-- insert data
-- def: memasukkan data ke dalam tabel dan kolom yang sudah dibuat
-- QUERY : INSERT INTO nama_table
-- VALUES(
-- 'a','b','c','d','e','f'
-- )
-- CONTOH
INSERT INTO product_food
VALUES(
1,101,201,'Indomie Fried Noodle','Instant Noodles with special chicken flavor',3500,100,'Instant_Noodles'
);
-- berdasarkan apa yang mau diisi
-- Query:
-- INSERT INTO nama_tabel
-- (nama_kolom yang ingin diisi)
-- VALUES(isi)
-- contoh
INSERT INTO product_food
(name,product_id, description, product_brand_id,price,stock)
VALUES('Almonds 250g', 202,'Roasted Unsalted Almonds','202',30000, 5);
-- khusus serial(ARTIFICIAL PRIMARY KEY) 
-- INSERT INTO nama_table
-- VALUES(DEFAULT(di_serialnya),abc,abcd,...)
-- --------------------------------------------------------
-- MEMASUKKAN BANYAK DATA SEKALIGUS
-- INSERT INTO nama_tabel (masukkan nama kolom*opsional)
-- VALUES
-- (data1,..),
-- (data2,...),
-- ...
-- contoh
INSERT INTO product_food
VALUES 
(3,103,203,'Coca Cola 330 ml','Carbonated cola drink',7500,200,'Beverage'),
(4,104,204,'Chicken Egg 1Kg', 'Fresh Chicken Egg with High Omega3','30000',200,'Dairy Eggs'),
(5,105,205,'Raja Banana', 'Sweet sour banana', 15000,10,'Fruit')
SELECT * FROM product_food
-- MODIFIKASI DATA
-- Ganti data
-- UPDATE table_name
-- SET nama_kolom1 = 'valuebaru1',
-- nama_kolom2 = 'valuebaru2',
-- ...
-- WHERE condition
-- contoh 
UPDATE product_food
SET product_id = 2,
product_category_id = 102,
food_commodity = 'grains'
WHERE product_brand_id = 202;
-- DELETE DATA (bisa menghapus seluruh data)
-- QUERY
-- DELETE FROM nama_table
-- WHERE condition
-- Contoh
DELETE FROM product_food
WHERE product_id =10



