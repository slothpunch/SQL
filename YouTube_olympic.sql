-- ctrl + e or F5

USE SQL_Practice;

SELECT TOP 5 * FROM athlete_events;

SELECT TOP 5 * FROM noc_regions;



/*
# YouTube - Olympic


20 Questions

1. **How many Olympic Games have been held?**
2. **List down all Olympic Games held so far.**
3. **Mention the total no of nations who participated in each Olympics?**
4. **Which year saw the highest and lowest no of countries participating in the Olympics?**
5. **Which nation has participated in all of the Olympic Games?**
6. **Identify the sport which was played in all summer Olympics.**
7. **Which Sports were just played only once in the Olympics?**
8. **Fetch the total no of sports played in each Olympic Games.**
9. **Fetch details of the oldest athletes to win a gold medal.**
10. **Find the ratio of male and female athletes who participated in all Olympic Games.**
11. **Fetch the top 5 athletes who have won the most gold medals.**
12. **Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).**
13. **Fetch the top 5 most successful countries in Olympics. Success is defined by no of medals won.**
14. **List down total gold, silver and bronze medals won by each country.**
15. **List down total gold, silver and bronze medals won by each country corresponding to each Olympic Games.**
16. **Identify which country won the most gold, most silver and most bronze medals in each Olympic Games.**
17. **Identify which country won the most gold, most silver, most bronze medals and the most medals in each Olympic Games.**
18. **Which countries have never won a gold medal but have won silver/bronze medals?**
19. **In which Sport/event, India has won highest medals.**
20. **Break down all Olympic Games where India won medals for Hockey and how many medals in each Olympic Games.**

*/

SELECT TOP 5 * FROM athlete_events;
SELECT TOP 5 * FROM noc_regions;

--1. * How many Olympic Games have been held?

SELECT 
	COUNT(DISTINCT(Games))
FROM	
	athlete_events; -- 51 games

--2. * List down all Olympic Games held so far.

SELECT 
	DISTINCT(Games),
	Year
FROM	
	athlete_events
ORDER BY Year DESC; -- 51 games

--3. * Mention the total no of nations who participated in each Olympics?

SELECT 
	Team,
	COUNT(Team) AS 'num_of_participations'
FROM
	athlete_events
GROUP BY Team;

--4. *** Which year saw the highest and lowest no of countries participating in the Olympics?
-- https://www.sqltutorial.org/sql-window-functions/sql-first_value/

USE SQL_Practice;

SELECT
	TOP 5 *
FROM athlete_events;

SELECT
	DISTINCT NOC, region
FROM noc_regions;

SELECT
	Games,
	COUNT(DISTINCT(Team)) AS num_countries
FROM athlete_events
GROUP BY Games
ORDER BY 2;


-- 18 rows
SELECT
	Games,
	Team
FROM athlete_events
WHERE Games = '1896 Summer'
GROUP BY Games, Team
ORDER BY 1;

-- 20 rows
SELECT games, Team, oh.NOC, region AS country
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE Games = '1896 Summer'
GROUP BY games, Team, oh.NOC, region
ORDER BY 1;

-- 12 rows
select games, nr.region, oh.NOC
from athlete_events oh
join noc_regions nr ON nr.noc=oh.noc
WHERE Games = '1896 Summer'
group by games, nr.region, oh.NOC;

-- Game with the lowest number of countries participating
SELECT 
	TOP 1 games, 
	COUNT(DISTINCT(oh.NOC)) AS lowest_num_of_countries
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
GROUP BY games
ORDER BY 2;

-- Game with Largest number of countries participating
SELECT 
	TOP 1 games, 
	COUNT(DISTINCT(oh.NOC)) AS lowest_num_of_countries
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
GROUP BY games
ORDER BY 2;



SELECT
	Games,
	NOC
FROM athlete_events
WHERE Games = '1896 Summer'
GROUP BY Games, NOC
ORDER BY 1;

select games, oh.NOC
from athlete_events oh
join noc_regions nr ON nr.noc=oh.noc
WHERE Games = '1896 Summer'
group by games, oh.NOC;


