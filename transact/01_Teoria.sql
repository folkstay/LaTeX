/*
Транзакция (англ. transaction)- группа последовательных операций
с базой данных, которые представляют собой логическую единицу работы с данными.
1. Режимы транзакций
В SQL SERNER  существует три режима транзакций(три способа работы с транзакциями):
	1) автофиксация (autocommit);
		DВ режиме автоматической фиксации модификация данных и любая инструкция DDL
		языка выполняется как транзакция, которая будет автоматически зафиксирвана,
		если инструкция выполнена без ошибок, в противном случае будет выполнен откат 	транзакции
	2) неявная транзакция (implicit transaction);
		При включенном режиме неявных трпнзакций, транзакция начинается автоматически при выполнении
		первой же инструкции DML или DDL либо инструкции SELECT. Все последующие инструкции DML, DDL 
		либо SELECT стану частью этой транзакции. В этом режиме для завершения транзакции необходиао
		вручную запустить команду 	COMMIT или ROLLBACK для завершения транзакции, 
		даже если единственной инструкцией будет инструкция SELECT.
		Переход в режим неявных транзакций
		SET IMPLICIT_TRANSACTIONS ON
	3) явная транзакция (explicit transaction);
		Явная транзакция выполняется, если для запуска транзакции явно указана команда BEGIN TRANSACTION (BEGIN TRAN).
		Тело транзакции может содержать команды DML и DDL, и завершается инструкцией COMMIT или ROLLBACK.
 2. Уровни и состояния транзакции
	@@TRANCOUNT - показывает уровень вложенности транзакций
	0 - неактивная транзакция
	>0 - активная и уровень вложенности.
	XACT_STATE() - сосотяние транзакции(нет информации об уровне вложенности)
	0 - неактивная транзакция
	1 - незафиксированная транзакция, которая может быть зафиксирована.
	-1 - указывает что имеется незафиксированная транзакция, которая не может быть зафиксирована из-за предшествующей 
		фатальной ошибки.
*/
--Отображение результатов выполнения инструкций BEGIN и COMMIT
PRINT @@TRANCOUNT  
--  The BEGIN TRAN statement will increment the  
--  transaction count by 1.  
BEGIN TRAN  
    PRINT @@TRANCOUNT  
    BEGIN TRAN  
        PRINT @@TRANCOUNT  
--  The COMMIT statement will decrement the transaction count by 1.  
    COMMIT  
    PRINT @@TRANCOUNT  
COMMIT  
PRINT @@TRANCOUNT 
--Отображение результатов выполнения инструкций BEGIN и ROLLBACK
PRINT @@TRANCOUNT  
--  The BEGIN TRAN statement will increment the  
--  transaction count by 1.  
BEGIN TRAN  
    PRINT @@TRANCOUNT  
    BEGIN TRAN  
        PRINT @@TRANCOUNT  
--  The ROLLBACK statement will clear the @@TRANCOUNT variable  
--  to 0 because all active transactions will be rolled back.  
ROLLBACK  
PRINT @@TRANCOUNT  
--Results  
--0  
--1  
--2  
--0

USE [Northwind] 
GO  
SELECT * From  Products  WHERE ProductID = 10
-- SET XACT_ABORT ON will render the transaction uncommittable  
-- when the constraint violation occurs.  
SET XACT_ABORT ON;  
  
BEGIN TRY  
    BEGIN TRANSACTION 
        -- A FOREIGN KEY constraint exists on this table. This   
        -- statement will generate a constraint violation error.  
        DELETE FROM Products  
            WHERE ProductID = 10;  
  
    -- If the delete operation succeeds, commit the transaction. The CATCH  
    -- block will not execute.  
    COMMIT TRANSACTION;  
END TRY  
BEGIN CATCH  
    -- Test XACT_STATE for 0, 1, or -1.  
    -- If 1, the transaction is committable.  
    -- If -1, the transaction is uncommittable and should   
    --     be rolled back.  
    -- XACT_STATE = 0 means there is no transaction and  
    --     a commit or rollback operation would generate an error.  
  
    -- Test whether the transaction is uncommittable.  
    IF (XACT_STATE()) = -1  
    BEGIN  
        PRINT 'The transaction is in an uncommittable state.' +  
              ' Rolling back transaction.'  
        ROLLBACK TRANSACTION;  
    END;  
  
    -- Test whether the transaction is active and valid.  
    IF (XACT_STATE()) = 1  
    BEGIN  
        PRINT 'The transaction is committable.' +   
              ' Committing transaction.'  
        COMMIT TRANSACTION;     
    END;  
END CATCH;  
GO  

