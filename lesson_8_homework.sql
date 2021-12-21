--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

SELECT a.Department, a.Employee, a.Salary FROM
(
	Select Department.Name as Department, E.Name as Employee, E.salary As Salary,
	DENSE_RANK() over (PARTITION BY Department.Name ORDER BY E.Salary DESC)  as D_RANK
	from Employee E
	INNER JOIN Department ON E.DepartmentId = Department.Id 
) a
where a.D_RANK <=3


--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17
SELECT member_name, status, SUM(Payments.unit_price * Payments.amount) AS costs  from FamilyMembers
JOIN Payments 
on Payments.family_member = FamilyMembers.member_id
WHERE Payments.date LIKE '2005%'
GROUP BY FamilyMembers.member_name, FamilyMembers.status

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name from 
(
    SELECT name, COUNT(name) as cname FROM Passenger GROUP by name
) a 
where cname > 1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count from (SELECT first_name, COUNT(first_name) as count  from Student GROUP by first_name) a 
where first_name like "Anna"

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT COUNT(classroom) as count from Schedule where date like '2019-09-02%'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38
select count from (SELECT first_name, COUNT(first_name) as count  from Student GROUP by first_name) a 
where first_name like "Anna"

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

SELECT FLOOR(AVG('2021' - YEAR(birthday))) as age from FamilyMembers  

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

SELECT GoodTypes.good_type_name, sum(Payments.amount * Payments.unit_price) as costs from GoodTypes
JOIN Goods on GoodTypes.good_type_id = Goods.type
JOIN Payments on Payments.good = Goods.good_id
where YEAR(Payments.date) = '2005'
GROUP by GoodTypes.good_type_id

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

SELECT '2021' - birthday as year  from 
(
	SELECT max(YEAR(birthday)) as birthday  from Student
)a

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

SELECT MAX('2021' - YEAR(birthday)) as max_year from Class
	JOIN Student_in_class on Class.id = Student_in_class.class
	JOIN Student on Student_in_class.student = Student.id
where Class.name LIKE "10%"

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

SELECT status, member_name, (amount * unit_price) as costs from FamilyMembers
	join Payments on FamilyMembers.member_id = Payments.family_member
	JOIN Goods on Goods.good_id = Payments.good
	JOIN GoodTypes on GoodTypes.good_type_id = Goods.type
where GoodTypes.good_type_name = 'entertainment'

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company 
WHERE id in (
	select Company  from (SELECT COUNT(id) as COU, Company from Trip GROUP BY Company) a
		WHERE COU = (SELECT min(COU) from 
						(SELECT COUNT(id) as COU, Company from Trip GROUP BY Company) b)
	)

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

SELECT classroom from (SELECT COUNT(classroom) as classB, classroom from Schedule GROUP by classroom) b
WHERE classB = (select MAX(cla) from (SELECT COUNT(classroom) as cla from Schedule GROUP by classroom) a)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

SELECT Teacher.last_name from Teacher
JOIN Schedule on Teacher.id = Schedule.teacher
JOIN Subject on Subject.id = Schedule.subject
WHERE Subject.name = 'Physical Culture'
ORDER by Teacher.last_name

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

SELECT CONCAT(last_name,'.', 
                SUBSTRING(first_name, 1, 1), '.',
                SUBSTRING(middle_name, 1, 1), '.') as name from Student
ORDER BY name asc
