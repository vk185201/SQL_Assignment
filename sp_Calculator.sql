use SQL_Assignment;
create proc sp_Calculator
@operand_1 int, @operand_2 int,@operation int,@result int output
As 
begin
	if(@operation=1) 
		set @result=@operand_1+@operand_2
	else if(@operation=2)
		set @result=@operand_1-@operand_2
	else if (@operation=3)
		set @result=@operand_1*@operand_2
	else if (@operation=4)
		set @result=@operand_1/@operand_2
	else 
		set @result=@operand_1%@operand_2
end
select @result as Result
Go

print '1 for addition'
print '2 for Subtraction'
print '3 for Multiplication'
print '4 for Divison'
print '5 for Modulus'
exec sp_Calculator 20,10,1,0
sp_Calculator 20,10,2,0
sp_Calculator 20,10,3,0
sp_Calculator 20,10,4,0
sp_Calculator 20,10,5,0
