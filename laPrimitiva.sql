/*	Lotería primitiva

Se trata de desarrollar una base de datos para gestionar el juego de la lotería primitiva.
Para simplificar el juego, consideramos las siguientes restricciones:
•	No se implementará el juego del jackpot
•	Cada boleto contendrá una sola apuesta, que puede ser simple o múltiple
•	Cada boleto participa en un único sorteo.

Programación parte 1
•	Implementa un procedimiento almacenado GrabaSencilla que grabe una apuesta simple. Datos de entrada: El sorteo y los seis números
•	Implementa un procedimiento GrabaMuchasSencillas que genere n boletos con una apuesta sencilla utilizando el procedimiento GrabaSencilla. Datos de entrada: El sorteo y el valor de n
•	Implementa un procedimiento almacenado GrabaMultiple que grabe una apuesta simple. Datos de entrada: El sorteo y entre 5 y 11 números

Implementar restricciones
Mediante restricciones check y triggers, asegurate de que se cumplen las siguientes reglas
•	No se puede insertar un boleto si queda menos de una hora para el sorteo. Tampoco para sorteos que ya hayan tenido lugar
•	Una vez insertado un boleto, no se pueden modificar sus números
•	Todos los números están comprendido entre 1 y 49
•	En las apuestas no se repiten números
•	Las apuestas sencillas tienen seis números
•	Las apuestas múltiples tienen5, 7, 8, 9, 10 u 11 números

Pruebas de rendimiento
Realiza inserciones de 10.000, 100.000, 500.000 y 1.000.000 de boletos y mide el tiempo y el tamaño de la base de datos
Anota los resultados en este formulario (uno por grupo)
Premios
Modifica la base de datos para que, una vez realizado el sorteo, se pueda asignar a cada boleto la cantidad ganada. Para ello, crea un procedimiento AsignarPremios que calcule los premios de cada boleto y lo guarde en la base de datos.
Para saber cómo se asignan los premios, debes seguir las instrucciones de este documento, en especial el Capítulo V del Título I (págs 7, 8, 9 y 10) y la tabla de la instrucción 21.4 (pág 14).
*/











CREATE DATABASE laPrimitiva
GO
USE laPrimitiva
go



CREATE TABLE Sorteos (
						idSorteo int identity(0,1) primary key,
						fecha smalldatetime not null,
						complementario int not null,
						reintegro int not null,
						bote money not null default 0,
						num1 int not null,
						num2 int not null,
						num3 int not null,
						num4 int not null,
						num5 int not null,
						num6 int  null,
						--constraint FK_sorteo_boletos FOREIGN key (idSorteo) references Boletos(idSorteo),
						constraint CK_reintegroSorteo check(reintegro between 1 and 9),
						constraint CK_num1Sorteo check(num1 between 1 and 49),
						constraint CK_num2Sorteo check(num2 between 1 and 49),
						constraint CK_num3Sorteo check(num3 between 1 and 49),
						constraint CK_num4Sorteo check(num4 between 1 and 49),
						constraint CK_num5Sorteo check(num5 between 1 and 49),
						constraint CK_num6Sorteo check(num6 between 1 and 49),
						constraint CK_complementarioSorteo check(complementario between 1 and 49),
						constraint CK_boteSorteos check(bote >=0)
						)

CREATE TABLE Boletos (
					idBoleto int identity(0,1) primary key,
					idSorteo int not null,
					reintegro int not null, 
					constraint CK_reintegroBoletos check(reintegro between 1 and 9),
					constraint FK_boletosSorteos FOREIGN key (idSorteo) references Sorteos(idSorteo)
					)
		--la solucion es hacer 2 tablas tipo-subtipo, pero entonces no podemos tener id común para todos los boletos

CREATE TABLE BoletoSimples (
					idBoletoS int primary key,	
					num1 int not null,
					num2 int not null,
					num3 int not null,
					num4 int not null,
					num5 int not null,
					num6 int not null,
					constraint FK_Boleto_BoletoSimple FOREIGN key (idBoletoS) references Boletos(idBoleto),		
					constraint CK_num1BoletoSimples check(num1 between 1 and 49),
					constraint CK_num2BoletoSimples check(num2 between 1 and 49),
					constraint CK_num3BoletoSimples check(num3 between 1 and 49),
					constraint CK_num4BoletoSimples check(num4 between 1 and 49),
					constraint CK_num5BoletoSimples check(num5 between 1 and 49),
					constraint CK_num6BoletoSimples check(num6 between 1 and 49)
						)


CREATE TABLE BoletoMultiples (
					idBoletoM int primary key,
					num1 int not null,
					num2 int not null,
					num3 int not null,
					num4 int not null,
					num5 int not null,
					num6 int  null,
					num7 int  null,
					num8 int  null,
					num9 int  null,
					num10 int  null,
					num11 int  null,
					constraint FK_Boleto_BoletoMultiple FOREIGN key (idBoletoM) references Boletos(idBoleto),		
					constraint CK_num1BoletoMultiples check(num1 between 1 and 49),
					constraint CK_num2BoletoMultiples check(num2 between 1 and 49),
					constraint CK_num3BoletoMultiples check(num3 between 1 and 49),
					constraint CK_num4BoletoMultiples check(num4 between 1 and 49),
					constraint CK_num5BoletoMultiples check(num5 between 1 and 49),
					constraint CK_num6BoletoMultiples check(num6 between 1 and 49),
					constraint CK_num7BoletoMultiples check(num7 between 1 and 49),
					constraint CK_num8BoletoMultiples check(num8 between 1 and 49),
					constraint CK_num9BoletoMultiples check(num9 between 1 and 49),
					constraint CK_num10BoletoMultiples check(num10 between 1 and 49),
					constraint CK_num11BoletoMultiples check(num11 between 1 and 49)
						)



CREATE TABLE Premios (
					idPremio int identity(0,1) primary key,
					idSorteo int not null,
					categoria varchar not null,
					cantidad money not null default 0,
					constraint FK_sorteo_premios FOREIGN key (idSorteo) references Sorteos(idSorteo),	
					constraint CK_categoriasPermitidasPremios check(categoria IN ('ESPECIAL', 'PRIMERA','SEGUNDA','TERCERA','CUARTA','QUINTA','SEXTA')),
					constraint CK_cantidadPremios check(cantidad >=0)
						)


--DROP DATABASE laPrimitiva