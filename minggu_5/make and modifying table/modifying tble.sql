-- Modifikasi tabel
-- A. menambahkan tabel
-- ALTER TABLE nama_table 
-- ADD COLUMN nama_kolom tipe_data  
-- contoh
ALTER TABLE product_food
ADD COLUMN commodity VARCHAR(20);
-- B. menghapus kolom
-- ALTER TABLE nama_table
-- DROP COLUMN nama_kolom;
-- contoh:
ALTER TABLE product_food
DROP COLUMN commodity;
-- C. merubah nama kolom
-- ALTER TABLE nama_table
-- RENAME COLUMN nama_kolom TO nama_baru
ALTER TABLE product_food
RENAME COLUMN commodity TO food_commodity;
-- D. merubah tipe data
-- ALTER TABLE nama_table
-- ALTER COLUMN nama_kolom  TYPE tipe baru
ALTER TABLE product_food
ALTER COLUMN food_commodity TYPE text;
-- E. Menambahkan/menghapus constrain
-- ALTER TABLE nama_table
-- ADD CONSTRAINT nama_constraint constrain
-- DROP CONSTRAINT nama_kolom_constrain
-- contoh add:
ALTER TABLE product_food
ADD CONSTRAINT unique_food_commodity UNIQUE(food_commodity);
ALTER TABLE product_food
DROP CONSTRAINT unique_food_commodity;
-- F. RENAME TABLE
-- ALTER TABLE nama_table
-- RENAME TO new_table_name
-- contoh:
ALTER TABLE food_product
RENAME TO product_food
-- G DROP TABLE nama_table CASCADE
-- cascade akan menghapus tabel yang sedang berelasi dengan tabel lain sehingga menghilangkan status foreign key dari tabel lain yang berelasi