SELECT games, Team, oh.NOC
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
GROUP BY games, Team, oh.NOC
ORDER BY 1;

SELECT games, Team, oh.NOC, region AS country
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
GROUP BY games, Team, oh.NOC, region
ORDER BY 1;

-- Wihout the Team column
-- DISTINCT is not required at this moment as GROUP BY function 
-- 206

SELECT games, oh.NOC
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE games = '2016 Summer'
GROUP BY games, oh.NOC
ORDER BY 1;

-- 207
SELECT
	Games,
	NOC
FROM athlete_events
WHERE Games = '2016 Summer'
GROUP BY Games, NOC
ORDER BY 2;


-- https://stackoverflow.com/questions/7181976/must-declare-the-scalar-variable
-- Compare two results
WITH t1 AS(
-- Answer query
SELECT 
	Games, 
	oh.NOC
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE Games = '2016 Summer'
GROUP BY Games, oh.NOC
),
t2 AS(
-- My query
SELECT
	Games,
	NOC
FROM athlete_events
WHERE Games = '2016 Summer'
GROUP BY Games, NOC
)
SELECT * FROM t1 
except 
SELECT * FROM t2
UNION ALL(
SELECT * FROM t2 
except 
SELECT * FROM t1);

-- 1
SELECT 
	COUNT(*) AS '1'
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE Games = '2016 Summer' AND oh.NOC = 'SGP';

-- 2
SELECT
	COUNT(*) AS '2'
FROM athlete_events
WHERE Games = '2016 Summer' AND NOC = 'SGP';

SELECT *
FROM noc_regions
WHERE NOC = 'SGP';

SELECT *
FROM athlete_events
WHERE NOC = 'SGP';

BEGIN TRAN;
UPDATE noc_regions
SET NOC = 'SGP'
WHERE NOC = 'SIN';
COMMIT TRAN;

SELECT *
FROM noc_regions
WHERE region = 'Singapore';

SELECT 
	Games,
	COUNT(DISTINCT(oh.NOC)) AS 'num_of_countries'
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE games = '2016 Summer'
GROUP BY Games;

SELECT 
	Games,
	oh.noc
FROM athlete_events oh
JOIN noc_regions nr ON nr.noc=oh.noc
WHERE games = '2016 Summer' AND oh.NOC = 'SGP'
GROUP BY Games, oh.noc;

-----------------------------------------------------

WITH games_con AS(
SELECT
	Games,
	COUNT(DISTINCT(NOC)) AS num_countries
FROM athlete_events
GROUP BY Games
)
SELECT
	TOP 1
	CONCAT(FIRST_VALUE(Games) OVER(ORDER BY num_countries DESC), 
	' - ', 
	FIRST_VALUE(num_countries) OVER(ORDER BY num_countries DESC)) AS highest_country,
	CONCAT(FIRST_VALUE(Games) OVER(ORDER BY num_countries), 
	' - ', 
	FIRST_VALUE(num_countries) OVER(ORDER BY num_countries)) AS lowest_country
FROM games_con;


--5. Which nation has participated in all of the Olympic Games?

SELECT 
	Team,
	COUNT(DISTINCT(Games)) AS game_count
FROM athlete_events
GROUP BY Team
HAVING COUNT(DISTINCT(Games)) = (SELECT COUNT(DISTINCT(Games)) FROM athlete_events);

--6. **Identify the sport which was played in all summer Olympics.**

WITH t1 AS(
	SELECT 
		COUNT(DISTINCT(Games)) AS num_of_summer_games
		FROM athlete_events	WHERE Season = 'Summer'),
	t2 AS (
		SELECT Games, Sport FROM athlete_events
		WHERE Season = 'Summer' GROUP BY Games, Sport),
	t3 AS (
		SELECT Sport, COUNT(Sport) AS num_of_sport_played
		FROM t2 GROUP BY Sport
)
SELECT * FROM t3
JOIN t1 ON t1.num_of_summer_games = t3.num_of_sport_played;


