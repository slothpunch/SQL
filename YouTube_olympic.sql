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

WITH games_con AS(
SELECT
	Games,
	COUNT(DISTINCT(Team)) AS num_countries
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
FROM games_con

--5. *** Which nation has participated in all of the Olympic Games?

SELECT 
	Team,
	COUNT(DISTINCT(Games)) AS game_count
FROM athlete_events
GROUP BY Team
HAVING COUNT(DISTINCT(Games)) = (SELECT COUNT(DISTINCT(Games)) FROM athlete_events)

--6. **Identify the sport which was played in all summer Olympics.**

SELECT
	TOP 15 *
FROM athlete_events

SELECT 
	DISTINCT(Sport)
FROM athlete_events
WHERE Season = 'Summer'

-- OR

SELECT 
	Sport
FROM athlete_events
WHERE Season = 'Summer'
GROUP BY Sport

--7. **Which Sports were just played only once in the Olympics?**

SELECT
	Sport,
	COUNT(Sport) AS num_sport_played
FROM athlete_events
GROUP BY Sport
HAVING COUNT(Sport) = 1

--8. **Fetch the total no of sports played in each Olympic Games.**

SELECT
	Games,
	COUNT(Sport) AS num_sport_played
FROM athlete_events
GROUP BY Games
ORDER BY 1

--9. **Fetch details of the oldest athletes to win a gold medal.**

SELECT TOP 15 * FROM athlete_events

SELECT
	TOP 1 *
FROM athlete_events
WHERE Age <> 'NA' AND Medal = 'Gold'
ORDER BY Age DESC;

--10. **Find the ratio of male and female athletes who participated in all Olympic Games.**
-- Find the ratio of males and femals for each Olympic Game

-- Each game -> Count males and females

SELECT
	Games,
	COUNT(Games) AS num
FROM athlete_events
GROUP BY Games
ORDER BY Games;

WITH game AS(
SELECT
	Games
FROM athlete_events
GROUP BY Games
),
gender AS(
SELECT
	
FROM game

SELECT
	Games,
	


WITH num_male AS(
SELECT
	Sex,
	COUNT(Sex) as male_count
FROM athlete_events
WHERE Sex = 'M'
GROUP BY Sex
),
num_female AS(
SELECT
	Sex,
	COUNT(Sex) as female_count
FROM athlete_events
WHERE Sex = 'F'
GROUP BY Sex
)
SELECT
	CONCAT('Male',' ') AS hi
FROM athlete_events a
JOIN num_male m ON a.Sex = m.Sex
JOIN num_female f ON a.Sex = f.Sex



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









