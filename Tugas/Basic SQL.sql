-- ======================== Data Definition Languange (DDL) =======================

--  =====================  DATABASE  =============================
--  Buat Database
CREATE DATABASE ...

-- Menggunakan database 
USE DATABASE ...

-- Menghapus database
DROP DATABASE .. 

-- ======================  TABLE  ==============================

-- Membuat Table 
CREATE TABLE (table_name)(
    ... ... ..., //PRIMARY KEY
    ... ... ...,
    ... ... ...
    PRIMARY KEY (id...)
    FOREIGN KEY(...) REFERENCES ...(id...)
);

-- Menghapus Table
DROP TABLE (table_name)

-- Mengganti Nama Table 
ALTER TABLE (table_name) RENAME TO ...

-- Menambahkan Kolom Baru di Table 
ALTER TABLE (table_name) ADD ...;

-- Mengganti Tipe Data Kolom Baru di Table 
ALTER TABLE (table_name) ADD COLUMN ... TYPE ...;

-- Mengganti Nama Kolom Baru di Table 
ALTER TABLE (table_name) RENAME COLUMN ... TO ...;

-- Menghapus Kolom di Table
ALTER TABLE (table_name) DROP COLUMN ...;

-- Mencopy semua data pada table baru
CREATE TABLE (table_name) AS SELECT * FROM (previous_table)

-- Mencopy tabel tertentu pada tabel baru
CREATE TABLE (table_name) AS SELECT NAME,AGE FROM (previous_table)

-- ==================== Data ======================
 
--  Menambahkan data pada database
INSERT INTO ... VALUES
(... , '' , ... , '' , ... ),
(... , '' , ... , '' , ... )

-- Mengupdate data / merubah isian data
UPDATE (name_table) SET (name_column) = (new_data_input) WHERE (specific_name_column) = (specific_data_value)

-- Menghapus semua isian data pada table
DELETE FROM (name_table)

-- Example


-- ===============================  DDL ============================
-- Membuat Database 
CREATE DATABASE Customer

-- Menggunakan Database
USE DATABASE Customer

-- Membuat table kolom Database
CREATE TABLE Customer(
	ID INTEGER PRIMARY KEY NOT NULL,
	NAME VARCHAR(50)NOT NULL,
	AGE INTEGER NOT NULL,
	ADDRESS VARCHAR(100) NOT NULL,
	SALARY DECIMAL(6,2) NOT NULL
    -- Atau boleh dikasih disini
    -- PRIMARY KEY (ID),
    FOREIGN KEY(ID) REFERENCES Customer2(ID2)
);

-- Membuat table kolom Database menggunakan id SERIAL
CREATE TABLE StudentRecord (
    RegID SERIAL PRIMARY KEY,
    Name 	varchar(100) NOT NULL,
    Age 		varchar(3),
    Gender 		varchar(10),
    City 		varchar(100)
);

-- Menghapus Table Customer (Semuanya)
DROP DATABASE Customer

-- Menghapus Hanya Isi Data tertentu
DELETE FROM Customer WHERE id = 1

-- Menghapus Isi data dalam Database tetapi hanya menyisakan kolomnya
TRUNCATE Customer

-- Mengganti Nama Table Customer
ALTER TABLE Customer RENAME TO Customer2

-- Melihat Semua Data Pada Database 
SELECT * FROM Customer

-- Mencopy semua data pada table baru
CREATE TABLE COPY2 AS SELECT * FROM CUSTOMER

-- Mencopy tabel tertentu pada tabel baru
CREATE TABLE COPY3 AS SELECT NAME,AGE FROM CUSTOMER

-- Menambahkan Kolom Email ke Customer
ALTER TABLE Customer ADD Email VARCHAR(50);

-- Mengganti tipe data kolom Email menjadi Varchar(300)
ALTER TABLE Customer ALTER COLUMN Email Type VARCHAR(300);
alter table customer alter column address type varchar(300);

-- Mengganti nama kolom Email menjadi Email_ID
ALTER TABLE Customer RENAME COLUMN Email TO Email_ID;

