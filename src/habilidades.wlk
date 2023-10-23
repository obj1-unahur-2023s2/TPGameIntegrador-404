import wollok.game.*
import entidades.*
import juegoManager.*
import animaciones.*

class BolaDeEnergia {
	
	var position
	method image() = "ataques/bolaDeEnergia.png"
	method position() = position
	
	method desplazarse(){
		if (goku.accion() == "Frente"){
			animaciones.disparar(goku, "Frente")
			game.onTick(250, "movimientoBola", {self.moverseFrente()})
		}
		else if (goku.accion() == "Atras"){
			animaciones.disparar(goku,"Atras")
			game.onTick(250, "movimientoBola", {self.moverseAtras()})  //cambiar
		}
		else if (goku.accion() == "Derecha"){
			animaciones.disparar(goku,"Derecha")
			game.onTick(250, "movimientoBola", {self.moverseDerecha()})
		}
		else if (goku.accion() == "Izquierda"){
			animaciones.disparar(goku,"Izquierda")
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
		if ( not game.getObjectsIn(position).isEmpty() and self.estaSobreUnEnemigoOObstaculo()){
			game.removeTickEvent("movimientoBola")
			game.getObjectsIn(position).first().recibirAtaque(goku.danio() / 2)
			game.getObjectsIn(position).first().morir()
			game.removeVisual(self)
		}
	}
	
	method estaSobreUnEnemigoOObstaculo() = 
		juego.enemigos().any( {e => game.getObjectsIn(position).first() == e}) or juego.obstaculos().any( { o => o.position() == self.position()  } )
}

class BengalaSolar{
	
	method position() = goku.position()
	
	method aturdir(){
		if ( not self.enemigosAlRededor().isEmpty()){
			self.enemigosAlRededor().forEach({ e => e.serAturdido(2000) })
			game.schedule(150,{game.removeVisual(self)})
		}
	}
	
	method enemigosAlRededor() = 
		juego.enemigos().filter({ 
			e => self.position().up(1) == e.position() or self.position().down(1) == e.position() or self.position().right(1) == e.position() or self.position().left(1) == e.position()
		})	
}



