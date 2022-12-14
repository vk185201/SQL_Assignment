USE [SQL_Assignment]
GO
/****** Object:  StoredProcedure [dbo].[ClearTempTable]    Script Date: 12/13/2022 3:04:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ClearTempTable]
(
	@StoreId INT,
	@TempTableName NVARCHAR(30),
	@Dobs NVARCHAR(300)
)

AS

BEGIN
	DECLARE	@DBName NVARCHAR(128),
			@ErrorMessage NVARCHAR(4000),
			@Proc NVARCHAR(50),
			@StoreIdColumnName NVARCHAR(50),
			@DobColumnName nvarchar(30),
			@SQL NVARCHAR(1000),
			@max_Deadlock_count int,
			@iteration int

		Set @iteration=0
		Set @max_Deadlock_count=5
	SET @Proc = ISNULL(OBJECT_NAME(@@PROCID), 'Null Proc')

	SELECT @DBName = DB_NAME()
		BEGIN TRY
		while(@iteration<=@max_Deadlock_count and ERROR_MESSAGE() is not null)
		Begin
			Set @iteration=@iteration+1

			IF (LOWER(@TempTableName) = 'temp_intmsgdt')
				BEGIN
					SET @StoreIdColumnName = 'StoreId'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_intmsg')
				BEGIN
					SET @StoreIdColumnName = 'StoreId'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_hstgndotherwages')
				BEGIN
					SET @StoreIdColumnName = 'StoreId'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_hstwageedit')
				BEGIN
					SET @StoreIdColumnName = 'StoreId'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_hstgndintmsg')
				BEGIN
					SET @StoreIdColumnName = 'StoreId'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_hstgeneralledgeractivity')
				BEGIN
					SET @StoreIdColumnName = 'UnitNumber'
					SET @DobColumnName = 'BatchDate'
				END
			ELSE IF (LOWER(@TempTableName) = 'temp_hstschedule')
					BEGIN
						SET @DobColumnName = 'ScheduleDate'
					END
			ELSE
				BEGIN
					SET @StoreIdColumnName = 'FKStoreId'
					SET @DobColumnName = 'DateOfBusiness'
				END
		
				SET @SQL = 'DELETE FROM [' + @TempTableName + '] WHERE [' + @StoreIdColumnName + '] = ' + CAST(@StoreId AS NVARCHAR(20)) +
							' AND [' + @DobColumnName + '] IN (' + @Dobs  + ')'
				EXEC (@SQL)
			Commit
		end
			END TRY
			BEGIN CATCH
			--is Deadlock occured
			if ERROR_NUMBER()=1205
				begin
					if(@iteration=@max_Deadlock_count)
						begin
							select 'Retry count is exceded'
						end 
					else
						begin
							SET @ErrorMessage = @Proc + ': Error: ' + ISNULL(ERROR_MESSAGE(), 'Null Error')   
							RAISERROR (@ErrorMessage, 16, 1);
						end
				end
			RollBack
			END CATCH
END