-- Menghapus kolom Email 
ALTER TABLE Customer DROP COLUMN Email_ID;


-- ======================= DML ================================
-- Bila ingin 
-- Menambahkan data
INSERT INTO Customer VALUES
(1,'Ramesh',32, 'Ahmedabad',2000.00),
(2,'Khilan',25,'Delhi',1500.00),
(3,'Kaushik',23,'Kota',2000.00),
(4,'Chaitali',25,'Mumbai',6500.00),
(5,'Hardik',27,'Bhopal',8500.00),
(6,'Komal',22,'MP',4500.00)

-- Menambahkan angka secara otomatis menggunakan SERIAL
INSERT INTO StudentRecord (Name, Age, Gender , City) VALUES
('George','20', 'Male', 'London'),
('Emma','22', 'Female', 'Manchester'),
('Harry','15', 'Male', 'Cambridge'),
('Ava','17', 'Female', 'Manchester'),
('Olivia','25', 'Female', 'Manchester'),
('Thomas','23', 'Male', 'Cambridge');

-- Menghapus semua nilai / beberapa nilai data table
DELETE FROM Customer 
DELETE FROM Costumer where ...

-- Menambah / Mengganti nilai data menjadi baru 
-- Tambah
UPDATE Customer SET email = 'Ramesh@gmail.com' WHERE name = 'Ramesh' 
-- Ganti 
UPDATE Customer SET AGE = 40 WHERE name = 'Ramesh'


-- ======================  TAMBAHAN QUERY BARU =============================
-- MEMISAHAN TANGGAL LAHIR MENJADI 3 KOLOM BARU
SELECT sid,
	   bid,
	   to_char(DAY,'DD/MM/YYYY'),
	   SPLIT_PART('10/01/2020', '/', 1) AS tanggal,
       SPLIT_PART('10/01/2020', '/', 2) AS bulan,
       SPLIT_PART('10/01/2020', '/', 3) AS tahun
FROM RESERVES




--  ============================= > CASE WHEN < ===========================
-- Postgresql
SELECT sname,age,
CASE 
	WHEN AGE >= 30 THEN 'Old'
	WHEN AGE >= 20 THEN 'Adult'
	ELSE 'Young'
	END AS age //untuk menamai tabel baru
FROM Sailors
WHERE AGE IS NOT NULL;

--  ============================== > IF ELSE < =============================
-- Database Exercise
DO $$
DECLARE 
	all_info Sailors%rowtype;
	id_sailor Sailors.sid%type := 22;
BEGIN 
	
	SELECT * 
	INTO all_info
	FROM Sailors
	WHERE sid = id_sailor;
	
	RAISE NOTICE 'Id % ditemukan',id_sailor;
	
	IF NOT FOUND THEN
	RAISE NOTICE 'Id % tidak ditemukan',id_sailor;
	ELSE 
	RAISE NOTICE 'Idnya adalah %', all_info.sname;
	END IF;
END$$

-- ============================== > FOR LOOP < ================================
-- Simple For Loop
DO $$
BEGIN 
	FOR i in 1..10 LOOP 
	RAISE NOTICE '%',i;
	END LOOP;
END; $$

-- Simple For loop 2
DO $$
BEGIN 
	FOR i in reverse 10..1 LOOP 
	RAISE NOTICE '%',i;
	END LOOP;
END; $$

-- Simple For Loop 3
DO $$
BEGIN 
	FOR i in reverse 10..1 by 2 LOOP 
	RAISE NOTICE '%',i;
	END LOOP;
END; $$

-- Simple For Loop 4
DO $$
DECLARE
  i INTEGER := 0;
  j INTEGER := 20;
  k INTEGER := 0;
BEGIN
  FOR i IN 0..20 LOOP
    IF i % 2 = 0 THEN
	RAISE NOTICE 'i : %', i;
      k := k + 1;
    END IF;
  END LOOP;
  RAISE NOTICE 'i : % || j : % || k : %', i,j,k;
