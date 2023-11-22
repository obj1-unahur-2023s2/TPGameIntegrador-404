import wollok.game.*
import entidades.*

class Barra{
	
	const position
	const usuario
	method position() = position
	method image()
}

class BarraDeVida inherits Barra{
	
	const division
	
	override method image() = "indicadores/barraDeVida" + calculo.indicarBarra(usuario.vida(),division)  + ".png"
}

class BarraDeEnergia inherits Barra{

	override method image() = "indicadores/barraDeEnergia"+ calculo.indicarBarra(usuario.energia(), 10) +".png"
}

object barraDeFuria{
	method position()= game.at(4,15)
	method image() = "indicadores/barraDeFuria"+ calculo.indicarBarra(goku.furia(), 10) +".png"
}

object calculo{
	
	method indicarBarra(tipoBarra, division) = ((tipoBarra / division).truncate(0)*10 ).toString()
}