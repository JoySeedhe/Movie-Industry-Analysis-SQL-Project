USE MOVIES;

-- TO VIEW ALL UPLOADED TABLES --
SELECT * FROM movies_metadata;
SELECT * FROM genres;
SELECT * FROM credits;
SELECT * FROM ratings;
SELECT * FROM links;


------TABLE [movies_metadata] DELETE DUPLICATE ROWS ----------------------------------------------------
SELECT * FROM movies_metadata;

-- Add [row_id] to [movies_metadata]
ALTER TABLE movies_metadata
ADD row_id int NOT NULL IDENTITY (1,1)

-- Find out which rows are duplicated
SELECT id, COUNT(row_id)
FROM movies_metadata
GROUP BY id
HAVING COUNT(row_id) > 1

-- Delete the duplicate rows
DELETE FROM movies_metadata
	WHERE row_id NOT IN
	(
		SELECT MAX(row_id)
		FROM movies_metadata
		GROUP BY id
	);


------TABLE [genres] DELETE DUPLICATE ROWS ----------------------------------------------------
SELECT * FROM genres

-- 32269 rows in genres table
-- Check how many duplicate rows
SELECT id, COUNT(id)
FROM genres
GROUP BY id
HAVING COUNT(id) > 1


-- 18 duplicate rows
-- Add [row_id] to [genres]
ALTER TABLE genres
ADD row_id int NOT NULL IDENTITY (1,1)

SELECT * FROM genres;


-- Delete the duplicate rows
DELETE FROM genres
	WHERE row_id NOT IN
	(
		SELECT MAX(row_id)
		FROM genres
		GROUP BY id
	);


-- Now, check again for duplicate rows
SELECT id, COUNT(id)
FROM genres
GROUP BY id
HAVING COUNT(id) > 1


-- Double checking table data to check if no. of rows is 32251 = (32269-18)
select * from genres;


------TABLE [credits] DELETE DUPLICATE ROWS ----------------------------------------------------
SELECT * FROM credits;

-- 4774 rows in credits table
-- Check how many duplicate rows
SELECT id, COUNT(id)
FROM credits
GROUP BY id
HAVING COUNT(id) > 1

-- 4 duplicate rows
-- Add [row_id] to [credits]
ALTER TABLE credits
ADD row_id int NOT NULL IDENTITY (1,1)

SELECT * FROM credits;

-- Delete the duplicate rows
DELETE FROM credits
	WHERE row_id NOT IN
	(
		SELECT MAX(row_id)
		FROM credits
		GROUP BY id
	);

-- Now, check again for duplicate rows
SELECT id, COUNT(id)
FROM genres
GROUP BY id
HAVING COUNT(id) > 1

-- Double checking table data to check if no. of rows is 4770 = (4776-4)
select * from credits;

-- TABLE [links] : Check for duplicate rows
select * from links

SELECT movieId, COUNT(*)
FROM links
GROUP BY movieId
HAVING COUNT(*) > 1


------FIND OUT THE SPREAD OF THE DATA SET (BY NO. OF MOVIES RELEASED PER YEAR) ----------------------------------------------------
-- Add column [released_year]
ALTER TABLE movies_metadata
ADD released_year INT;

-- Insert values into [released_year] column derived from [release_date] --
UPDATE movies_metadata 
SET released_year=YEAR(release_date);

-- View list of number of movies released by year
SELECT released_year, COUNT(id) AS no_of_movies
FROM movies_metadata
WHERE adult=0 AND status='Released' AND budget<>0 AND revenue<>0
GROUP by released_year
ORDER BY released_year ASC;

-- Applying filter of the last 20 years to movies released by year
SELECT released_year, COUNT(id) AS no_of_movies
FROM movies_metadata
WHERE adult=0 
		AND status='Released'
		AND budget<>0
		AND revenue<>0
		AND released_year BETWEEN 1997 AND 2016
GROUP by released_year
ORDER BY released_year ASC;


