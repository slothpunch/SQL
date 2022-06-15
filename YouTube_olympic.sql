
-- D:\1. Data Analyst Portfolio\SQL\YouTube\1. Olympic

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
-- 4296 rows
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

/*
Change the output format:

 | country | num_gold | num_siver | num_bronze 

*/

WITH gold AS(
SELECT 
	Games,
	Team,
	COUNT(Medal) 'num_gold'
FROM athlete_events 
WHERE Medal = 'Gold'
GROUP BY Games, Team
), silver AS(
SELECT 
	Team,
	COUNT(Medal) 'num_silver'
FROM athlete_events 
WHERE Medal = 'silver'
GROUP BY Team
), bronze AS(
SELECT 
	Team,
	COUNT(Medal) 'num_bronze'
FROM athlete_events 
WHERE Medal = 'Gold'
GROUP BY Team
)
SELECT ae.Games, ae.Team, num_gold, num_silver, num_bronze
FROM athlete_events ae
JOIN gold g ON ae.Team = g.Team
JOIN silver s ON ae.Team = s.Team
JOIN bronze b ON ae.Team = b.Team
GROUP BY ae.Games, ae.Team;


--

WITH all_medal AS( -- 39,783
SELECT
	Games,
	Team,
	Medal
FROM athlete_events
WHERE Medal <> 'NA'
), gold AS(
SELECT 
	Games,
	Team,
	COUNT(Medal) 'num_gold'
FROM all_medal 
WHERE Medal = 'Gold'
GROUP BY Games, Team
)
SELECT am.Games, am.Team, num_gold
FROM all_medal am
JOIN gold g ON am.Games = g.Games
GROUP BY am.Games, am.Team
ORDER BY 1, 2


WITH all_medal AS( -- 39,783
SELECT
	Games,
	Team,
	Medal
FROM athlete_events
WHERE Medal <> 'NA'
)
SELECT 
	Games,
	Team,
	COUNT(Medal) 'num_gold'
FROM all_medal 
WHERE Medal = 'Gold'
GROUP BY Games, Team
ORDER BY 1, 2

--16. **Identify which country won the most gold, most silver and most bronze medals in each Olympic Games.**

-- Window function? X
-- PIVOT? 




WITH gold AS( -- 1112 rows
SELECT
	Games,
	NOC,
	COUNT(Medal) num_gold
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Games, NOC
), silver AS( -- 1244 rows
SELECT
	Games,
	NOC,
	COUNT(Medal) num_silver
FROM athlete_events
WHERE Medal = 'Silver'
GROUP BY Games, NOC
), bronze AS( -- 1320 rows
SELECT 
	Games,
	NOC,
	COUNT(Medal) num_bronze
FROM athlete_events
WHERE Medal = 'Bronze'
GROUP BY Games, NOC
)
SELECT 
	ae.Games,
--	ae.NOC,
	g.num_gold AS 'num_gold'
--	s.num_silver AS 'num_silver',
--	b.num_bronze AS 'num_bronze'
FROM athlete_events ae
LEFT JOIN gold g ON ae.Games = g.Games
LEFT JOIN silver s ON ae.Games = s.Games
LEFT JOIN bronze b ON ae.Games = b.Games
GROUP BY ae.Games
ORDER BY 1;




WITH test AS(
SELECT 
	Games,
	NOC,
	MAX(num_gold) 'max_gold'
FROM(
SELECT
	Games,
	NOC,
	COUNT(Medal) num_gold
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Games, NOC
) gold
GROUP BY Games, NOC
)
SELECT 
	Games,
	NOC,
	MAX(max_gold)
FROM test
GROUP BY Games, NOC
ORDER BY 1, 3 DESC


SELECT 
	Games,
	NOC
--	MAX(num_gold) 'max_gold'
FROM(
SELECT
	Games,
	NOC,
	COUNT(Medal) num_gold
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Games, NOC
) g


WITH all_g AS(
SELECT
	Games,
	NOC,
	COUNT(Medal) num_gold
FROM athlete_events
WHERE Medal = 'Gold'
GROUP BY Games, NOC
), max_g AS(
SELECT
	Games,
	NOC,
	MAX(num_gold) max_gold
FROM all_g
GROUP BY Games, NOC
), gm_rank AS(
SELECT 
	*, 
	RANK() OVER (PARTITION BY max_gold ORDER BY Games) AS gmr
FROM max_g
) -- END
SELECT *
FROM gm_rank;


--17. **Identify which country won the most gold, most silver, most bronze medals and the most medals in each Olympic Games.**

--18. **Which countries have never won a gold medal but have won silver/bronze medals?**

SELECT TOP 1 * FROM athlete_events;

SELECT
	COUNT(DISTINCT(Team)),     -- 1184
	COUNT(DISTINCT(ae.NOC)),   -- 230
	COUNT(DISTINCT(nr.NOC))    -- 230
FROM athlete_events ae
JOIN noc_regions nr ON ae.NOC = nr.NOC;


WITH all_medal AS(
SELECT
	NOC,
	Medal
FROM athlete_events
), gold AS(
SELECT
	NOC,
	COUNT(Medal) 'gold'
FROM all_medal
WHERE Medal = 'Gold'
GROUP BY NOC
), silver AS(
SELECT
	NOC,
	COUNT(Medal) 'silver'
FROM all_medal
WHERE Medal = 'Silver'
GROUP BY NOC
), bronze AS(
SELECT
	NOC,
	COUNT(Medal) 'bronze'
FROM all_medal
WHERE Medal = 'Bronze'
GROUP BY NOC
)
SELECT 
	DISTINCT(am.NOC), 
	region,
	gold,
	silver,
	bronze
FROM all_medal am
JOIN noc_regions nr ON am.NOC = nr.NOC
LEFT JOIN gold g ON am.NOC = g.NOC
LEFT JOIN silver s ON am.NOC = s.NOC
LEFT JOIN bronze b ON am.NOC = b.NOC
WHERE gold IS NULL AND silver > 1 AND bronze > 1
ORDER BY 1;


--19. **In which Sport/event, India has won highest medals.**

SELECT *
FROM noc_regions
WHERE region = 'India';


WITH ind AS(
SELECT
	*
FROM athlete_events
WHERE NOC = 'IND' AND Medal <> 'NA'
), sp AS(
-- 345
SELECT
	NOC,
	Sport,
	COUNT(Medal) sp_medal
FROM ind
GROUP BY Sport, NOC
), ev AS(
-- 315
SELECT
	NOC,
	Event,
	COUNT(Medal) ev_medal
FROM athlete_events
GROUP BY Event, NOC
)
SELECT 
	TOP 1
	sp_medal sport_highest,
	ev_medal event_highest
FROM sp 
JOIN ev ON sp.NOC = ev.NOC
ORDER BY 1 DESC, 2 DESC;


--20. **Break down all Olympic Games where India won medals for Hockey and how many medals in each Olympic Games.**

SELECT
	Games,
	Sport
FROM athlete_events
WHERE NOC = 'IND' AND Sport = 'Hockey'
GROUP BY Games, Sport

SELECT
	Games,
	Sport,
	NOC,
	COUNT(Medal) num_medals
FROM athlete_events
WHERE NOC = 'IND' AND Sport = 'Hockey' AND Medal <> 'NA'
GROUP BY Games, Sport, NOC
ORDER BY 1;











