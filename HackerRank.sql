
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