END $$;

-- Simple For Loop 5
DO $$
DECLARE 
	i int = 0;
	j int = 0;
BEGIN 
	<<outer_loop>>
	LOOP
		i = i + 1;
		exit when i > 3;	
		-- INNER LOOP	
		j = 0;
		<<inner_loop>>
		LOOP
			j = j+1;
			EXIT outer_loop WHEN j > 3;
			RAISE NOTICE 'i : % || j : %',i,j;
		END LOOP inner_loop;
	END LOOP outer_loop;
END $$;

-- For Loop with data
DO $$
DECLARE
i RECORD;
BEGIN 
	FOR i in SELECT sid,sname
	FROM Sailors
	ORDER BY sid
	LIMIT 3

	LOOP RAISE NOTICE 'sid : % || sname : %',i.sid,i.sname;
	END LOOP;
END; $$

-- For Loop with data 2






-- =================================== VIEW =================================
-- VIEW berguna agar menjaga data tetap rahasia meskipun diakses oleh client atau customer. Jadi intinya
-- seperti membatasi agar orang lain tidak dapat mengakses data penting dalam database
-- 

-- Membuat table view 
CREATE OR REPLACE VIEW high_salary_customers2 AS
	SELECT name, salary, age
    FROM customers
    WHERE salary > 2000.00;
;


-- Mengganti nama table view 
ALTER VIEW high_salary_customers2 RENAME TO testing

-- Menghapus table view
DROP VIEW testing


-- Memanggil view 
SELECT * FROM public.testing atau
SELECT * FROM testing
 

--  =============> CREATE AND REPLACE <========
-- Create or replase berfungsi agar apabila datanya belum ada maka akan dibut, 
-- apabila sudah ada, maka akan direplae
-- (PENTING) apabila menggunakan create or replace, maka data yang tersimpan tidak bisa diubah
-- 1.) nama kolom (penambahan as pun juga tidak boleh)
-- 2.) tipe data kolom
-- 3.) perhatikan juga bahwa bisa menambahkan data hanya pada belakang, apabila ditengah" data tidak bisa
--     contoh menambahkan age diantara id,nama,(age),email ini tidak bisa. Solusinya id,nama,email,age
-- 4.) Penggunaan Create or Replace hanya memberikan informasi tentang data terakhir pada database asli

-- ==============> ALTER <===============
-- Mengganti nama kolom pada view (tidak mengubah tabel asli dalam database)
ALTER VIEW testing RENAME COLUMN age TO umur

-- Perlu diingat apabila menambahkan kolom baru pada database asli, kolom di view tidak akan bertambah
-- Apabila ingin menambahkan kolom baru yang telah dibuat, maka harus di create or replace view lagi


-- ===============> Update <================  (NOT RECOMMENDED)
-- 1.) View hanya dibuat hanya 1 tabel / 1 view
-- 2.) Tidak bisa memakai distinct bila diupdate datanya
-- 3.) Tidak bisa memakai group by bila diupdate datanya
-- 4.) Tidak bisa mengupdate data bila memiliki lebih dari satu table


-- ===============> ADD <===========================
-- Menambahkan data baru  (tetapi ini juga menambhakan data pada database utama)
INSERT INTO testing02 VALUES
(5,'Hardik',27,'Bhopal',8500.00)

CREATE OR REPLACE                           

-- Mengupdate data lama dengan yang baru (tetapi ini juga akan menghapus data di database utama)
UPDATE testing02
SET name = 'Kamal' , age = '30'
WHERE id = '6'


-- ============================== CHECK OPTION <===========================

-- Ini berguna untuk menghindarkan pengaksesan database pada client guna menjaga keaslian data
-- Contoh membuat view yang berasal dari Delhi
CREATE OR REPLACE VIEW testing03
AS 
SELECT * FROM Customers WHERE ADDRESS = 'Delhi'

