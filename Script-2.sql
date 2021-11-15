--схема БД: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
--
select name, "class" from ships where launched > '1920'

-- Çàäàíèå 2: Âûâåñòè name, class ïî êîðàáëÿì, âûïóùåííûì ïîñëå 1920, íî íå ïîçäíåå 1942
--
select name, class from ships where launched > '1920' and launched  < '1942'

-- Çàäàíèå 3: Êàêîå êîëè÷åñòâî êîðàáëåé â êàæäîì êëàññå. Âûâåñòè êîëè÷åñòâî è class
--
select count("class"), ships."class" from ships group by ships."class" 

-- Çàäàíèå 4: Äëÿ êëàññîâ êîðàáëåé, êàëèáð îðóäèé êîòîðûõ íå ìåíåå 16, óêàæèòå êëàññ è ñòðàíó. (òàáëèöà classes)
--
select "class" , country from classes where  bore >= '16'

-- Çàäàíèå 5: Óêàæèòå êîðàáëè, ïîòîïëåííûå â ñðàæåíèÿõ â Ñåâåðíîé Àòëàíòèêå (òàáëèöà Outcomes, North Atlantic). Âûâîä: ship.
--
select ship from outcomes where battle = 'North Atlantic' and result = 'sunk'

-- Çàäàíèå 6: Âûâåñòè íàçâàíèå (ship) ïîñëåäíåãî ïîòîïëåííîãî êîðàáëÿ
--
select ship from battles 
join outcomes
on battles."name" = outcomes.battle 
where "date" in (
	select max(date) from battles 
	join outcomes
	on battles."name" = outcomes.battle 
	where result = 'sunk') 
and result = 'sunk'


-- Çàäàíèå 7: Âûâåñòè íàçâàíèå êîðàáëÿ (ship) è êëàññ (class) ïîñëåäíåãî ïîòîïëåííîãî êîðàáëÿ
--
select "name", "class" 
from ships
where "name" 
in  (select ship from battles 
		join outcomes
		on battles."name" = outcomes.battle where "date" in (select max(date) from battles 
		join outcomes
		on battles."name" = outcomes.battle 
		where result = 'sunk') 
and result = 'sunk')


-- Çàäàíèå 8: Âûâåñòè âñå ïîòîïëåííûå êîðàáëè, ó êîòîðûõ êàëèáð îðóäèé íå ìåíåå 16, è êîòîðûå ïîòîïëåíû. Âûâîä: ship, class
--
select ships."name", ships."class" 
from outcomes outcomes
	join ships ships 
	on ships."name"  = outcomes.ship
	join classes classes
	on classes."class" = ships."class" 
where outcomes."result" = 'sunk' and bore >'14'

--Ïðîâåðêà
select * from ships
join outcomes
on ships."name" = outcomes.ship 

-- Çàäàíèå 9: Âûâåñòè âñå êëàññû êîðàáëåé, âûïóùåííûå ÑØÀ (òàáëèöà classes, country = 'USA'). Âûâîä: class
--

select classes."class"  from classes where country = 'USA'


-- Çàäàíèå 10: Âûâåñòè âñå êîðàáëè, âûïóùåííûå ÑØÀ (òàáëèöà classes & ships, country = 'USA'). Âûâîä: name, class

select ships."name", ships."class" from ships
join classes
on ships."class" = classes."class" 
where classes.country = 'USA'

-- Çàäàíèå 20: Íàéäèòå ñðåäíèé ðàçìåð hd PC êàæäîãî èç òåõ ïðîèçâîäèòåëåé, êîòîðûå âûïóñêàþò è ïðèíòåðû. Âûâåñòè: maker, ñðåäíèé ðàçìåð HD.
select avg(hd) from pc pc
join product product 
on product.model = pc.model
where product.maker in (select product.maker from product
where product."type" = 'Printer') 

