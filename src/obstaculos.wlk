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