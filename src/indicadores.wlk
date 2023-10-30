import wollok.game.*
import entidades.*

object barraDeVida{
	
	method position()= game.at(0.5,15)
	
	method image() = "indicadores/barraDeVida" + calculo.indicarBarra(goku.vida())  + ".png"
	
	method calculoVida() = ((goku.vida() / 10).truncate(0)*10 ).toString()
}

object barraDeEnergia{

	method position()= game.at(3,15)
	method image() = "indicadores/barraDeEnergia"+ calculo.indicarBarra(goku.energia()) +".png"

		
	method calculoEnergia() = ((goku.energia() / 10).truncate(0)*10 ).toString()
}

object barraDeFuria{
	method position()= game.at(6,15)
	method image() = "indicadores/barraDeFuria"+ calculo.indicarBarra(goku.furia()) +".png"

	
	method calculoFuria() = ((goku.furia() / 10).truncate(0)*10 ).toString()	
}

object calculo{
	
	method indicarBarra(tipoBarra) = ((tipoBarra / 10).truncate(0)*10 ).toString()
}