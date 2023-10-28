import wollok.game.*
import entidades.*
import juegoManager.*


class Obstaculo{
	
	const position
	
	method recibirAtaque(cant) {}
	method serAturdido(tiempo) {}
	method morir(){}
	method position() = position
	
}

class Arbol inherits Obstaculo{
	
	method image() = "assets/elementos/arbol.png"
}

class CapsulaVida inherits Obstaculo{
	
	method image() = "assets/elementos/CapsulaVida.png"
	
	override method recibirAtaque(cant){ goku.vida( goku.vida() + 10 ) }
	override method morir(){ 
		game.removeVisual(self)
		juego.eliminarCapsulaVida(self)
	}
}

class CapsulaEnergia inherits Obstaculo{
	
	method image() = "assets/elementos/CapsulaEnergia.png"
	
	override method recibirAtaque(cant){ goku.energia( goku.energia() + 25 ) }
	override method morir(){ 
		game.removeVisual(self)
		juego.eliminarCapsulaEnergia(self)
	}
}