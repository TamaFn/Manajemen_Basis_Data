

-- Soal 1

-- Buatlah user admin_toko 
CREATE USER admin_toko WITH PASSWORD 'admin_toko'

-- Buatlah user admin_album
CREATE USER admin_album WITH PASSWORD 'admin_album'

-- Cara cek semua User
SELECT usename FROM pg_user;


-- Soal 2

-- Buatlah GRANT pada user admin_toko
CREATE ROLE admin_toko;
GRANT SELECT, INSERT, UPDATE ON TABLE Receipt TO admin_toko;
GRANT SELECT, INSERT, UPDATE ON TABLE DetailItem TO admin_toko;
GRANT SELECT ON TABLE Singer TO admin_toko;
GRANT SELECT ON TABLE Album TO admin_toko;

-- Buatlah GRANT pada user admin_album
CREATE ROLE admin_album;
GRANT SELECT, INSERT, UPDATE ON TABLE Singer TO admin_album;
GRANT SELECT, INSERT, UPDATE ON TABLE Album TO admin_album;


-- LAIN-LAIN
SELECT usename FROM pg_user;


SELECT rolname FROM pg_roles

SELECT rolname FROM pg_authid WHERE rolname = 'admin_toko'

SELECT rolname FROM pg_catalog.pg_roles WHERE rolname = 'admin_toko'






