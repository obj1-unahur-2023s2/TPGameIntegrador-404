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
		if ( self.estaSobreUnEnemigo() or self.estaSobreUnObstaculo()){
			game.removeTickEvent("movimientoBola")
			game.removeVisual(self)
			game.getObjectsIn(position).first().recibirAtaque(usuario.danio() / 2)
			
		}
	}
	
	method usar(){
		
		if (usuario.puedeMoverse()){
			animaciones.disparar(usuario)
			game.addVisual(self)
			sonidoAReproducir.iniciar("assets/sonidos/kame.wav")
			usuario.direccionHaciaLaQueMira().desplazamiento(self)
			usuario.energia(0.max(usuario.energia() - 10))
		}
	}
	
	method serAgarrado(entidad){}
	
	method estaSobreUnEnemigo() =  self.position() == usuario.enemigo().position()
	
	method estaSobreUnObstaculo() = juego.obstaculos().any( { o => o.position() == self.position()  } )
}
class BengalaSolar{
	
	const usuario
	
	method image() = "ataques/luz.png"
	
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
			sonidoAReproducir.iniciar("assets/sonidos/bengalaSolar.wav")
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



