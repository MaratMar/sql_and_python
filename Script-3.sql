--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--Корабли: Для каждого класса определите число кораблей этого класса, потопленных в сражениях. Вывести: класс и число потопленных кораблей.

select ships."class", count("class") from ships where ships."name" in (select ship from outcomes where outcomes."result" = 'sunk') group by ships."class" 

--task2
--Корабли: Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.

select min(ships.launched), "class" from ships group by "class" 

--task3
--Корабли: Для классов, имеющих потери в виде потопленных кораблей и не менее 3 кораблей в базе данных, вывести имя класса и число потопленных кораблей.

select ships."class", ships."name" as sunk_ship from ships
join outcomes
on outcomes.ship = ships."name" 
	where outcomes."result" = 'sunk' and ships."class" in 
	(with count_ships (count,class) as (select count("name"),"class" from ships group by "class")
	select "class" from count_ships 
		where count_ships.count >='3')


--task4
--Корабли: Найдите названия кораблей, имеющих наибольшее число орудий среди всех кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).

select ships."name" from ships
	where ships."class" in 
	(with max_adn_dis (maxnumguns,displacement ) as (SELECT max(numguns) AS MaxNumGuns, displacement FROM classes c1 group by displacement)	
		select classes."class" from max_adn_dis
		join classes
		on max_adn_dis.maxnumguns = classes.numguns and max_adn_dis.displacement = classes.displacement )	


--task5
--Компьютерная фирма: Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

select maker from product where model in (with speed_ram (minram, speed) as (SELECT min(ram) AS minram, speed FROM pc group by speed)	
			select  model from speed_ram 
			join pc
			on speed_ram.minram = pc.ram and speed_ram.speed = pc.speed where pc.speed in (SELECT max(speed) FROM pc group by model))
	


	
		
		
