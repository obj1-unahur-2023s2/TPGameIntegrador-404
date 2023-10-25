import wollok.game.*
class Obstaculo{
	
	const position
	
	method recibirAtaque(cant) {}
	method serAturdido(tiempo) {}
	method morir(){}
	method position() = position
	
}

class Arbol inherits Obstaculo{
	
	method image() = "assets/obstaculos/arbol.png"
}

object recargaVida inherits Obstaculo(position = game.at ( 15,10 )){
	method image() = "assets/ataques/bolaDeEnergia.png"
}