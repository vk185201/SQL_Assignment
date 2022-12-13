use SQL_Assignment

--step-1 create a table
create table employee(
	emp_id int,
	emp_name nvarchar(50),
	emp_salary int
);

--STEP_2 creating user defined table type
create type employee as table(
	emp_id int ,
	emp_name nvarchar(50),
	emp_salary float
);

--step-3 using th userdefined table type as parameter in stored procedure
alter proc sp_insert_emp_data
@employee employee readonly
As 
declare @emp_id int,
		 @emp_name nvarchar(50),
		 @emp_salary float,
		 @count  int
	Begin 
		begin try
				select @emp_id=emp_id from employee
				select @emp_name =emp_name from employee
				select @emp_salary=emp_salary from employee
				set @count=( select count(*)  from employee where @emp_id=emp_id)

				if (@count>0)
					update employee set @emp_id=emp_id,@emp_name=emp_name,@emp_salary=emp_salary
				else
					insert into employee
					select * from @employee
		end try
		begin catch
			select ' enter valid record'
		end catch
	End

--step-4 declare table variable, insert the data rows and then pass tbale variable as parameter to stored procedures 
declare @employee employee

Insert into @employee values(1,'Mike John',45000)
exec sp_insert_emp_data @employee
Insert into @employee values(null,'Vimal',50000)
Insert into @employee values(null,'Raju',100000)
Insert into @employee values(4,'Priya',25000)
Insert into @employee values(5,'Tarun',15000)
Insert into @employee values(6,'Sruthi',59000)
exec sp_insert_emp_data @employee

select * from employee
