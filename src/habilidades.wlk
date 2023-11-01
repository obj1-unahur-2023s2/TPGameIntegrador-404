import wollok.game.*
import entidades.*
import juegoManager.*
import animaciones.*

class BolaDeEnergia {
	
	var position
	method image() = "ataques/bolaDeEnergia.png"
	method position() = position
	
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
			game.removeVisual(self)
		}
	}
	
	method estaSobreUnEnemigoOObstaculo() = 
		game.getObjectsIn(position).first() == freezer or juego.obstaculos().any( { o => o.position() == self.position()  } )
}
class BengalaSolar{
	
	method image() = "ataques/Luz.png"
	
	method position() = goku.position()
	
	method aturdir(){
		if ( self.hayEnemigoAlRededor()){
			freezer.serAturdido(2000)
		}
		game.schedule(150,{game.removeVisual(self)})
	}
	
	method hayEnemigoAlRededor() = 
		self.position().up(1) == freezer.position() or self.position().down(1) == freezer.position() or self.position().right(1) == freezer.position() or self.position().left(1) == freezer.position()

}



