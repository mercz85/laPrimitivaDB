go
create procedure generaNumeroAleatorio
	@numeroAleatorio int output
as
	begin
		declare @valorMaximo int = 49, @valorMinimo int = 1
		select @numeroAleatorio = floor((@valorMaximo - @valorMinimo +1) * rand() + @valorMinimo)
		return @numeroAleatorio
	end
go
