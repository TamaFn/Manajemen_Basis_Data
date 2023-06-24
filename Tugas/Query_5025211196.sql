-- Query Database

-- Sandyatama Fransisna Nugraha - 5025211196


-- Query Join 

-- Tampilkan ID pengelola, nama pengelola, nama fasilitas olahraga, beserta harga sewanya dimana harga sewa fasilitas olahraganya di bawah rata-rata!

SELECT P.id_pegawai, P.nama_pegawai, FO.nama_fasilitas_olahraga, FO.harga_sewa
FROM fasilitas_olahraga_pegawai FOP
INNER JOIN pegawai P ON FOP.id_pegawai = P.id_pegawai
INNER JOIN fasilitas_olahraga FO ON FOP.id_fasilitas_olahraga = FO.id_fasilitas_olahraga
WHERE FO.harga_sewa < (	
	SELECT AVG(harga_sewa) 
	FROM fasilitas_olahraga
)
ORDER BY P.id_pegawai ASC


-- Tampilkan daftar pengelola beserta jumlah alat olahraga yang mereka urus!

SELECT P.nama_pegawai, COUNT(*) AS Jumlah_Alat_Olahraga
FROM pegawai_alat_olahraga POP
INNER JOIN pegawai P ON POP.id_pegawai = P.id_pegawai
INNER JOIN alat_olahraga AO ON POP.id_alat_olahraga = AO.id_alat_olahraga
GROUP BY P.nama_pegawai


-- View Active Database

-- Tampilkan nama fasilitas olahraga yang paling banyak dipinjam pada hari Senin beserta jumlah total peminjamannya!

CREATE OR REPLACE VIEW nama_fasilitas_olahraga_senin AS
SELECT FO.nama_fasilitas_olahraga, COUNT(*) AS jumlah_peminjaman
FROM fasilitas_olahraga FO
INNER JOIN transaksi_peminjaman TP ON FO.id_fasilitas_olahraga = TP.id_fasilitas_olahraga
WHERE EXTRACT(DOW FROM tanggal_jam_pinjam_start) = 1
GROUP BY nama_fasilitas_olahraga
ORDER BY jumlah_peminjaman DESC
LIMIT 1

SELECT * FROM nama_fasilitas_olahraga_senin



-- Tampilkan nama peminjam dan total uang yang sudah dikeluarkan oleh setiap peminjam

CREATE OR REPLACE VIEW total_name_spending AS
SELECT P.nama_peminjam, SUM(PE.harga_total_keseluruhan)
FROM transaksi_peminjaman TP
INNER JOIN peminjam P ON TP.id_peminjam = P.id_peminjam
INNER JOIN pembayaran PE ON PE.id_pembayaran = TP.id_pembayaran
GROUP BY P.nama_peminjam

SELECT * FROM total_name_spending


-- Trigger Database

-- Meng-assign tanggal_jam_booking sebagai waktu saat ini sebelum dilakukan insert record baru pada tabel booking

CREATE OR REPLACE FUNCTION update_jam_tanggal_transaksi()
RETURNS TRIGGER
AS $$
BEGIN 
	NEW.tanggal_jam_pinjam_start = NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_jam_tanggal_transaksi_trigger
	BEFORE INSERT ON transaksi_peminjaman
	FOR EACH ROW 
	EXECUTE FUNCTION update_jam_tanggal_transaksi();

INSERT INTO transaksi_peminjaman 
(tanggal_jam_pinjam_start, jam_pinjam_end, id_pegawai, id_peminjam, id_pembayaran, id_fasilitas_olahraga, id_alat_olahraga)
VALUES
('2020-12-31 5:22:43', '15:00:00', 5, 7, 1, 1, 13)


-- SELECT * FROM transaksi_peminjaman

-- Membuat trigger untuk menghitung total harga fasilitas dan alat berdasarkan id yang terkait dengan transaksi yang diperbarui. Kemudian, fungsi ini akan memperbarui kolom 'harga_total_keseluruhan' pada tabel 'pembayaran'

CREATE OR REPLACE FUNCTION update_harga_total_keseluruhan()
RETURNS TRIGGER AS $$
DECLARE
    total_harga_fasilitas NUMERIC(10, 2);
    total_harga_alat NUMERIC(10, 2);
    total_harga NUMERIC(10, 2);
BEGIN
    -- Menghitung total harga fasilitas
    SELECT SUM(FO.harga_sewa)
    INTO total_harga_fasilitas
    FROM fasilitas_olahraga FO
    WHERE FO.id_fasilitas_olahraga = NEW.id_fasilitas_olahraga;

    -- Menghitung total harga alat
    SELECT SUM(AO.harga_sewa)
    INTO total_harga_alat
    FROM alat_olahraga AO
    WHERE AO.id_alat_olahraga = NEW.id_alat_olahraga;

    -- Menghitung total harga keseluruhan
   total_harga := total_harga_fasilitas + total_harga_alat + (SELECT harga_denda FROM pembayaran WHERE id_pembayaran = NEW.id_pembayaran);

    -- Memperbarui harga total keseluruhan pada tabel 'pembayaran'
    UPDATE pembayaran
    SET harga_total_keseluruhan = total_harga
    WHERE id_pembayaran = NEW.id_pembayaran;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_harga_total_keseluruhan_trigger
AFTER UPDATE ON transaksi_peminjaman
FOR EACH ROW
EXECUTE FUNCTION update_harga_total_keseluruhan();


-- Data sebelum operasi UPDATE
SELECT * FROM pembayaran WHERE id_pembayaran = 1;

-- Operasi UPDATE pada tabel 'transaksi_peminjaman'
UPDATE transaksi_peminjaman
SET id_alat_olahraga = 2
WHERE id_transaksi = 1;

-- Data setelah operasi UPDATE
SELECT * FROM pembayaran WHERE id_pembayaran = 1;



-- Function Database

-- Tampilkan nama fasilitas olahraga yang digunakan pada bulan januari 2021, beserta jumlah peminjam dan harga sewanya


CREATE OR REPLACE FUNCTION get_fasilitas_olahraga_stats()
RETURNS TABLE (nama_fasilitas_olahraga VARCHAR,jumlah_peminjam BIGINT, harga_sewa NUMERIC)
AS $$
BEGIN
	RETURN QUERY
		SELECT FO.nama_fasilitas_olahraga, COUNT(*) AS jumlah_peminjam, FO.harga_sewa
		FROM fasilitas_olahraga FO
		WHERE F0.id_fasilitas_olahraga IN (
			SELECT TP.id_fasilitas_olahraga
			FROM Transaksi_Peminjaman TP
			WHERE TP.tanggal_jam_pinjam_start BETWEEN '2021-01-01' AND '2021-01-31'
		)
		GROUP BY FO.nama_fasilitas_olahraga, FO.harga_sewa
		ORDER BY jumlah_peminjam DESC;
END;
$$ LANGUAGE plpgsql;


SELECT * FROM get_fasilitas_olahraga_stats()
		

Membuat function untuk menghitung total pendapatan berdasarkan tanggal pada tabel pembayaran

CREATE FUNCTION hitung_total_pendapatan(tanggal_pembayaran DATE) RETURNS DECIMAL AS $$
DECLARE
  total DECIMAL;
BEGIN
  SELECT SUM(harga_total_keseluruhan) INTO total
  FROM pembayaran
  WHERE DATE(tgl_waktu_pembayaran) = tanggal_pembayaran;
  
  RETURN total;
END;
$$ LANGUAGE plpgsql;


SELECT hitung_total_pendapatan('2021-01-04');





