use SQL_Assignment;
create proc sp_Calculator
@operand_1 int, @operand_2 int,@operation int,@result int output
As 
begin
	begin try 
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
		select @result as Result
	end try
	begin catch
		select ERROR_NUMBER() as ErrorNummber,
			   ERROR_MESSAGE() as ErrorMessage,
			   ERROR_STATE() as ErrorState,
			   ERROR_LINE()as ErrorLine,
			   ERROR_PROCEDURE() as ErrorProcedure
	end catch
end
Go

print '1 for addition'
print '2 for Subtraction'
print '3 for Multiplication'
print '4 for Divison'
print '5 for Modulus'
declare @result int

exec sp_Calculator 20,10,1,@result out
sp_Calculator 20,10,2,0
sp_Calculator 20,10,3,0
sp_Calculator 20,0,4,0
sp_Calculator 20,10,5,0
