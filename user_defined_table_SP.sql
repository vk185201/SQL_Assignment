use SQL_Assignment

--step-1 create a table
create table employee(
emp_id int primary key,
	emp_name nvarchar(50),
	emp_salary int
);

--STEP_2 creating user defined table type
create type employee as table(
	emp_id int primary key,
	emp_name nvarchar(50),
	emp_salary int
);

--step-3 using th userdefined table type as parameter in stored procedure
create proc sp_insert_emp_data
@employee employee readonly
As 
Begin 
		insert into employee
		select * from @employee
End 

--step-4 declare table variable, insert the data rows and then pass tbale variable as parameter to stored procedures 
declare @employee employee

--Insert into @employee values(1,'Mike',30000)
Insert into @employee values(2,'Vimal',50000)
Insert into @employee values(3,'Raju',100000)
Insert into @employee values(4,'Priya',25000)
Insert into @employee values(5,'Tarun',15000)
Insert into @employee values(6,'Sruthi',59000)
exec sp_insert_emp_data @employee

select * from employee