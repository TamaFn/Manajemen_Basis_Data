CREATE TABLE Sailors(
	sid INTEGER PRIMARY KEY NOT NULL,
	sname VARCHAR (10) NOT NULL,
	rating INTEGER NOT NULL,
	age DECIMAL(4,1) NOT NULL
);

CREATE TABLE Boats(
	bid INTEGER PRIMARY KEY NOT NULL,
	bname VARCHAR(10) NOT NULL,
	color VARCHAR(10) NOT NULL
);

CREATE TABLE Reserves(
	sid INTEGER NOT NULL,
	bid INTEGER NOT NULL,
	day DATE NOT NULL,
	CONSTRAINT fk_sid
		FOREIGN KEY(sid) REFERENCES Sailors(sid),
		FOREIGN KEY(bid) REFERENCES Boats(bid)
);

INSERT INTO Sailors VALUES
(22,'Dustin',7,45.0),
(29,'Brutus',1,33.0),
(31,'Lubber',8,55.5),
(32,'Andy',8,25.5),
(58,'Rusty',10,35.0),
(64,'Horatio',7,35.0),
(71,'Zorba',10,16.0),
(74,'Horatio',9,35.0),
(85,'Art',3,25.5),
(95,'Bob',3,63.5);

SELECT *
FROM Sailors;

INSERT INTO Boats VALUES
(101,'Interlake','blue'),
(102,'Interlake','red'),
(103,'Clipper','green'),
(104,'Marine','red');


SELECT *
FROM Boats;

INSERT INTO Reserves VALUES
(22,101,'1998-10-10'),
(22,102,'1998-10-10'),
(22,103,'1998-10-08'),
(22,104,'1998-10-07'),
(31,102,'1998-11-10'),
(31,103,'1998-11-06'),
(31,104,'1998-11-12'),
(64,101,'1998-09-05'),
(64,102,'1998-09-08'),
(74,103,'1998-09-08');

SELECT * 
FROM Reserves;

-- Select the name and sid of Sailor who has a 35 years old
SELECT sname,sid
FROM Sailors
WHERE age = 35


-- Select the name of Sailor who has rating more than 5
SELECT sname
FROM Sailors
WHERE rating > 5

-- Select the sid, bid and day from table Reserves in October
SELECT sid,bid,day
FROM Reserves
WHERE EXTRACT(MONTH FROM day) = '10';

-- Select the name of Sailor who borrowed Red and Green Boats
SELECT sname
FROM Sailors 
Where sid IN (
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'red'
	INTERSECT 
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'green'
);

-- Select the name of Sailor who borrowed Red or Green Boats 
SELECT sname
FROM Sailors 
Where sid IN (
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'red'
	UNION 
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'green'
);

-- Select the name of Sailor who borrowed Red but not borrowed Green Boat
SELECT sname
FROM Sailors 
Where sid IN (
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'red'
	EXCEPT
	Select s.sid
	FROM Sailors s, Boats b, Reserves r
	WHERE r.sid = s.sid AND r.bid = b.bid AND b.color = 'green'
);



