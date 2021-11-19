--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� (pc, printer, laptop). �������: model, maker, type
select pc.model, product.maker, product."type" from product
join pc
on product.model = pc.model 
union all 
select printer.model, product.maker, product."type" from product
join printer 
on product.model = printer.model 
union all 
select laptop.model, product.maker, product."type" from product
join laptop
on product.model = laptop.model 


--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *, 
case
	when price > (select avg(price) from PC) then 1
	else 0
end avg_price
from printer p 


--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select * from ships where "class" is null

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� �� � ����� �� ����� ������ �������� �� ����.
with battles_year as (
select name, extract(year from date) as year
from battles
)
select *
from battles_year
where year not in (select launched from ships)



--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

with Kongo as (select * from ships
join outcomes
on ships."name" = outcomes.ship 
where ships."class" = 'Kongo')
select battle from Kongo


--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. �� view ��� �������: model, price, flag
create view all_products_flag_300 as 
select *,
case when price > 300 then 1
else 0
end flag
from (select pc.model, pc.price from product
join pc
on product.model = pc.model 
union all 
select printer.model, printer.price from product
join printer 
on product.model = printer.model 
union all 
select laptop.model, laptop.price from product
join laptop
on product.model = laptop.model) all_pro

select * from all_products_flag_300

--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������ . �� view ��� �������: model, price, flag


create view all_products_flag_avg_price as 
select *,
case when price > (with all_pro as (
		select pc.model, pc.price from product
		join pc
		on product.model = pc.model 
		union all 
		select printer.model, printer.price from product
		join printer 
		on product.model = printer.model 
		union all 
		select laptop.model, laptop.price from product
		join laptop
		on product.model = laptop.model)
		select avg(price) from all_pro) then 1
else 0
end flag
from (	select pc.model, pc.price from product
		join pc
		on product.model = pc.model 
		union all 
		select printer.model, printer.price from product
		join printer 
		on product.model = printer.model 
		union all 
		select laptop.model, laptop.price from product
		join laptop
		on product.model = laptop.model) a 

select * from all_products_flag_avg_price

--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
select model,maker from (select printer.model, printer.price, product."maker" from product
join printer 
on product.model = printer.model) a where price > (select avg(price) from product
join printer 
on product.model = printer.model where product."maker" = 'D' or product."maker" = 'C') and maker = 'A'


--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
select distinct model from (select printer.model, printer.price, product."maker" from product
					join printer 
					on product.model = printer.model
					union all
					select pc.model, pc.price, product."maker" from product
					join pc 
					on product.model = pc.model
					union all
					select laptop.model, laptop.price, product."maker" from product
					join laptop 
					on laptop.model = laptop.model) a 
where price > (with avg_price as (select printer.price from product
					join printer 
					on product.model = printer.model
					union all
					select pc.price from product
					join pc 
					on product.model = pc.model
					union all
					select laptop.price from product
					join laptop 
					on laptop.model = laptop.model where product."maker" = 'D' or product."maker" = 'C')
					select avg(price) from avg_price) and maker = 'A'

--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
select distinct model, avg(price), "type" from (select printer.model, printer.price, product."maker",product."type" from product
					join printer 
					on product.model = printer.model
					union all
					select pc.model, pc.price, product."maker",product."type" from product
					join pc 
					on product.model = pc.model
					union all
					select laptop.model, laptop.price, product."maker",product."type" from product
					join laptop 
					on laptop.model = laptop.model
					where product."maker" = 'A') a group by model, "type" order by "type"

--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) �� ������� �������������. �� view: maker, count
create view count_products_by_makers as 
with count_maker as (select printer.model,  product."maker" from product
join printer 
on product.model = printer.model
union all
select pc.model,  product."maker" from product
join pc 
on product.model = pc.model
union all
select laptop.model,  product."maker" from product
join laptop 
on laptop.model = laptop.model)
select maker, count(model) from count_maker group by maker 

select * from count_products_by_makers
					
--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

cursor.execute('select * from count_products_by_makers')
df = pd.DataFrame(cursor, columns=['maker','count'])
plt.bar(df.maker, df['count'])
plt.show()

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) � ������� �� ��� ��� �������� ������������� 'D'
create table printer_updated as 
select * from printer where model not in (select printer.model from printer
	join product
	on printer.model = product.model where product.maker = 'D')
	
	select * from printer_updated
--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� �������� ������������� (�������� printer_updated_with_makers)
create view printer_updated_with_makers as 
	select printer_updated.code,
		printer_updated.model,
		printer_updated.color,
		printer_updated."type",
		printer_updated.price,
		product.maker from printer_updated
	join product
	on printer_updated.model = product.model 

select * from printer_updated_with_makers	
--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes). �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)
create view sunk_ships_by_classes as 
select count(result), ships."class" from outcomes
join ships
on ships."name" = outcomes.ship where outcomes."result" = 'sunk'
group by ships."class" 

select * from sunk_ships_by_classes

select *,
case when ships."class" is null then 0
end flg
from outcomes
join ships
on ships."name" = outcomes.ship where outcomes."result" = 'sunk'

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

cursor.execute('select * from sunk_ships_by_classes')
df = pd.DataFrame(cursor, columns=['count','class'])
plt.bar(df['class'], df['count'])
plt.show()

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� ������ ������ ��� ����� 9 - �� 1, ����� 0

create view classes_with_flag as 
select *,
case when numguns >= '9' then 1
	else 0
end count_fung
from classes

select * from classes_with_flag

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

cursor.execute('select count(class), country from classes group by country')
df = pd.DataFrame(cursor, columns=['count','country'])
plt.bar(df['country'], df['count'])
plt.show()

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select count(ships."name")  from ships where ships."name" like 'O%' or  ships."name" like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count("name") from ships where name like '% %'
--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)

cursor.execute('select count(launched), launched from ships group by launched ')
df = pd.DataFrame(cursor, columns=['count','country'])
plt.bar(df['country'], df['count'])
plt.show()

