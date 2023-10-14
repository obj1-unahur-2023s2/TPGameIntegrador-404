import wollok.game.*
import entidades.*
import indicadores.*

object juego{
	
	var enemigo = new Enemigo(position = game.at(4,4))
	const property enemigos = [enemigo]
	
	method iniciar() {
		
		game.height(16)
		game.width(22)
		game.title("The Legend Of SuperSaiyan")
		
		self.agregarVisuales()
		self.configurarTeclas()
		enemigo.movimientoEnemigo()
		
	}
	
	method agregarVisuales(){
		game.addVisual(goku)
		game.addVisual(enemigo)
		game.addVisual(barraDeVida)
		game.addVisual(barraDeEnergia)
		}
		
	
	
	method configurarTeclas() {
		keyboard.up().onPressDo{ goku.avanzar()}
		keyboard.down().onPressDo{ goku.retroceder()}
		keyboard.left().onPressDo{ goku.izquierda()}
		keyboard.right().onPressDo{ goku.derecha()}
		keyboard.q().onPressDo{ goku.golpear() }
		keyboard.w().onPressDo{ goku.disparar() }
		keyboard.e().onPressDo{ goku.usarBengalaSolar() }
		 
	}
	
	method eliminarEnemigo(){ 
		game.removeVisual(enemigo)
		enemigo = null
	}  // se debe modificar para que funcione con diferentes enemigos
	
}