import wollok.game.*
import entidades.*
import juegoManager.*


class Obstaculo{
	
	const position
	
	method recibirAtaque(cant) {}
	method serAturdido(tiempo) {}
	method position() = position
	
}

class Arbol inherits Obstaculo{
	
	method image() = "assets/elementos/arbol.png"
}

class CapsulaVida inherits Obstaculo{
	
	method image() = "assets/elementos/CapsulaVida.png"
	
	override method recibirAtaque(cant){ 
		goku.vida( 100.min(goku.vida() + 10 ))
		game.removeVisual(self)
		juego.eliminarCapsulaVida(self)
	}
}

class CapsulaEnergia inherits Obstaculo{
	
	method image() = "assets/elementos/CapsulaEnergia.png"
	
	override method recibirAtaque(cant){ 
		goku.energia( 100.min(goku.energia() + 25) )
		game.removeVisual(self)
		juego.eliminarCapsulaVida(self)
	}
}