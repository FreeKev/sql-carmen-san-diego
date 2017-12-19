-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.
world=# SELECT name, population FROM country WHERE region = 'Southern Europe' ORDER BY population ASC LIMIT 10;
             name              | population
-------------------------------+------------
 Holy See (Vatican City State) |       1000
 Gibraltar                     |      25000
 San Marino                    |      27000
 Andorra                       |      78000
 Malta                         |     380200
 Slovenia                      |    1987800
 Macedonia                     |    2024000
 Albania                       |    3401200
 Bosnia and Herzegovina        |    3972000
 Croatia                       |    4473000

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.
world=# SELECT * FROM country_language;
ERROR:  relation "country_language" does not exist
LINE 1: SELECT * FROM country_language;
                      ^
world=# SELECT * FROM countrylanguage;
world=# SELECT code FROM country WHERE name = 'Holy See (Vatican City State)';
 code
------
 VAT
(1 row)

world=# SELECT * FROM countrylanguage WHERE countrycode = 'VAT';
 countrycode | language | isofficial | percentage
-------------+----------+------------+------------
 VAT         | Italian  | t          |          0
(1 row)
-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.
world=# SELECT countrycode FROM countrylanguage WHERE language = 'Italian' AND percentage = 100;
 countrycode
-------------
 SMR
(1 row)

world=# SELECT * FROM country WHERE code = 'SMR';
 code |    name    | continent |     region      | surfacearea | indepyear | population | lifeexpectancy |  gnp   | gnpold | localname  | governmentform | headofstate | capital | code2
------+------------+-----------+-----------------+-------------+-----------+------------+----------------+--------+--------+------------+----------------+-------------+---------+-------
 SMR  | San Marino | Europe    | Southern Europe |          61 |       885 |      27000 |           81.1 | 510.00 |        | San Marino | Republic       |             |    3171 | SM

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.
 world=# SELECT * FROM city WHERE countrycode = 'SMR';
   id  |    name    | countrycode |     district      | population
 ------+------------+-------------+-------------------+------------
  3170 | Serravalle | SMR         | Serravalle/Dogano |       4802
  3171 | San Marino | SMR         | San Marino        |       2294
 (2 rows)

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!
world=# SELECT * FROM city WHERE name LIKE 'Serra%';
  id  |    name    | countrycode |     district      | population
------+------------+-------------+-------------------+------------
  265 | Serra      | BRA         | Esp�rito Santo    |     302666
 3170 | Serravalle | SMR         | Serravalle/Dogano |       4802
(2 rows)

world=# SELECT name FROM country WHERE code = 'BRA';
  name
--------
 Brazil
(1 row)

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
 -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
 -- follow right behind you!
 world=# SELECT * FROM country WHERE code = 'BRA';
  code |  name  |   continent   |    region     | surfacearea | indepyear | population | lifeexpectancy |    gnp    |  gnpold   | localname |  governmentform  |        headofstate        | capital | code2
 ------+--------+---------------+---------------+-------------+-----------+------------+----------------+-----------+-----------+-----------+------------------+---------------------------+---------+-------
  BRA  | Brazil | South America | South America |  8.5474e+06 |      1822 |  170115000 |           62.9 | 776739.00 | 804108.00 | Brasil    | Federal Republic | Fernando Henrique Cardoso |     211 | BR
 (1 row)

 SELECT capital FROM country WHERE name - 'Brazil';
211

world=# SELECT name FROM city WHERE id = '211';
   name
----------
 Bras�lia
(1 row)

world=# SELECT * FROM city WHERE id = '211';
 id  |   name   | countrycode |     district     | population
-----+----------+-------------+------------------+------------
 211 | Bras�lia | BRA         | Distrito Federal |    1969868
(1 row)

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
 -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
 -- landing dock.

-- Clue #8: Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our play date of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.
world=# SELECT name FROM city WHERE population = 91084;
     name
--------------
 Santa Monica
(1 row)

-- She's in ______Santa Monica______________________!
