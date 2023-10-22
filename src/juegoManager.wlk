import wollok.game.*
import entidades.*
import indicadores.*
import obstaculos.*

object juego{
	
	var enemigo = new Enemigo(position = game.at(4,4))
	const property enemigos = [enemigo]
	
	const arboles = [new Arbol(position = game.at(10,10)), new Arbol(position = game.at(14,6)), new Arbol(position = game.at(6,5)), new Arbol(position = game.at(18,11))]
	method arboles() = arboles
	
	method iniciar() {
		
		game.height(16)
		game.width(22)
		game.title("The Legend Of SuperSaiyan")
		game.boardGround("assets/mapaNamek.png")
		
		self.agregarVisuales()
		self.configurarTeclas()
		enemigo.movimientoEnemigo()
		
	}
	
	method agregarVisuales(){
		game.addVisual(goku)
		game.addVisual(enemigo)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		arboles.forEach({a => game.addVisual(a)})
		
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
	
}