--7. Which Sports were just played only once in the Olympics?
-- played only in one Olympics game. e.g. Cricket was played only in the 1900 Olympic game, but not in the other Olympic games. 


WITH t1 AS (
		SELECT 
			Games,
			Sport
		FROM athlete_events
		GROUP BY Games, Sport),
	t2 AS (
		SELECT Sport, COUNT(Sport) AS num_played FROM t1
		GROUP BY Sport
)
	SELECT Games, t2.Sport, num_played
	FROM t2
	JOIN t1 ON t2.Sport = t1.Sport
	WHERE num_played = 1
	ORDER BY 1;

--8. **Fetch the total no of sports played in each Olympic Games.**

SELECT
	Games,
	Sport,
	COUNT(Sport) AS num_sport_played
FROM athlete_events
GROUP BY Games, Sport
ORDER BY 1;

--9. **Fetch details of the oldest athletes to win a gold medal.**

WITH t1 AS(
SELECT 
	*,
	RANK() OVER(ORDER BY Age DESC) AS age_rank
FROM athlete_events
WHERE Age <> 'NA' AND Medal = 'Gold'
)
SELECT *
FROM t1
WHERE age_rank = 1;


--10. **Find the ratio of male and female athletes who participated in all Olympic Games. 
-- ??? the ratio of male and female athletes in each Olympic game?

WITH t1 AS(
	SELECT
		Games,
		Sex,
		COUNT(Sex) AS gen_count
	FROM athlete_events
	GROUP BY Games, Sex
), t2 AS(
	SELECT 
		Games, 
		COUNT(1) AS total_num
	FROM athlete_events
	GROUP BY Games
), t3 AS(
	SELECT 
		t1.Games,
		Sex, 
		gen_count, 
		CONCAT(ROUND(CAST(gen_count AS FLOAT)/CAST(total_num AS FLOAT), 2)*100, '%') AS per_cent
	FROM t1
	JOIN t2 ON t1.Games = t2.Games
)
SELECT * FROM t3 ORDER BY Games, Sex DESC;


--11. **Fetch the top 5 athletes who have won the most gold medals.**

SELECT
	TOP 5 ID, 
	Name,
	Medal,
	COUNT(Medal) AS num_gold_medals
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY ID, Name, Medal
ORDER BY COUNT(Medal) DESC;

--12. **Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).**

SELECT
	TOP 5 ID, 
	Name,
	COUNT(Medal) AS num_medals
FROM athlete_events
WHERE Medal <> 'NA'
GROUP BY ID, Name
ORDER BY COUNT(Medal) DESC;

--13. **Fetch the top 5 most successful countries in Olympics. Success is defined by no of medals won.**

SELECT
	TOP 5 Team AS Country, 
	COUNT(Medal) AS num_medals
FROM athlete_events
WHERE Medal != 'NA'
GROUP BY Team
ORDER BY COUNT(Medal) DESC;

--14. **List down total gold, silver and bronze medals won by each country.**

SELECT
	Team AS Country,
	Medal,
	COUNT(Medal) AS num_medals
FROM athlete_events
WHERE Medal <> 'NA'
GROUP BY Team, Medal
ORDER BY Team;

--15. **List down total gold, silver and bronze medals won by each country corresponding to each Olympic Games.**

SELECT
	Games,
	Team AS Country,
	Medal,
	COUNT(Medal) AS num_medals
FROM athlete_events
WHERE Medal <> 'NA'
GROUP BY Games, Team, Medal
ORDER BY 1, 2,
	CASE 
		WHEN Medal = 'Bronze' THEN 0
		WHEN Medal = 'Silver' THEN 1
		WHEN Medal = 'Gold' THEN 2
		ELSE ''
	END;

--16. **Identify which country won the most gold, most silver and most bronze medals in each Olympic Games.**





--17. **Identify which country won the most gold, most silver, most bronze medals and the most medals in each Olympic Games.**

--18. **Which countries have never won a gold medal but have won silver/bronze medals?**

--19. **In which Sport/event, India has won highest medals.**

--20. **Break down all Olympic Games where India won medals for Hockey and how many medals in each Olympic Games.**









