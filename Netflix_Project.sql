-- CREATE A NETFLIX TABLE

CREATE TABLE NETFLIX(
show_id VARCHAR(10),
type VARCHAR(50),
title VARCHAR(200),
director VARCHAR(500),
casts VARCHAR(1000),
country	VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(50),
duration VARCHAR(20),
listed_in VARCHAR(150),
description VARCHAR(300)
);

-- Count the number of movies versus TV shows on Netflix to analyze content distribution.
SELECT  type, COUNT(show_id)
FROM NETFLIX
GROUP BY type;

--Categorize content based on the presence of keywords like "kill" or "violence" in the description to assess content intensity.
SELECT *
FROM NETFLIX
WHERE description ILIKE '%kill%' OR  description ILIKE '%violence%';

--Identify the most common rating for movies and TV shows by calculating the frequency of each rating within its content type.
SELECT type,rating,COUNT(*) AS Total_Ratings, RANK() OVER(PARTITION BY type ORDER BY COUNT(*)) AS Ranking
FROM NETFLIX
GROUP BY type,rating
--ORDER BY Total_Ratings DESC;

--Retrieve all movies released in a specific year, such as 2020, to analyze annual content output.
SELECT *
FROM NETFLIX
WHERE release_year=2020 AND type='Movie';

--Identify the top 10 actors who have appeared in the highest number of movies produced in India by grouping and counting actor appearances.
SELECT UNNEST(STRING_TO_ARRAY(casts,',')) AS Actors, COUNT(*) AS Total_Movies
FROM NETFLIX
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

--Determine the top 5 countries with the highest number of content items on Netflix by splitting and counting country values.
SELECT UNNEST(STRING_TO_ARRAY(country,',')) AS New_Country , COUNT(show_id) AS Total_content
FROM NETFLIX
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Identify the longest movie by ordering movies by duration in minutes and selecting the highest value.
SELECT *
FROM NETFLIX
WHERE type='Movie' AND duration=(SELECT MAX(duration) FROM NETFLIX);

--Find all content added to Netflix in the last 5 years by filtering entries based on the date_added field.
SELECT *
FROM NETFLIX 
WHERE TO_DATE(date_added,'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years';

--List all movies and TV shows directed by a specific director, such as Rajiv Chilaka, by unnesting the director field.
SELECT *
FROM NETFLIX
WHERE director ILIKE'%Rajiv Chilaka%';

--Count how many movies featuring a specific actor, such as Salman Khan, were released in the last 10 years.
SELECT *
FROM NETFLIX
WHERE casts LIKE 'Salman %' AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE)-10;

--Find all content that does not have a director listed by filtering for NULL values in the director column.
SELECT * 
FROM NETFLIX
WHERE director IS NULL;

--List all movies classified as documentaries by searching for the keyword "Documentaries" in the listed_in field.
SELECT *
FROM NETFLIX 
WHERE listed_in ILIKE '%documentaries%';

--Count the number of content items in each genre by splitting the listed_in field and grouping by genre.
SELECT UNNEST(STRING_TO_ARRAY(listed_in,',')) AS Genre, COUNT(listed_in)
FROM  NETFLIX
GROUP BY 1
ORDER BY 2 DESC;






