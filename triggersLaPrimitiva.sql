/*

Implementar restricciones
Mediante restricciones check y triggers, asegurate de que se cumplen las siguientes reglas
•	No se puede insertar un boleto si queda menos de una hora para el sorteo. Tampoco para sorteos que ya hayan tenido lugar	TRIGGER
•	Una vez insertado un boleto, no se pueden modificar sus números	TRIGGER
•	Todos los números están comprendido entre 1 y 49	CHECK
•	En las apuestas no se repiten números	TRIGGER
•	Las apuestas sencillas tienen seis números VER TABLA
•	Las apuestas múltiples tienen5, 7, 8, 9, 10 u 11 números VER TABLA


*/

--USE LaPrimitiva
GO


--•	No se puede insertar un boleto si queda menos de una hora para el sorteo. Tampoco para sorteos que ya hayan tenido lugar
GO
CREATE TRIGGER InsertarBoletoFecha ON Boletos AFTER INSERT AS
BEGIN
	DECLARE @fechaSorteo as smalldatetime = (select fecha from Sorteos as S 
											inner join inserted as B on S.idSorteo = B.idSorteo)
							 

	IF (DATEDIFF(hour,CURRENT_TIMESTAMP,@fechaSorteo )<=1 OR (CURRENT_TIMESTAMP>@fechaSorteo))
		ROLLBACK
		Print 'No se pueden insertar boletos con menos de una hora de antelacion o para sorteos ya realizados'
	-- ELSE no hace falta, xq insert es autocommit
		
END
GO

--•	Una vez insertado un boleto, no se pueden modificar sus números

GO
CREATE TRIGGER ModificarBoleto ON Boletos AFTER UPDATE AS
BEGIN
		ROLLBACK
		Print 'No se pueden modificar los boletos ya insertados'
		
END
GO

--•	En las apuestas no se repiten números
GO
CREATE TRIGGER NumeroRepetido ON BoletoSimples AFTER INSERT AS
BEGIN
		DECLARE @num1 as int
		DECLARE @num2 as int
		DECLARE @num3 as int
		DECLARE @num4 as int
		DECLARE @num5 as int
		DECLARE @num6 as int

		select num1=@num1, num2=@num2, num3=@num3, num4=@num4, num5=@num5, num6=@num6 from inserted

		IF((@num1=@num2) or (@num1=@num3) or (@num1=@num4) or (@num1=@num5) or (@num1=@num6) or
			(@num2=@num3) or (@num2=@num4) or (@num2=@num5) or (@num2=@num6) or
			(@num3=@num4) or (@num3=@num5) or (@num3=@num6) or 
			(@num4=@num5) or (@num4=@num6) or
			(@num5=@num6))
			begin
				ROLLBACK
				Print 'Has introducido un número repetido'
			end


		
END
GO

