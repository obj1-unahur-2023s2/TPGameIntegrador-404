import wollok.game.*
import entidades.*

object barraDeVida{
	
	const position = game.at(0.5,15)
	
	method position()= position
	method image() = 
		if (goku.vida() >= 80)                          	 "indicadores/barraDeVidaLlena.png"
		else if ((goku.vida() < 80) and (goku.vida()>=60))   "indicadores/barraDeVida80.png"
		else if ((goku.vida() < 60) and (goku.vida() >=40))  "indicadores/barraDeVida60.png"
		else if ((goku.vida() < 40) and (goku.vida() >=20))  "indicadores/barraDeVida40.png"
		else if ((goku.vida() < 20) and (goku.vida() >=1))   "indicadores/barraDeVida20.png"
		else  								  				 "indicadores/barraDeVida0.png"
}