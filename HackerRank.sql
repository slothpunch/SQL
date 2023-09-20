
-- ############################################################
-- Q name: Weather Observation Station 6
-- Diff: Easy 
-- Date: 27 July 2023
-- ########################

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
-- Your result cannot contain duplicates.

SELECT DISTINCT city 
FROM station 
WHERE LOWER(city) LIKE 'a%'
OR LOWER(city) LIKE 'e%'
OR LOWER(city) LIKE 'i%'
OR LOWER(city) LIKE 'o%'
OR LOWER(city) LIKE 'u%';

select distinct city from station where left(city,1) in ('A', 'E', 'I', 'O', 'U') order by city;
select city from station where city like "[aeiou]%";


-- ############################################################
-- Q name: Weather Observation Station 7
-- Diff: Easy 
-- Date: 27 July 2023
-- ########################

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. 
-- Your result cannot contain duplicates.

SELECT DISTINCT city
FROM STATION
WHERE LOWER(city) LIKE '%[aeiou]';


-- ############################################################
-- Q name: Higher Than 75 Marks
-- Diff: Easy 
-- Date: 27 July 2023
-- ########################

-- Query the Name of any student in STUDENTS who scored higher than  Marks. 
-- Order your output by the last three characters of each name. 
-- If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

SELECT name
FROM STUDENTS
WHERE marks > 75
ORDER BY RIGHT(name, 3), id;


-- ############################################################
-- Q name: Type of Triangle
-- Diff: Easy 
-- Date: 27 July 2023
-- ########################

-- Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.

SELECT 
CASE 
    WHEN (A+B > C) AND (A+C > B) AND (B+C > A) THEN 
        CASE 
            WHEN (A = B) AND (B = C) THEN 'Equilateral'
            WHEN (A = B) OR (B = C) OR (A = C) THEN 'Isosceles'
            ELSE 'Scalene'
            END
        ELSE 'Not A Triangle'
    END 'Triangles'
FROM triangles


-- ############################################################
-- Q name: The Blunder
-- Diff: Easy 
-- Date: 31 July 2023
-- ########################

-- AVG(CAST (Salary AS DECIMAL)) -> 4046.750000
-- AVG(CAST(REPLACE(Salary ,'0','') AS DECIMAL)) -> 1794.500000
-- 2252.250000
SELECT CEILING (AVG(CAST (Salary AS DECIMAL) - CAST(REPLACE(Salary ,'0','') AS DECIMAL)))
FROM EMPLOYEES;


-- ############################################################
-- Q name: Top Earners
-- Diff: Easy 
-- Date: 01 August 2023
-- ########################

SELECT months * salary, COUNT(*)
FROM Employee
WHERE months * salary = (SELECT MAX(months * salary) FROM Employee)
GROUP BY months * salary 

-- ############################################################
-- Q name: Draw The Triangle 1
-- Diff: Easy 
-- Date: 02 August 2023
-- ########################

DECLARE @Pattern INT
SET @Pattern = 20
WHILE (@Pattern > 0 )
BEGIN
    -- PRINT REPLICATE('*'+space(), @Pattern)
    PRINT REPLICATE('*'+' ', @Pattern)
    SET @Pattern = @Pattern - 1
END

-- ############################################################
-- Q name: Draw The Triangle 2
-- Diff: Easy 
-- Date: 03 August 2023
-- ########################

DECLARE @Pattern int
SET @Pattern = 1
WHILE (@Pattern < 21)
BEGIN
    PRINT REPLICATE('*'+space(1), @Pattern)
    SET @Pattern = @Pattern + 1
END


-- ############################################################
-- Q name: Weather Observation Station 18
-- Diff: Medium 
-- Date: 07 August 2023
-- ########################

SELECT ROUND(ABS(MAX(LAT_N)-MIN(LAT_N)) + ABS(MAX(LONG_W)-MIN(LONG_W)),4)
FROM STATION



-- ############################################################
-- Q name: Weather Observation Station 19 --> Something wrong with the question
-- Diff: Medium 
-- Date: 07 August 2023
-- ########################

SELECT 
    CAST(
        SQRT(
            POWER(MIN(LONG_W) - MIN(LAT_N), 2)
            + POWER(MAX(LONG_W) - MAX(LAT_N), 2)
        ) 
        AS NUMERIC(20, 4)
        )
FROM STATION

-- ############################################################
-- Q name: New Companies
-- Diff: Medium 
-- Date: 14 August 2023
-- ########################

SELECT 
    c.company_code, 
    founder, 
    COUNT(DISTINCT lm.lead_manager_code),
    COUNT(DISTINCT sm.senior_manager_code),
    COUNT(DISTINCT m.manager_code),
    COUNT(DISTINCT e.employee_code)
FROM company c
JOIN lead_manager lm ON c.company_code = lm.company_code
JOIN senior_manager sm ON lm.lead_manager_code = sm.lead_manager_code
JOIN manager m ON sm.senior_manager_code = m.senior_manager_code
JOIN employee e ON m.manager_code = e.manager_code
GROUP BY c.company_code, founder
ORDER BY c.company_code
;


-- ############################################################
-- Q name: Ollivander's Inventory
-- Diff: Medium 
-- Date: 11 September 2023
-- ########################

WITH c1 AS(
    SELECT id, age, coins_needed, power, ROW_NUMBER() OVER(PARTITION BY power, age ORDER BY power DESC, age DESC, coins_needed ASC) ranking
    FROM wands w
    JOIN wands_property wp ON w.code = wp.code
    WHERE is_evil = 0
)

SELECT id, age, coins_needed, power
FROM c1
WHERE ranking = 1
ORDER BY power DESC, age DESC, coins_needed ASC
;

-- ############################################################
-- Q name: Retention Rate
-- Diff: Hard 
-- Date: 20 September 2023
-- ########################

-- Dec 2020
WITH dec AS(
    SELECT *
    FROM sf_events
    WHERE date BETWEEN '2020-12-01' AND '2020-12-31'
), dec_rate AS(
    SELECT account_id, CAST(COUNT(account_id) AS DECIMAL) / (SELECT COUNT(*) FROM dec) * 100 retention_rate
    FROM dec
    GROUP BY account_id
)
SELECT * FROM dec_rate
-- SELECT * FROM dec
-- SELECT *
-- FROM sf_events
-- WHERE date >= '2021-01-01'


;
