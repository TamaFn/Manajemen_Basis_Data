-- Select the sid and name of sailor that has a rating greater than the rating average

SELECT sid,sname
FROM Sailors
WHERE rating > (
	SELECT AVG(rating)
	FROM Sailors
);

-- Select the sid and name of sailor that has the most number of reservations
SELECT s.sid , s.sname
FROM Sailors s
INNER JOIN Reserves r ON s.sid = r.sid
GROUP BY s.sid
ORDER BY COUNT(s.sid) DESC
LIMIT 1

-- Select the average age of sailors reserving ‘Interlake’ or ‘Marine’ boats 

SELECT ROUND(AVG(s.age),2) as Rata_Rata_Umur
FROM Sailors s
INNER JOIN Reserves r ON s.sid = r.sid
INNER JOIN Boats b ON r.bid = b.bid
WHERE b.bname IN ('Interlake', 'Marine')

-- Select the month and the number of reservations for each month
SELECT EXTRACT(MONTH FROM r.day) AS Month, COUNT(*) AS Number_Reservation
FROM Reserves r
GROUP BY EXTRACT(MONTH FROM r.day)
ORDER BY EXTRACT(MONTH FROM r.day);

-- Select the percentage of red boat reservations of all reservations
SELECT (COUNT(b.color)* 100 / (SELECT COUNT(*) FROM RESERVES)) AS Presentase_Kapal_Merah
FROM reserves r
INNER JOIN boats b ON r.bid = b.bid
WHERE b.color IN (
	SELECT b.color
	FROM Boats b
	WHERE b.color = 'red'
)

-- ================================ Exercise 2 =============================

SELECT * FROM Provinsi
SELECT * FROM Kota

CREATE DATABASE exercise_provkot
CREATE TABLE Provinsi(
	id_provinsi INTEGER NOT NULL,
	nama_provinsi VARCHAR(50) NOT NULL
);
CREATE TABLE Kota(
	id_kota INTEGER NOT NULL,
	nama_kota VARCHAR(50) NOT NULL,
	id_provinsi INTEGER NOT NULL
);


INSERT INTO Provinsi VALUES
(1,'DKI Jakarta'),
(2,'Jawa Tengah'),
(3,'Papua Barat'),
(4,'Jawa Timur'),
(5,'Jawa Barat');

INSERT INTO Kota VALUES
(1,'Jakarta',1),
(2,'Semarang',2),
(3,'Surabaya',4),
(4,'Malang',4),
(5,'Bandung',5),
(6,'Denpasar',6),
(7,'Makasar',7);

-- Select a number of city of “Jawa Timur”
SELECT k.id_kota
FROM Kota k
JOIN Provinsi p ON k.id_provinsi = p.id_provinsi
WHERE p.nama_provinsi = 'Jawa Timur'


-- Select the name of province that has maximum number of city
SELECT p.nama_provinsi
FROM Provinsi p
JOIN Kota k ON p.id_provinsi = k.id_provinsi
WHERE k.id_kota = (
	SELECT MAX(k.id_kota)
	FROM Kota k
)

-- Select all province’s name and the number of their cities 
SELECT Prov.nama_provinsi, COUNT(Kot.nama_kota)
FROM Provinsi Prov
NATURAL LEFT JOIN Kota Kot
GROUP BY Prov.nama_provinsi
ORDER BY Prov.nama_provinsi;

-- Select name of provinces and name of cities of those provinces (if the province didn’t have city, the column ‘nama_kota’ will be null)
SELECT p.nama_provinsi, k.nama_kota
FROM Provinsi p
LEFT JOIN Kota k ON p.id_provinsi = k.id_provinsi


-- Select name of provinces that don't have a city
SELECT DISTINCT p.nama_provinsi
FROM Provinsi p
LEFT JOIN Kota k ON p.id_provinsi = k.id_provinsi
WHERE k.id_kota IS NULL




