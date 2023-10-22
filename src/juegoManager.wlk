import wollok.game.*
import entidades.*
import indicadores.*
import obstaculos.*

object juego{
	
	var enemigo = new Enemigo(position = game.at(4,4))
	const property enemigos = [enemigo]
	
	const obstaculos = [
		new Arbol(position = game.at(10,10)), new Arbol(position = game.at(14,6)), new Arbol(position = game.at(6,5)), new Arbol(position = game.at(18,11))
	]
	
	const bordes = []
	
	method bordes() = bordes
	
	method obstaculos() = obstaculos
	
	method iniciar() {
		
		game.height(16)
		game.width(22)
		game.title("The Legend Of SuperSaiyan")
		game.boardGround("assets/mapaNamek.png")
		
		
		self.bordesDelMapa()
		self.agregarVisuales()
		self.configurarTeclas()
		enemigo.movimientoEnemigo()
		
	}
	
	method agregarVisuales(){
		game.addVisual(goku)
		game.addVisual(enemigo)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		obstaculos.forEach({a => game.addVisual(a)})
		bordes.forEach({b => game.addVisual(b)})
		
	}
		
	
	
	method configurarTeclas() {
		keyboard.up().onPressDo{ goku.avanzar()}
		keyboard.down().onPressDo{ goku.retroceder()}
		keyboard.left().onPressDo{ goku.izquierda()}
		keyboard.right().onPressDo{ goku.derecha()}
		keyboard.q().onPressDo{ goku.golpear() }
		keyboard.w().onPressDo{ goku.usarBolaDeEnergia() }
		keyboard.e().onPressDo{ goku.usarBengalaSolar() }
		keyboard.r().onPressDo{ goku.transformarse() }
	}
	
	method eliminarEnemigo(){ 
		game.removeVisual(enemigo)
		enemigo = null
	}  // se debe modificar para que funcione con diferentes enemigos
	
	
	method bordesDelMapa(){
		
		self.bordeSuperior()
		self.bordeIzquierdo()
		self.bordeDerecho()
		self.bordeInferior()
	}
	
	
	method bordeInferior(){
		(2..19).forEach({x => bordes.add(new Obstaculo(position = game.at(x , 2)))})
	}
	
	method bordeSuperior(){
		(2..19).forEach({x => bordes.add(new Obstaculo(position = game.at(x , 14)))})
	}
	
	method bordeIzquierdo(){
		(2..14).forEach({y => bordes.add(new Obstaculo(position = game.at(1 , y)))})
	}
	
	method bordeDerecho(){
		(2..14).forEach({y => bordes.add(new Obstaculo(position = game.at(20 , y)))})
	}
}




