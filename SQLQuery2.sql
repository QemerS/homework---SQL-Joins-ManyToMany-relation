--Bir kino saytı databazası qurursunuz
CREATE DATABASE Kino
--Saytda filmlər (Movies table), 
--film janrları (Genres table),
--aktyorlar (Actors table) ve 
--aktryorların oynadıqları filmlər (ActorMovies  table)
USE Kino
CREATE TABLE Genre
(
Id INT PRIMARY KEY,
Name NVARCHAR(20) UNIQUE
)

CREATE TABLE Actors
(
Id INT PRIMARY KEY,
Name NVARCHAR(10),
Surname NVARCHAR(10),
Age INT
)

CREATE TABLE Movies
(
Id INT PRIMARY KEY,
Name NVARCHAR(100),
GenreId INT
FOREIGN KEY
REFERENCES Genre(Id),
ActorId INT
FOREIGN KEY
REFERENCES Actors(Id)
)
CREATE TABLE ActorMovies
(
Id INT PRIMARY KEY,
ActorId INT FOREIGN KEY 
REFERENCES Actors(Id),
MovieId INT FOREIGN KEY 
REFERENCES Movies(Id),
)

--hər table-a 5-10 data əlavə edin
INSERT INTO Genre
VALUES
(1,'Drama'),
(2,'Crime'),
(3, 'Action'),
(4, 'Biography'),
(5, 'History'),
(6, 'Adventure'),
(7, 'Romance')

INSERT INTO Actors
VALUES
(1,'Tim','Robbins', 63),
(2,'Morgan','Freeman', 84),
(3,'Bob','Gunton', 76),
(4,'Marlon','Brando', 80),
(5,'Alfredo','James', 81),
(6,'James','Caan', 81),
(7,'Elijah','Wood', 40),
(8,'Viggo','Mortensen', 63),
(9,'Ian','McKellen', 82),
(10,'Liam','Neeson', 69),
(11,'Ralph','Fiennes', 59),
(12,'Ben','Kingsley', 78),
(13,'Tom','Hanks', 65),
(14,'Robin', 'Wright', 55),
(15,'Gary','Sinise', 76)

INSERT INTO Movies
VALUES
(1,'The Shawshank Redemption',1 , 1),
(2,'The Godfather', 2, 4),
(3,'The Lord of the Rings', 6, 7),
(4,'Schindlers List', 5, 10),
(5,'Forrest Gump', 7, 13)

INSERT INTO ActorMovies
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 4),
(11, 11, 4),
(12, 12, 4),
(13, 13, 5),
(14, 14, 5),
(15, 15, 5)

--(OKAY)Janrların siyajısı üçün select query -  bu querydə janrların öz columnlarəından əlavə həmin janrda neçə film oduğu da görsənməlidir

-- bir drama elave edirem ki gorek dramalarin sayi 2 olacaqmi
INSERT INTO Movies
VALUES
(6,'The GodFather: Part  II',1 , 5)

SELECT DISTINCT Genre.Name,(SELECT COUNT(Movies.GenreId)FROM Movies WHERE Genre.Id = Movies.GenreId) AS 'Filmlerin sayi' 
FROM Genre, Movies

--(OKAY)Bütün Actors datalarını select edən query - hansıların ki yaşları ümümu bütün aktyorların yaş ortalamasından böyükdüe
SELECT * FROM Actors WHERE Actors.Age>(SELECT AVG(Actors.Age) FROM Actors)

--(OKAY)ActorMovies datalarını select eden query
--bu query əlaqəli Actorsların Name,Surname,Age deyerleri və oynadıqları Movies datalarının adlarını göstərməlidir,
--yəni selectin resultında Aktyorların  adı,soyadı,yaşı və oynadığı filmin adı olmalıdır.
SELECT Actors.Name, Actors.Surname,Actors.Age, Movies.Name
FROM ActorMovies
JOIN Actors ON ActorId = Actors.Id
JOIN Movies ON MovieId= Movies.Id

--(OKAY kimi bir şeydi)Hər hansısa bir filmdə oynamış Actors datalarını select edən query,
--əgər Actor datası heç bir filmdə oynamayıbsa bu selectdə çıxmamalıdır.
INSERT INTO Actors
VALUES
(16, 'Henry', 'Cavill', 38),
(17, 'Anya', 'Chalotra', 25),
(18, 'Freya', 'Allan', 20)
SELECT * FROM Actors, ActorMovies WHERE Actors.Id = ActorMovies.ActorId