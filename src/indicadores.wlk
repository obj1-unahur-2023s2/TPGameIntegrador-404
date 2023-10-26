import wollok.game.*
import entidades.*

object barraDeVida{
	
	method position()= game.at(0.5,15)
	method image() =
		if (goku.vida() >= 91)                          	 "indicadores/barraDeVidaLlena.png"
		else if ((goku.vida() < 91) and (goku.vida()>=81))   "indicadores/barraDeVida90.png"
		else if ((goku.vida() < 81) and (goku.vida()>=71))   "indicadores/barraDeVida80.png"
		else if	((goku.vida() < 71) and (goku.vida()>=61))   "indicadores/barraDeVida70.png"
		else if	((goku.vida() < 61) and (goku.vida()>=51))   "indicadores/barraDeVida60.png"
		else if ((goku.vida() < 51) and (goku.vida() >=41))  "indicadores/barraDeVida50.png"
		else if ((goku.vida() < 41) and (goku.vida() >=31))  "indicadores/barraDeVida40.png"
		else if ((goku.vida() < 31) and (goku.vida() >=21))  "indicadores/barraDeVida30.png"
		else if ((goku.vida() < 21) and (goku.vida() >=11))  "indicadores/barraDeVida20.png"
		else if ((goku.vida() < 11) and (goku.vida() >=1))  "indicadores/barraDeVida10.png"
		else  								  				 "indicadores/barraDeVida0.png"
}

object barraDeEnergia{

	method position()= game.at(3,15)
	method image() =
		if (goku.energia() >= 91)                          	 "indicadores/barraDeEnergiaLlena.png"
		else if ((goku.energia()< 91) and (goku.energia()>=81))   "indicadores/barraDeEnergia90.png"
		else if ((goku.energia()< 81) and (goku.energia()>=71))   "indicadores/barraDeEnergia80.png"
		else if ((goku.energia()< 71) and (goku.energia()>=61))   "indicadores/barraDeEnergia70.png"
		else if ((goku.energia() < 61) and (goku.energia() >=51))  "indicadores/barraDeEnergia60.png"
		else if ((goku.energia() < 51) and (goku.energia() >=41))  "indicadores/barraDeEnergia50.png"
		else if ((goku.energia() < 41) and (goku.energia() >=31))  "indicadores/barraDeEnergia40.png"
		else if ((goku.energia() < 31) and (goku.energia() >=21))  "indicadores/barraDeEnergia30.png"
		else if ((goku.energia() < 21) and (goku.energia() >=11))  "indicadores/barraDeEnergia20.png"
		else if ((goku.energia() < 11) and (goku.energia() >1))   "indicadores/barraDeEnergia10.png"
		else  								  				 "indicadores/barraDeEnergia0.png"
}

object barraDeFuria{
	method position()= game.at(6,15)
	method image() =
		if (goku.furia() >= 91)                          	 "indicadores/barraDeFuriaLlena.png"
		else if ((goku.furia()< 91) and (goku.furia()>=81))   "indicadores/barraDeFuria90.png"
		else if ((goku.furia()< 81) and (goku.furia()>=71))   "indicadores/barraDeFuria80.png"
		else if ((goku.furia()< 71) and (goku.furia()>=61))   "indicadores/barraDeFuria70.png"
		else if ((goku.furia() < 61) and (goku.furia() >=51))  "indicadores/barraDeFuria60.png"
		else if ((goku.furia() < 51) and (goku.furia() >=41))  "indicadores/barraDeFuria50.png"
		else if ((goku.furia() < 41) and (goku.furia() >=31))  "indicadores/barraDeFuria40.png"
		else if ((goku.furia() < 31) and (goku.furia() >=21))  "indicadores/barraDeFuria30.png"
		else if ((goku.furia() < 21) and (goku.furia() >=11))  "indicadores/barraDeFuria20.png"
		else if ((goku.furia() < 11) and (goku.furia() >1))   "indicadores/barraDeFuria10.png"
		else  								  				 "indicadores/barraDeFuria0.png"
	
}