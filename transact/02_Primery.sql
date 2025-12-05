Use [2024_KB_1]
select * from sys.objects where type='U'
print OBJECT_ID(N'Счета','U')
IF OBJECT_ID(N'Счета','U') IS NOT NULL
	DROP TABLE [Счета];
GO
CREATE TABLE [Счета](
	[Код счета] INT IDENTITY PRIMARY KEY,
	[Номер счета] NVARCHAR(13),
	[Владелец] NVARCHAR(50),
	[Баланс] MONEY DEFAULT(0),
	CONSTRAINT [Баланс не может быть отрицательным] CHECK ([Баланс]>=0)
 );
 GO
 -- Удаление записей в таблице
 TRUNCATE TABLE [Счета]
 GO
 -- Удаление записей в таблице
 DELETE FROM  [Счета]
 GO
 --Добавление строк в таблицу
 INSERT INTO  [Счета]([Номер счета], [Владелец], [Баланс])
 VALUES ('1111111111111',N'Иванов',1000),
		('2222222222222',N'Петров',0)
GO

SELECT * FROM [Счета]