-- Ini akan bisa menambahkan data yang BUKAN dari Delhi
INSERT INTO testing03
VALUES (9,'Naruni',29,'Bhopal',5500.00)
--  ini berbahaya dan tidak diperbolehkan, lebih baik gunakan ini 

CREATE OR REPLACE VIEW testing03
AS 
SELECT * FROM Customers WHERE ADDRESS = 'Delhi'
with check option;




--  ==================> USER PERMISSION <========================
CREATE role james
login
password 'james'
grant select on testing01
-- Membuat role abru pada user yang diberi access granted
-- Jangan lupa ganti connection

-- ==================== > FUNCTION < ==========================
-- Databse Exercise (Mencari jumlah sid menggunakan function dengan parameter id input 20 sampai 40)
-- IN
CREATE OR REPLACE FUNCTION get_sailor_info(
	IN start_number INTEGER,
	IN finish_number INTEGER		
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
	sailor_info INTEGER;
BEGIN 
	SELECT count(sid)
	INTO sailor_info
	FROM SAILORS
	WHERE sid BETWEEN start_number AND finish_number;
	RETURN sailor_info;
END $$

SELECT * FROM get_sailor_info(20,40)

-- OUT
CREATE OR REPLACE FUNCTION info_age(
	OUT min_age INTEGER,
	OUT max_age INTEGER,
	OUT avg_age INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT min(age),max(age),avg(age)
	INTO min_age,max_age,avg_age
	FROM Sailors;
END$$

SELECT * FROM info_age();
	
-- INOUT
CREATE OR REPLACE FUNCTION info_age2(
	IN age_start INTEGER,
	IN age_end INTEGER,
	OUT min_age INTEGER,
	OUT max_age INTEGER,
	OUT avg_age INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT min(age),max(age),avg(age)
	INTO min_age,max_age,avg_age
	FROM Sailors
	WHERE age >= age_start AND age <= age_end;
END $$;

SELECT * FROM info_age2(20, 40);

-- RETURN TABLE
CREATE OR REPLACE FUNCTION get_sailor_info2(
  p_name varchar,
  p_rating integer
)
RETURNS TABLE(
  sailor_name varchar,
  sailor_rating integer
)
LANGUAGE plpgsql
AS $$
DECLARE 
  var_r record;
BEGIN
  FOR var_r IN (
    SELECT sname, rating
    FROM sailors
    WHERE sname ILIKE p_name AND rating = p_rating
  )
  LOOP 
    sailor_name := UPPER(var_r.sname);
    sailor_rating := var_r.rating;
    RETURN NEXT;
  END LOOP;
END;
$$;

-- Membuat tabel
SELECT * FROM get_sailor_info2('%a%', 7);
-- Membuat list (horizontal)
SELECT get_sailor_info2('%a%', 7);



-- ======================== > TRIGGER <= ==================================
-- table customer
CREATE TABLE customer (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  address VARCHAR(300) NOT NULL
);

INSERT INTO customer (first_name, last_name, address) VALUES
  ('John', 'Doe', '123 Main St'),
  ('Jane', 'Smith', '456 Second Ave'),
  ('Bob', 'Johnson', '789 Third Blvd');
  
SELECT * FROM customer
DROP TABLE customer

alter table customer alter column address type varchar(300);

-- ============================================================
-- log table customer

CREATE TABLE customer_log (
  id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  old_address VARCHAR(200) NOT NULL,
  new_address VARCHAR(200) NOT NULL,
  time_change TIMESTAMP DEFAULT NOW() NOT NULL
);

SELECT * FROM customer_log
DROP TABLE customer_log

-- create function 

CREATE OR REPLACE FUNCTION user_change_address()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS $$
BEGIN 
	IF OLD.address != NEW.address THEN
		UPDATE customer SET address = NEW.address WHERE id = NEW.id;
		INSERT INTO customer_log (customer_id, old_address, new_address) VALUES 
		(NEW.id, OLD.address, NEW.address);
  	END IF;
  	RETURN NEW;
END $$;

-- create trigger 

CREATE TRIGGER address_change
AFTER UPDATE ON customer
FOR EACH ROW
EXECUTE FUNCTION user_change_address();

-- updating
UPDATE customer SET address = '456 Fourth St' WHERE id = 1;
SELECT * FROM customer
SELECT * FROM customer_log

-- DROP
DROP TRIGGER address_change ON Customer 
DROP FUNCTION user_change_address()











-- =================== PROCEDUR ============================

-- Ini adalah langkah mudah agar menghemat langkat dan memori pada SQL


-- CREATE

CREATE OR REPLACE PROCEDUR pr_name()
language plpgsql
AS $$
DECLARE 

BEGIN 
    SELECT * FROM Costumer
END;
$$


EXEC get_costumer

-- CREATE PADA MYSQL SERVER
DELIMITER $$
CREATE OR REPLACE PROCEDUR pr_name (@p_name1 varchar, @p_age int)
AS
DECLARE 
    var_name varchar;
BEGIN 
    SELECT * FROM Costumer
END $$


-- CREATE PADA MICROSOFT SQL DATABASE
CREATE OR ALTER PROCEDURE pr_name (@p_name1 varchar, @p_age int)
AS
    DECLARE @v_name int,
            @v_age int;
BEGIN
    PROCEDURE 
END;


-- ================== >  PROCEDURE  <=======================

-- 1) =======  > PROCEDURE WITHOUT PARAMETER  < =========
CREATE OR REPLACE PROCEDURE pr_product()
language plpgsql
AS $$
DECLARE 
	V_order_id INTEGER;
	v_product_code VARCHAR(20);
	v_price FLOAT;
BEGIN
	SELECT product_code, price
	into v_product_code, v_price 
	FROM product
	WHERE product_name = 'Iphone 13 Pro Max';
	
	INSERT INTO SALES (order_id,order_date,product_code,quantity_ordered,sale_price)
	VALUES (4, current_date, v_product_code, 1, (v_price * 1));
	
	UPDATE PRODUCT
	SET quantity_remaining = (quantity_remaining - 1),
		quantity_sold = (quantity_sold + 1)
	WHERE product_code = v_product_code;
	
	RAISE NOTICE 'Product Sold!';
	
END;
$$
-- Tambahan


-- 2)



-- 5) =============== > Memanggil Proccedure < ================

