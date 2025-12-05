--Надежность (устойчивость)
SET NOCOUNT ON

SELECT * FROM [Счета]

BEGIN TRANSACTION
UPDATE [Счета]
SET [Баланс]-=500
WHERE [Владелец]=N'Иванов'

SELECT * FROM [Счета]

UPDATE [Счета]
SET [Баланс]+=500
WHERE [Владелец]=N'Петров'

--Фиксируем транзакцию
COMMIT TRANSACTION
Print N'До остановки SQL Server'
SHUTDOWN WITH NOWAIT
print N'Возможно после остановки SQL SERVER?'
--Запуск
--1) WIN+R
--2) в окне run services.msc
--3) запуск службы (MSSQLSERVER)

SELECT * FROM [Счета]