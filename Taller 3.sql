-- 1.  Cuántos artistas tenemos R// 275

SELECT COUNT(DISTINCT (Name)) FROM artists AR ;

-- 2. A qué artista pertenece el álbum “Voodoo Lounge” R//The Rolling Stones

SELECT 
AL.Title, AR.NAME
FROM
(SELECT * FROM albums 
WHERE Title = 'Voodoo Lounge')AL
LEFT JOIN 
(SELECT * FROM artists)AR 
ON AL.ArtistId = AR.ArtistId;

/* 3. Cuales son los álbumes que tiene el artista “Ozzy Osbourne” 
R// Bark at the Moon (Remastered)
Blizzard of Ozz
Diary of a Madman (Remastered)
No More Tears (Remastered)
Tribute
Speak of the Devil*/

SELECT  
AO.Name,AA.Title
FROM
(SELECT * FROM artists 
WHERE Name = 'Ozzy Osbourne')AO
LEFT JOIN
(SELECT * FROM albums) AA 
ON AO.ArtistId=AA.ArtistId;

--4. Cuantas canciones tiene el artista “Red Hot Chili Peppers” R//48

SELECT COUNT(DISTINCT (AT.Name))
FROM
(SELECT * FROM artists 
WHERE Name = 'Red Hot Chili Peppers')AO
LEFT JOIN
(SELECT * FROM albums) AA 
ON AO.ArtistId=AA.ArtistId
LEFT JOIN
(SELECT * FROM tracks)AT
ON AT.AlbumId=AA.AlbumId

--5. Cuales son los 3 tracks más largos (tiempo) R// Occupation / Precipice, Through a Looking Glass, Greetings from Earth, Pt. 1

SELECT   
Name,Milliseconds
FROM tracks ORDER BY Milliseconds DESC 
LIMIT 3

/*Occupation / Precipice	5286953
Through a Looking Glass	5088838
Greetings from Earth, Pt. 1	2960293*/

--6. Cual es el género de la canción que menos peso tiene (Bytes) R//Rock

SELECT T.Bytes, G.Name FROM 
(SELECT * FROM tracks ORDER BY Bytes ASC LIMIT 1)T
LEFT JOIN 
(SELECT * FROM genres)G
ON G.GenreId=T.GenreId

--7. Cual es el genero con mas canciones R// Rock

SELECT T.TOTAL,G.NAME FROM
(SELECT COUNT(Name) AS TOTAL,GenreId FROM tracks GROUP BY GenreId )T
LEFT JOIN 
(SELECT * FROM genres)G
ON G.GenreId=T.GenreId
ORDER BY T.TOTAL DESC
LIMIT 1

--8. Indicar el top 10 de los artistas con más canciones R//

/*
150	Iron Maiden
124	U2
112	Metallica
91	Lost
91	Led Zeppelin
87	Deep Purple
63	Pearl Jam
57	Lenny Kravitz
56	Various Artists
52	The Office*/


SELECT COUNT(DISTINCT AT.name),AO.name  FROM
(SELECT * FROM artists)AO
LEFT JOIN
(SELECT * FROM albums) AA 
ON AO.ArtistId=AA.ArtistId
LEFT JOIN
(SELECT * FROM tracks)AT
ON AT.AlbumId=AA.AlbumId
GROUP BY AO.name
ORDER BY COUNT(DISTINCT AT.name) DESC 
LIMIT 10;

-- 9. Cuantos invoices tiene cada empleado, organizar desde el mayor al menor


SELECT I.LastName, I.FirstName,COUNT(a.InvoiceId) AS TOTAL
FROM
(SELECT EmployeeId, LastName, FirstName FROM employees e)I
LEFT JOIN
(SELECT CustomerId,SupportRepId FROM customers)C
ON C.SupportRepId=I.EmployeeId
LEFT JOIN
(SELECT CustomerId,InvoiceId FROM invoices)A
ON A.CustomerId=c.CustomerId
GROUP BY I.LastName, I.FirstName
ORDER BY COUNT(a.InvoiceId) DESC 


/*RR
 * 
Peacock	Jane		146
Park	Margaret	140
Johnson	Steve		126
Adams	Andrew		0
Callahan	Laura	0
Edwards	Nancy		0
King	Robert		0
Mitchell	Michael	0*/


--10. Cual es la cancion que mas existe en las playlist.  R// Intoitus: Adorate Deum

SELECT t.Name, pt.TRACKID, COUNT(pt.TRACKID) AS TOTAL
FROM playlist_track pt
INNER JOIN tracks t
ON pt.TRACKID = t.TrackId
GROUP BY pt.TRACKID, t.Name
ORDER BY TOTAL DESC
LIMIT 1;












