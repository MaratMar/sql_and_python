--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1  (lesson7)
-- sqlite3: Сделать тестовый проект с БД (sqlite3, project name: task1_7). В таблицу table1 записать 1000 строк с случайными значениями (3 колонки, тип int) от 0 до 1000.
-- Далее построить гистаграмму распределения этих трех колонко

--task2  (lesson7)
-- oracle: https://leetcode.com/problems/duplicate-emails/

/* Write your PL/SQL query statement below */
select email from (select email, count(email) as cou from Person group by email) where cou > 1

--task3  (lesson7)
-- oracle: https://leetcode.com/problems/employees-earning-more-than-their-managers/

select E.name from Employee E
join Employee M
on E.managerId = M.id
where E.salary > M.salary

--task4  (lesson7)
-- oracle: https://leetcode.com/problems/rank-scores/

select score,
DENSE_RANK() over(order by score desc)
from Scores
--task5  (lesson7)
-- oracle: https://leetcode.com/problems/combine-two-tables/


select firstName, firstName,city, state  from Person 
left join Address
on Person.personId = Address.personId 