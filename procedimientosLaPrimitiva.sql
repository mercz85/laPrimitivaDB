/*	Lotería primitiva

Programación parte 1
•	Implementa un procedimiento almacenado GrabaSencilla que grabe una apuesta simple. Datos de entrada: El sorteo y los seis números
•	Implementa un procedimiento GrabaMuchasSencillas que genere n boletos con una apuesta sencilla utilizando el procedimiento GrabaSencilla. Datos de entrada: El sorteo y el valor de n
•	Implementa un procedimiento almacenado GrabaMultiple que grabe una apuesta simple. Datos de entrada: El sorteo y entre 5 y 11 números




-- Para números enteros
SELECT ROUND(((20 - 1) * RAND() + 1), 0)
 
-- Para números decimales
SELECT ROUND(((20 - 1) * RAND() + 1), 4)


*/


-- 1)GrabaSencilla que grabe una apuesta simple. Datos de entrada: El sorteo y los seis números

--USE  laPrimitiva

GO
CREATE PROCEDURE GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
AS
BEGIN
	INSERT INTO Boletos (idSorteo, reintegro)
	select idSorteo, reintegro from Sorteos
	where idSorteo = @idSorteo

	DECLARE @idBoleto as int = (select top 1 idBoleto  from Boletos where idSorteo=@idSorteo ORDER BY idBoleto DESC )

	INSERT INTO BoletoSimples (idBoletoS,num1, num2, num3, num4, num5,num6)
	values (@idBoleto,@num1,@num2,@num3,@num4,@num5,@num6)
END
GO


--FUNCIONES COMPLEMENTARIAS
-- Funcion que devuelve n numeros aleatorios
GO
CREATE FUNCTION NumsAleatorios @cantidad int
AS
BEGIN
	DECLARE @cont as int =0

	WHILE @cont<@cantidad
		BEGIN

				SELECT ROUND(((49 - 1) * RAND() + 1), 0)

				PRINT 'Introducida apuesta'+ CAST (@cont as varchar)
				SET @cont = @cont + 1;
		END
END

-- Funcion que comprueba que los numeros del boleto SIMPLE no son iguales
GO

GO
CREATE FUNCTION fn_NumeroRepetido (@num1 int, @num2 int,@num3 int,@num4 int,@num5 int,@num6 int) RETURNS int
BEGIN

		DECLARE @repetido as int = 0


		IF((@num1=@num2) or (@num1=@num3) or (@num1=@num4) or (@num1=@num5) or (@num1=@num6) or
			(@num2=@num3) or (@num2=@num4) or (@num2=@num5) or (@num2=@num6) or
			(@num3=@num4) or (@num3=@num5) or (@num3=@num6) or 
			(@num4=@num5) or (@num4=@num6) or
			(@num5=@num6))
			begin
				ROLLBACK
				Print 'Has introducido un número repetido'
			end
end
GO

-- Funcion que te dice si dos numeros son iguales o diferentes

GO
CREATE FUNCTION fn_ParejaNumeroRepetido (@numA int, @numB int) RETURNS int
begin
-- iguales =0   // diferentes=1
	DECLARE @iguales as int = 0

	IF(@numA!=@numB)
	begin
		SET @iguales = 1
	end

	return @iguales
end
GO


--2)Implementa un procedimiento GrabaMuchasSencillas que genere n boletos con una apuesta sencilla utilizando el procedimiento GrabaSencilla. Datos de entrada: El sorteo y el valor de n
GO
CREATE PROCEDURE GrabaMuchasSencillas @idSorteo int, @cantidad int
AS
BEGIN
	DECLARE @cont as int =0
	
	DECLARE @uno as int 
	DECLARE @dos as int 
	DECLARE @tres as int 
	DECLARE @cuatro as int 
	DECLARE @cinco as int 
	DECLARE @seis as int 

	DECLARE @diferentes as int =1

	WHILE @cont<@cantidad --Repetir Procedimiento GrabaSencilla @idSorteo int, @num1 int,@num2 int,@num3 int,@num4 int,@num5 int,@num6 int
		BEGIN
				--mientras (haya repetidos)
				WHILE @diferentes=1
					begin
					-- creo variables de numeros
								EXECUTE @uno= dbo.generaNumeroAleatorio
								EXECUTE @dos= dbo.generaNumeroAleatorio
								EXECUTE @tres= dbo.generaNumeroAleatorio
								EXECUTE @cuatro= dbo.generaNumeroAleatorio
								EXECUTE @cinco= dbo.generaNumeroAleatorio
								EXECUTE @seis= dbo.generaNumeroAleatorio
					-- compruebo que son todos diferentes
								EXECUTE @diferentes= fn_NumeroRepetido @num1=@uno, @num2=@dos,@num3=@tres,@num4=@cuatro,@num5=@cinco,@num6=@seis
					end--segundo while

				-- ordenar numeros (David)

				

				PRINT 'Introducida apuesta'+ CAST (@cont as varchar)

				SET @cont = @cont + 1;

		END --primer while
END
GO





