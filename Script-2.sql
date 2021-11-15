--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

-- ������� 1: ������� name, class �� ��������, ���������� ����� 1920
--
select name, "class" from ships where launched > '1920'

-- ������� 2: ������� name, class �� ��������, ���������� ����� 1920, �� �� ������� 1942
--
select name, class from ships where launched > '1920' and launched  < '1942'

-- ������� 3: ����� ���������� �������� � ������ ������. ������� ���������� � class
--
select count("class"), ships."class" from ships group by ships."class" 

-- ������� 4: ��� ������� ��������, ������ ������ ������� �� ����� 16, ������� ����� � ������. (������� classes)
--
select "class" , country from classes where  bore >= '16'

-- ������� 5: ������� �������, ����������� � ��������� � �������� ��������� (������� Outcomes, North Atlantic). �����: ship.
--
select ship from outcomes where battle = 'North Atlantic' and result = 'sunk'

-- ������� 6: ������� �������� (ship) ���������� ������������ �������
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


-- ������� 7: ������� �������� ������� (ship) � ����� (class) ���������� ������������ �������
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


-- ������� 8: ������� ��� ����������� �������, � ������� ������ ������ �� ����� 16, � ������� ���������. �����: ship, class
--
select ships."name", ships."class" 
from outcomes outcomes
	join ships ships 
	on ships."name"  = outcomes.ship
	join classes classes
	on classes."class" = ships."class" 
where outcomes."result" = 'sunk' and bore >'14'

--��������
select * from ships
join outcomes
on ships."name" = outcomes.ship 

-- ������� 9: ������� ��� ������ ��������, ���������� ��� (������� classes, country = 'USA'). �����: class
--

select classes."class"  from classes where country = 'USA'


-- ������� 10: ������� ��� �������, ���������� ��� (������� classes & ships, country = 'USA'). �����: name, class

select ships."name", ships."class" from ships
join classes
on ships."class" = classes."class" 
where classes.country = 'USA'

-- ������� 20: ������� ������� ������ hd PC ������� �� ��� ��������������, ������� ��������� � ��������. �������: maker, ������� ������ HD.
select avg(hd) from pc pc
join product product 
on product.model = pc.model
where product.maker in (select product.maker from product
where product."type" = 'Printer') 