-- Вложенные транзакции
--Что на самом деле делает commit?
/*
    Commit уменьшает значение @@TRANCOUNT на 1 всякий раз, когда выполняется. 
	Если значение @@TRANCOUNT больше 1, то реальное влияние произойдет, 
	когда @@TRANCOUNT станет 1. Это означает, что активное влияние фиксации будет иметь место для самой верхней транзакции.
	Активное влияние означает, что изменения станут постоянной частью базы данных, 
	а задействованные ресурсы (включая блокирование) освободятся.
*/
BEGIN TRANSACTION ParentTran;
SELECT * FROM sys.dm_tran_active_transactions WHERE name = 'ParentTran';
SELECT @@TRANCOUNT AS [ParentTran_Begin_TranCount];
BEGIN TRANSACTION ChildTran;
SELECT * FROM sys.dm_tran_active_transactions WHERE name = 'ChildTran';
SELECT @@TRANCOUNT AS [ChildTran_Begin_TranCount];
COMMIT TRANSACTION ChildTran;
SELECT @@TRANCOUNT AS [ChildTran_Commit_TranCount];
SELECT * FROM sys.dm_tran_active_transactions WHERE name IN ('ParentTran', 'ChildTran');
COMMIT TRANSACTION ParentTran
SELECT @@TRANCOUNT AS [ParentTran_Commit_TranCount];
SELECT * FROM sys.dm_tran_active_transactions WHERE name IN ('ParentTran', 'ChildTran');

--Может иметь место несколько операторов rollback, если есть несколько транзакций?
/*
Нет. Не может быть нескольких операторов отката. 
Вы можете иметь несколько операторов BEGIN TRANSACTION, но не может быть нескольких операторов ROLLBACK TRANSACTION.
Откат может быть только один. ROLLBACK TRANSACTION откатывает все активные транзакции в рамках родительской транзакции в сессии (SPID).
*/
BEGIN TRANSACTION ParentTran;
SELECT * FROM sys.dm_tran_active_transactions WHERE name = 'ParentTran';
SELECT @@TRANCOUNT AS [ParentTran_Begin_TranCount];
BEGIN TRANSACTION ChildTran;
SELECT * FROM sys.dm_tran_active_transactions WHERE name = 'ChildTran';
SELECT @@TRANCOUNT AS [ChildTran_Begin_TranCount];
ROLLBACK TRANSACTION ChildTran;
SELECT @@TRANCOUNT AS [ChildTran_Commit_TranCount];
SELECT * FROM sys.dm_tran_active_transactions WHERE name IN ('ParentTran', 'ChildTran');
ROLLBACK TRANSACTION ParentTran
SELECT @@TRANCOUNT AS [ParentTran_Commit_TranCount];
SELECT * FROM sys.dm_tran_active_transactions WHERE name IN ('ParentTran', 'ChildTran');

--пример отката с точкой сохранения. 
--Важный факт о транзакции. Табличные переменные и Identity не отменяются при откате.
DECLARE @Table	TABLE
(
	[ID]			INT
	, [Name]		VARCHAR(50)
);
BEGIN TRANSACTION ParentTran;
INSERT INTO @Table (ID, Name) VALUES (1, NULL);
SELECT @@TRANCOUNT AS [ParentTran_Begin_TranCount];
SELECT * FROM @Table;
SAVE TRANSACTION ChildTran;
UPDATE @Table SET NAME = 'ChildTran' WHERE ID = 1;
SELECT @@TRANCOUNT AS [ChildTran_Begin_TranCount];
SELECT * FROM @Table;
ROLLBACK TRANSACTION ChildTran;
SELECT @@TRANCOUNT AS [ChildTran_Commit_TranCount];
SELECT * FROM @Table;
ROLLBACK TRANSACTION ParentTran;
SELECT @@TRANCOUNT AS [ParentTran_Commit_TranCount];
SELECT * FROM @Table;

--Расширим рассмотренный ранее пример, но вместо табличной переменной будем использовать временную таблицу.
DROP TABLE IF EXISTS #Table;
CREATE TABLE #Table
(
	[ID]			INT
	, [Name]		VARCHAR(50)
);
BEGIN TRANSACTION ParentTran;
INSERT INTO #Table (ID, Name) VALUES (1, NULL);
SELECT @@TRANCOUNT AS [ParentTran_Begin_TranCount];
SELECT * FROM #Table;
SAVE TRANSACTION ChildTran;
UPDATE #Table SET NAME = 'ChildTran' WHERE ID = 1;
SELECT @@TRANCOUNT AS [ChildTran_Begin_TranCount];
SELECT * FROM #Table;
ROLLBACK TRANSACTION ChildTran;
SELECT @@TRANCOUNT AS [ChildTran_Commit_TranCount];
SELECT * FROM #Table;
ROLLBACK TRANSACTION ParentTran;
SELECT @@TRANCOUNT AS [ParentTran_Commit_TranCount];
SELECT * FROM #Table;