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
	
	method image() = "assets/elementos/capsulaVida.png"
	
	method serAgarrado(entidad){ 
		entidad.vida( juego.dificultad().maximoVida().min(entidad.vida() + 30 ))
		game.removeVisual(self)
		juego.eliminarCapsulaVida(self)
	}
	
}

class CapsulaEnergia inherits Obstaculo{
	
	method image() = "assets/elementos/capsulaEnergia.png"
	
	method serAgarrado(entidad){ 
		entidad.energia( 100.min(entidad.energia() + 25) )
		game.removeVisual(self)
		juego.eliminarCapsulaEnergia(self)
	}
}