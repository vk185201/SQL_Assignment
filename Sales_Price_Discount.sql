--Create database
create database SQL_Assignment
use  SQL_Assignment;
--Creating the Sales_Table
Create table ITEM_SALES(
Item_Id int,
F_Name varchar(50),
Sales_Date date,
Sales_Price int
);
--Insert the data into sales table
Insert into ITEM_SALES values (1,'Apple','2022-12-10',50);
Insert into ITEM_SALES values (1,'Apple','2022-11-1',50);
Insert into ITEM_SALES values (2,'Pear','2022-12-31',100);
Insert into ITEM_SALES values (2,'Pear','2022-12-03',100);
Insert into ITEM_SALES values (3,'Grapes','2022-03-03',200);

--select * from ITEM_SALES
--Creating the Discount_Table
create table ITEM_DISCOUNT(
ITEM_ID INT,
F_Name varchar(50),
discount_price int,
Date_From date,
Date_To date

);
--Insert the data into discount table
Insert into ITEM_DISCOUNT values (1,'Apple',10,'2022-12-01','2022-12-31');
Insert into ITEM_DISCOUNT values (2,'Pear',20,'2022-12-01','2022-12-05');

--Select * from ITEM_DISCOUNT

--Query to get overall price of item after discount if applicable
Select i.Item_Id,i.F_Name,i.Sales_Date ,
Case 
	when i.Sales_Date between d.Date_From and d.Date_To then i.Sales_Price -d.discount_price
	else i.Sales_Price
end as overall_price

from ITEM_SALES i 
left join 
ITEM_DISCOUNT d on i.Item_Id=d.ITEM_ID





