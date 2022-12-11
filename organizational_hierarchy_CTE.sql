use SQL_Assignment

create table Employees(
	emp_id int,
	emp_name nvarchar(50),
	manager_id int
);

Insert into Employees values(1,'Sruthi',5)
Insert into Employees values(2,'Mark',8)
Insert into Employees values(3,'John',8)
Insert into Employees values(4,'Peter',3)
Insert into Employees values(5,'Priya',8)
Insert into Employees values(6,'Mike',2)
Insert into Employees values(7,'Arya',4)
Insert into Employees values(8,'Raju',null)
Insert into Employees values(9,'Lasya',2)
Insert into Employees values(10,'Jira',5)

select * from Employees


--with CTE get organizational hierarchy

Declare @empid int;
set @empid=7;

with cte_Employee as(
	select emp_id,emp_name,manager_id 
	from Employees
	where emp_id=@empid

	union all
	 select e.emp_id,e.emp_name,e.manager_id
	 from Employees e
	 join cte_Employee c
	 on e.emp_id=c.manager_id

)

--select * from cte_Employee

--display only emp_name and his manager_name

select e1.emp_name as Employee_name,isnull(e2.emp_name,'no boss') as Manager_name
from cte_Employee e1
left join cte_Employee e2
on e1.emp_id=e2.manager_id