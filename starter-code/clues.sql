-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.

SELECT name, region, population FROM country WHERE region = 'Southern Europe' ORDER BY population ASC LIMIT 1;

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.

SELECT code, name FROM country WHERE name LIKE '%Holy See%';
SELECT * FROM countrylanguage WHERE countrycode = 'VAT';

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.

SELECT * FROM countrylanguage WHERE language = 'Italian' AND percentage = 100;
SELECT name, region FROM country WHERE code = 'SMR';

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.

SELECT name, district, population FROM city WHERE countrycode = 'SMR' ORDER BY population;

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

SELECT name, countrycode FROM city WHERE name LIKE 'Serra%';
SELECT code, name, continent FROM country WHERE code = 'BRA' AND continent = 'South America';

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
 -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
 -- follow right behind you!

SELECT name, capital FROM country WHERE code = 'BRA';
SELECT name FROM city WHERE id = 211;

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
 -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
 -- landing dock.



-- Clue #8: Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our playdate of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.

SELECT name FROM city WHERE population = 91084;

-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.



-- She's in Santa Monica!



-- Bonus Questions

-- 1. List the distinct regions in the Country table.

SELECT DISTINCT region FROM country;

-- 2. How many countries are located in European regions?

SELECT COUNT(DISTINCT code) FROM country WHERE continent = 'Europe';

-- 3. Find the total population of all countries group by regions.

SELECT region, SUM(population) FROM country GROUP BY region;

-- 4. Use one query to answer the following 2 questions
   -- i.  Find the countries which have the most spoken languages used
   -- ii. Find the maximum number of languages you can use in one country

SELECT countrycode, COUNT(countrycode) FROM countrylanguage GROUP BY countrycode ORDER BY COUNT(countrycode) DESC LIMIT 10;

-- 5. Find all the Asia countries that went independent from 1940 to 1950. Order the result by the year of independence.

SELECT name, continent, indepyear FROM country WHERE continent = 'Asia' AND indepyear>1939 AND indepyear<1951 ORDER BY indepyear;

-- 6. Find all the countries that do not use English at all

SELECT DISTINCT countrycode FROM countrylanguage WHERE countrycode NOT IN (SELECT countrycode FROM countrylanguage WHERE language = 'English');
