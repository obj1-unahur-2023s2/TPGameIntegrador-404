import wollok.game.*
import entidades.*

object juego{

	var enemigo = new Enemigo()
	
	method iniciar() {
		
		game.height(15)
		game.width(15)
		game.title("The Legend Of SuperSaiyan")
		
		self.agregarVisuales()
		self.configurarTeclas()
		enemigo.movimientoEnemigo()
		
	}
	
	method agregarVisuales(){
		game.addVisual(goku)
		game.addVisual(enemigo)
	}
	
	method configurarTeclas() {
		keyboard.up().onPressDo{ goku.avanzar()}
		keyboard.down().onPressDo{ goku.retroceder()}
		keyboard.left().onPressDo{ goku.izquierda()}
		keyboard.right().onPressDo{ goku.derecha()}
		keyboard.q().onPressDo{ goku.golpear() }
		keyboard.w().onPressDo{ goku.disparar() }
		 
	}
	
	method eliminarEnemigo(){ 
		game.removeVisual(enemigo)
		enemigo = null
	}  // se debe modificar para que funcione con diferentes enemigos
	
	
}