CALL pr_product();
-- Bila menuliskan nama i'm 
--  bisa dengan select E'I\'m atau 'I''M 
-- $$ berfungsi agar tidak menuliskan manual berkali-kali sehingga bisa ditulis $$I'M$$


DROP PROCEDURE pr_product();

CREATE TABLE Product(
	Product_code Varchar(5),
	Product_name Varchar(50) NOT NULL,
	PRICE INTEGER NOT NULL,
	QUANTITY_REMAINING INTEGER NOT NULL,
	QUANTITY_SOLD INTEGER NOT NULL,
	PRIMARY KEY (Product_code)
)



CREATE TABLE SALES(
	order_id INTEGER,
	order_date DATE NOT NULL,
	Product_code VARCHAR(5) NOT NULL,
	quantity_ordered INTEGER NOT NULL,
	sale_price INTEGER NOT NULL
)

INSERT INTO Product VALUES
('P1','IPhone 13 Pro Max', 1000, 5 , 195);

INSERT INTO SALES VALUES
(1,'2022-01-10','P1',100,120000),
(2,'2022-01-20','P1',50,60000),
(3,'2022-02-05','P1',45,540000);



IF OLD.salary != NEW.salary THEN
		IF NEW.salary > 8500.00 THEN
			SET NEW.salary = 8500.00;
			INSERT INTO customers_log (Date_Change,Previous_Salary,Next_Salary)
			VALUES (NOW(),OLD.salary,NEW.salary);

		ELSIF NEW.salary < 1500.00 THEN
			SET NEW.salary = 1500.00;
			INSERT INTO customers_log (Date_Change,Previous_Salary,Next_Salary)
			VALUES (NOW(),OLD.salary,NEW.salary);	
		END IF;
	END IF;