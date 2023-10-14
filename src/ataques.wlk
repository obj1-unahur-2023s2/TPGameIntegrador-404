import wollok.game.*
import entidades.*
import juegoManager.*

class BolaDeEnergia {
	var position
	
	method image() = "bolaDeEnergia.png"
	
	method position() = position
	
	method desplazarse(){
		if (goku.accion() == "Frente"){
			game.onTick(250, "movimientoBola", {self.moverseFrente()})
		}
		else if (goku.accion() == "Atras"){
			game.onTick(250, "movimientoBola", {self.moverseAtras()})
		}
		else if (goku.accion() == "Derecha"){
			game.onTick(250, "movimientoBola", {self.moverseDerecha()})
		}
		else if (goku.accion() == "Izquierda"){
			game.onTick(250, "movimientoBola", {self.moverseIzquierda()})
		}
	}
	
	method moverseDerecha(){
		self.hacerDanio()
		position = position.right(1)
	}
	method moverseIzquierda(){
		self.hacerDanio()
		position = position.left(1)
	}
	method moverseAtras(){
		self.hacerDanio()
		position = position.up(1)
	}
	method moverseFrente(){
		self.hacerDanio()
		position = position.down(1)
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



