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
	
	method serAgarrado(entidad, cantidad){ 
		entidad.vida( cantidad.min(entidad.vida() + 10 ))
		game.removeVisual(self)
		juego.eliminarCapsulaVida(self)
	}
	
}

class CapsulaEnergia inherits Obstaculo{
	
	method image() = "assets/elementos/CapsulaEnergia.png"
	
	method serAgarrado(entidad, cantidad){ 
		entidad.energia( 100.min(entidad.energia() + 25) )
		game.removeVisual(self)
		juego.eliminarCapsulaEnergia(self)
	}
}