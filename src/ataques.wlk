import wollok.game.*
import entidades.*
import juegoManager.*

class BolaDeEnergia {
	var position
	
	method image() = "bolaDeEnergia.png"
	
	method position() = position
	
	method desplazarse(){
		game.onTick(250, "movimientoBola", {self.moverseDerecha()})
	}
	
	method moverseDerecha(){
		
		position = position.right(1)
		self.hacerDanio()
	}
	
	method hacerDanio(){
		if ( not game.getObjectsIn(position).isEmpty() and game.getObjectsIn(position).first() != self){
			game.removeTickEvent("movimientoBola")
			game.getObjectsIn(position).first().recibirAtaque(10)
			game.getObjectsIn(position).first().morir()
			game.removeVisual(self)
		}
	}
	
}
