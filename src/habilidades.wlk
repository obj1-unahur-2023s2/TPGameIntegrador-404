import wollok.game.*
import entidades.*
import juegoManager.*
import animaciones.*
import musica.*

class BolaDeEnergia {
	
	var position
	const usuario
	method image() = "ataques/" + usuario.toString() +"BolaDeEnergia.png"
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
	
	method usar(){
		
		if (usuario.puedeMoverse()){
			animaciones.disparar(usuario)
			game.addVisual(self)
			sonidoKame.iniciar()
			usuario.direccionHaciaLaQueMira().desplazamiento(self)
			usuario.energia(0.max(usuario.energia() - 10))
		}
	}
	
	method serAgarrado(entidad){}
	
	method estaSobreUnEnemigoOObstaculo() = 
		game.getObjectsIn(position).first() == usuario.enemigo() or juego.obstaculos().any( { o => o.position() == self.position()  } )
}
class BengalaSolar{
	
	const usuario
	
	method image() = "ataques/Luz.png"
	
	method position() = usuario.position()
	
	method aturdir(){
		if ( self.hayEnemigoAlRededor()){
			usuario.enemigo().serAturdido(2000)
		}
		game.schedule(150,{game.removeVisual(self)})
	}
	
	method usar(){
		if (usuario.puedeMoverse()){
			game.addVisual(self)
			sonidoBengalaSolar.iniciar()
			self.aturdir()
			usuario.energia(0.max(usuario.energia() - 25))
		}
	}
	
	method serAgarrado(entidad){}
	
	method hayEnemigoAlRededor() = 
		usuario.position().up(1) == usuario.enemigo().position() or
		usuario.position().down(1) == usuario.enemigo().position() or
		usuario.position().right(1) == usuario.enemigo().position() or
		usuario.position().left(1) == usuario.enemigo().position()

}



