--REAPEATABLE READ

SET NOCOUNT ON;
--Читаем недотвержденные(незафиксированные) данные
SET TRANSACTION ISOLATION LEVEL  REPEATABLE READ;

BEGIN TRANSACTION

SELECT * FROM [Счета]

commit