---- FIND OUT THE SPREAD OF THE DATA SET (BY NUMBER OF MOVIES RELEASED BY MONTH) -----------------------------------------
---- CONSOLIDATED LAST 20 YEARS
-- Add column [released_month]
ALTER TABLE movies_metadata
ADD released_month int;

-- Insert values into [released_month] column derived from [release_date]
UPDATE movies_metadata 
SET released_month=MONTH(release_date);

-- View list of number of movies released by month (last 20 years)
SELECT released_month, COUNT(id) AS no_of_movies
FROM movies_metadata
WHERE adult=0 
		AND status='Released'
		AND budget<>0
		AND revenue<>0
		AND released_year BETWEEN 1997 AND 2016
GROUP by released_month
ORDER BY released_month ASC;


---- YEAR-ON-YEAR COMPARISION OF NO. OF MOVIES RELEASED BY MONTH (last 5 years) -------------------------------
SELECT released_year, released_month, COUNT(id) AS no_of_movies
FROM movies_metadata
WHERE adult=0 
		AND status='Released'
		AND budget<>0
		AND revenue<>0
		AND released_year BETWEEN 2012 AND 2016
GROUP BY released_year, released_month
ORDER BY released_year, released_month ASC;

---- Reformatted the above into pivot table (for easier comparison)
SELECT * FROM 
(
	SELECT released_year, released_month, id
	FROM movies_metadata
	WHERE adult=0 
		AND status='Released'
		AND budget<>0
		AND revenue<>0
		AND released_year BETWEEN 2012 AND 2016
) t
PIVOT(
	COUNT(id)
	FOR released_month IN (
	[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) AS pivot_table
ORDER BY released_year;


---- FIND OUT WHAT GENRES ARE IN THE ENTIRE DATASET ---------------------------------------------
SELECT 
	COUNT (g.[Action]) [ACTION], COUNT(g.Adventure) ADVENTURE
	, COUNT(g.Animation) ANIMATION, COUNT(g.Comedy) COMEDY
	, COUNT(g.Crime) CRIME, COUNT(g.Documentary) DOCUMENTARY
	, COUNT(g.Drama) DRAMA, COUNT(g.Family) FAMILY
	, COUNT(g.Fantasy) FANTASY, COUNT(g.[Foreign]) [FOREIGN]
	, COUNT(g.History) HISTORY, COUNT(g.Horror) HORROR
	, COUNT(g.Music) MUSIC, COUNT(g.Mystery) MYSTERY
	, COUNT(g.Romance) ROMANCE, COUNT(g.[Science Fiction]) [SCIENCE FICTION]
	, COUNT(g.Thriller) THRILLER, COUNT(g.[TV Movie]) [TV MOVIE]
	, COUNT(g.War) WAR, COUNT(g.Western) WESTERN
FROM movies_metadata m JOIN genres g
ON (m.id=g.id)
WHERE m.adult=0 AND m.status='Released' AND m.budget<>0 AND m.revenue<>0
;


---- FIND OUT WHAT ARE THE TOP 30 MOVIES WITH THE HIGHEST RETURN ON INVESTMENT ----------------------------------------------
---- FOR THE LAST 20 YEARS
---- (assuming revenue = net profit)
SELECT TOP 30 title, (revenue/budget)AS roi, revenue, budget, belongs_to_collection, released_year
FROM movies_metadata
WHERE adult=0 AND status='Released' AND budget<>0 AND revenue<>0 AND released_year>=1996
ORDER BY roi DESC;

---- Revising budget filter to filter out entries which seem "impossible"
SELECT TOP 30 title, (revenue/budget)AS roi, revenue, budget, belongs_to_collection, released_year
FROM movies_metadata
WHERE adult=0 AND status='Released' AND budget>250 AND revenue<>0 AND released_year>=1996
ORDER BY roi DESC;



---- FIND OUT WHAT TOP 30 MOVIES BRING IN THE MOST REVENUE ----------------------------------------------
---- FOR THE LAST 20 YEARS
SELECT TOP 30 title, revenue, budget, (revenue/budget)AS roi, belongs_to_collection, released_year
FROM movies_metadata
WHERE adult=0 AND status='Released' AND budget>250 AND revenue<>0 AND released_year>=1996
ORDER BY revenue DESC;


---- FIND OUT 20 MOVIES WHICH COST THE MOST TO MAKE --------------------------------------------------------
---- FOR THE LAST 20 YEARS
SELECT TOP 20 title, budget, revenue, (revenue/budget)AS roi, belongs_to_collection, released_year
FROM movies_metadata
WHERE adult=0 AND status='Released' AND budget>250 AND revenue<>0 AND released_year>=1996
ORDER BY budget DESC;


---- WHICH GENRE WAS PRODUCED THE MOST IN THE LAST 20 YEARS -------------------------------------------------
SELECT COUNT (g.[Action]) [ACTION]
	, COUNT(g.Adventure) ADVENTURE
	, COUNT(g.Animation) ANIMATION
	, COUNT(g.Comedy) COMEDY
	, COUNT(g.Crime) CRIME
	, COUNT(g.Documentary) DOCUMENTARY
	, COUNT(g.Drama) DRAMA
	, COUNT(g.Family) FAMILY
	, COUNT(g.Fantasy) FANTASY
	, COUNT(g.[Foreign]) [FOREIGN]
	, COUNT(g.History) HISTORY
	, COUNT(g.Horror) HORROR
	, COUNT(g.Music) MUSIC
	, COUNT(g.Mystery) MYSTERY
	, COUNT(g.Romance) ROMANCE
	, COUNT(g.[Science Fiction]) [SCIENCE FICTION]
	, COUNT(g.Thriller) THRILLER
	, COUNT(g.[TV Movie]) [TV MOVIE]
	, COUNT(g.War) WAR
	, COUNT(g.Western) WESTERN
FROM movies_metadata m JOIN genres g
ON (m.id=g.id)
WHERE m.adult=0
		AND m.status='Released'
		AND m.budget>250
		AND m.revenue<>0
		AND m.released_year BETWEEN 1997 AND 2016
;


-- FIND OUT TREND OF GENRES OVER THE LAST 20 YEARS
SELECT m.released_year
	, COUNT(g.[Action]) [ACTION]
	, COUNT(g.Adventure) ADVENTURE
	, COUNT(g.Animation) ANIMATION
	, COUNT(g.Comedy) COMEDY
	, COUNT(g.Crime) CRIME
	, COUNT(g.Documentary) DOCUMENTARY
	, COUNT(g.Drama) DRAMA
	, COUNT(g.Family) FAMILY
	, COUNT(g.Fantasy) FANTASY
	, COUNT(g.[Foreign]) [FOREIGN]
	, COUNT(g.History) HISTORY
	, COUNT(g.Horror) HORROR
	, COUNT(g.Music) MUSIC
	, COUNT(g.Mystery) MYSTERY
	, COUNT(g.Romance) ROMANCE
	, COUNT(g.[Science Fiction]) [SCIENCE FICTION]
	, COUNT(g.Thriller) THRILLER
	, COUNT(g.[TV Movie]) [TV MOVIE]
	, COUNT(g.War) WAR
	, COUNT(g.Western) WESTERN
FROM movies_metadata m JOIN genres g
ON (m.id=g.id)
WHERE m.adult=0
		AND m.status='Released'
		AND m.budget>250
		AND m.revenue<>0
		AND m.released_year BETWEEN 1997 AND 2016
GROUP BY m.released_year
ORDER BY m.released_year;


-- FIND OUT DETAILS OF MOVIES WITH THE HIGHEST NO_OF_RATERS AND THE CORRESPONDING AVG RATING --
SELECT * FROM ratings;
SELECT * FROM links;
SELECT * FROM movies_metadata;

 ---- Calculate the avg rating per movie. Note to display the no_of_raters, sorted in desc
SELECT movieid, count(userid) AS no_of_raters, avg(rating) AS avg_rating
FROM ratings
GROUP BY movieid
ORDER BY no_of_raters DESC

---- From the above, max no_of_raters is 91921, min is 1
---- Let's view the avg ratings for movies, with top 200 engagement (no_of_raters)
select TOP 200
	movieid, count(userid) AS no_of_raters, avg(rating) AS avg_rating
	from ratings
	group by movieid
	order by no_of_raters desc

---- Refine question to display top 200 movies (with details) with top engagement (no_of_raters)
---- Create view for [top200_rated_movies]
CREATE VIEW [vw_top200_rated_movies]
AS
		SELECT TOP 200
			movieid, count(userid) AS no_of_raters, avg(rating) AS avg_rating
			FROM ratings
			GROUP BY movieid
			ORDER BY no_of_raters desc
;

SELECT * FROM [vw_top200_rated_movies];

---- Attach the details of the movies to the above list
SELECT vwt200rm.no_of_raters, vwt200rm.avg_rating, m.released_year, m.title
		, m.tagline, m.belongs_to_collection, m.homepage
FROM movies_metadata m JOIN links l
ON (m.id = l.tmdbId)
JOIN vw_top200_rated_movies vwt200rm
ON (vwt200rm.movieid = l.movieId)
WHERE l.movieId IN (	SELECT movieId
						FROM vw_top200_rated_movies)
ORDER BY no_of_raters DESC
;


---- DATA DUMP FOR EXCEL INTERACTIVE DASHBOARD --------------------------------------------------------
SELECT * FROM movies_metadata;
SELECT * FROM genres;

SELECT * FROM links;
SELECT * FROM ratings;

SELECT * FROM credits;


---- Make table [ratings] compatible to be "attached" to the excel data dump.
---- Create view of avg rating by movie for the entire list in ratings table.
---- Note to include no_of_raters.
CREATE VIEW [vw_movie_ratings]
AS
		SELECT movieid, count(userid) AS no_of_raters, avg(rating) AS avg_rating
		FROM ratings
		GROUP BY movieid;

SELECT * FROM [vw_movie_ratings];


-- Combine view [vw_movie_ratings] into table [links]
CREATE VIEW [vw_movie_ratings_linked]
AS
(	
	SELECT l.movieId, l.imdbId, tmdbId, vwmr.no_of_raters, vwmr.avg_rating
	FROM links l LEFT JOIN vw_movie_ratings vwmr
	ON (l.movieId = vwmr.movieid)
);

SELECT * FROM [vw_movie_ratings_linked];


-- Join all tables and views together
-- [movies_metadata] with [vw_movie_ratings_linked], [genres], [credits]
CREATE VIEW [vw_excel_data_dump]
AS
(	SELECT m.id, m.imdb_id, mrl.movieId
	, m.release_date, m.released_year, m.released_month, m.title, g.genres_cluster, m. belongs_to_collection
	, m.homepage, m.poster_path, m.production_company, m.production_countries, m.revenue, m.budget, m.runtime, m.popularity, m.vote_average, m.vote_count
	, mrl.no_of_raters, mrl.avg_rating, g.[Action], g.Adventure, g.Animation, g.Comedy, g.Crime, g.Documentary, g.Drama
	, g.Family, g.Fantasy, g.[Foreign], g.History, g.Horror, g.Music, g.Mystery, g.Romance, g.[Science Fiction], g.Thriller, g.[TV Movie], g.War, g.Western
	, c.director_name, c.[cast], c.cast1, c.cast2, c.cast3, c.cast4, c.cast5
	FROM movies_metadata m LEFT JOIN vw_movie_ratings_linked mrl
	ON (m.id = mrl.tmdbId)
	LEFT JOIN genres g
	ON (g.id = m.id)
	LEFT JOIN credits c
	ON (c.id = m.id)
	WHERE m.adult=0
		AND m.status='Released'
		AND m.budget>250
		AND m.revenue<>0
		AND m.released_year BETWEEN 1997 AND 2017
);

SELECT *  FROM [vw_excel_data_dump];





