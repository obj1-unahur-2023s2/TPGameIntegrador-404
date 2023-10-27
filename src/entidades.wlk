import wollok.game.*
import habilidades.*
import juegoManager.*
import animaciones.*
import obstaculos.*
import direcciones.*


class EntidadesVivas{
	
	var position
	var property vida = 100
	var property direccionHaciaLaQueMira = frente
	var property accion = ""
	var estaAturdido = false
	var danio
	
	method danio() = danio
	method estaVivo() = vida > 0
	method position() = position
	method vida() = vida
	
	method image()
	
	method recibirAtaque(cant){
		vida -= cant
		goku.furia( 100.min(goku.furia() + 10) )
	}
		
	method puedeMoverse() = not estaAturdido and self.estaVivo()
	
	
	method caminarArriba() {
		//el personaje avanza solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.up(1)).isEmpty() and not estaAturdido){
			position = position.up(1)
		}
		direccionHaciaLaQueMira = atras
	}
	
	method caminarAbajo() {
		//el personaje retrocede solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.down(1)).isEmpty() and not estaAturdido){
			position = position.down(1)
		}
		direccionHaciaLaQueMira = frente
	}
	
	method caminarDerecha() {
		//el personaje avanza a la derecha solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.right(1)).isEmpty() and not estaAturdido){
			position = position.right(1)
		}
		direccionHaciaLaQueMira = derecha
	}
	
	method caminarIzquierda() {
		//el personaje avanza a la izquierda solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.left(1)).isEmpty() and not estaAturdido){
			position = position.left(1)
		}
		direccionHaciaLaQueMira = izquierda
	}
	 
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } //esta funcion tiene inplementado el tiempo, ya que se usara para la habilidad "Bengala Solar" la cual aturde a los enemigos "x" segundos
}

object goku inherits EntidadesVivas(position = game.center(), danio = 20){
	
	var energia= 100
	var property furia = 100
	var estaTransformado = false
	method energia()= energia
	
	override method image() = if (not estaTransformado) "assets/jugador/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png" else "assets/jugador/ssj/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
    
	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		direccionHaciaLaQueMira.atacarHaciaLaDireccionQueMira(self)
	}

   method realizarAtaque(){ 
        direccionHaciaLaQueMira.jugadorHacerDanioHaciaLaDireccionQueMira(self,danio)
        animaciones.golpear(self)
    }
	
	
	method usarBolaDeEnergia(){  //dispara una bola de energia que va en linea recta, si choca con el enemigo le hace daño, y si choca con un bostaculo desparece
		if( energia >=0){
			const bola = new BolaDeEnergia(position = position)
			animaciones.disparar(self)
			game.addVisual(bola)
			direccionHaciaLaQueMira.desplazamiento(bola)
			energia -= 10
			}
		else{ game.say(self,"No tengo suficiente energia")}
		
	}
	
	method usarBengalaSolar(){  //el personaje lanza una onda de luz que deja aturdido al enemigo, sin poder realizar una accion por un determinado tiempo
		if ( energia >= 25 ){
			const bengalaSolar = new BengalaSolar()
			game.addVisual(bengalaSolar)
			bengalaSolar.aturdir()
			energia -= 25
		}
		else{ game.say(self, "No tengo suficiente energia") }
	}
	
	method transformarse(){  // el jugador se transforma y aumenta su daño
		if (furia == 100 and not estaTransformado){
			estaTransformado = true
			animaciones.transformacion()
			danio *= 2
		}
		else{
			game.say(self, "no me puedo transformar")
		}
	}
	
	method morir(){ 
		//por ahora no hace nada, se hara cuando se haga la pantalla de game over
	}
	
}

class Enemigo inherits EntidadesVivas{
	
	override method image() = "assets/enemigos/enemigo" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
	
	method movimiento(){ //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			if (self.hayUnObstaculoALaDerecha()){
			 	self.esquivarObstaculo()
			 }
			 self.caminarDerecha()
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){  //cambiar
			 if (self.hayUnObstaculoALaIzquierda()){
			 	self.esquivarObstaculo()
			 }
			self.caminarIzquierda()
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.caminarArriba()
			self.esquivarObstaculo()
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.caminarAbajo()
			self.esquivarObstaculo()
		}
		
	}
	
	method realizarAtaque(){ 
        direccionHaciaLaQueMira.enemigoHacerDanioHaciaLaDireccionQueMira(self,danio)
    }
	
	override method puedeMoverse(){ //el enemigo solo se puede mover si el jugador esta en un radio de 4 casillas de el
		return 
			goku.position().x()-self.position().x().abs() <= 4 and
			goku.position().y()-self.position().y().abs() <= 4 and
			goku.position().x()-self.position().x() >= -4 and
			goku.position().y()-self.position().y() >= -4 and
			super()
		}
		
	method esquivarObstaculo(){  // metodo para que el enemigo no se quede enganchado contra un obstaculo, y pase por al lado
		if( self.hayUnObstaculoAbajo() and direccionHaciaLaQueMira == "Frente" )
			{
				self.caminarIzquierda()
				game.schedule(100,{self.caminarAbajo()})
				
			}
		else if( self.hayUnObstaculoArriba() and direccionHaciaLaQueMira == "Atras" )  //cambiar
			{
				self.caminarDerecha()
				game.schedule(100,{self.caminarArriba()})
			}
		else if(self.hayUnObstaculoALaDerecha() and direccionHaciaLaQueMira == "Derecha" )
			{
				self.caminarAbajo()
				self.caminarIzquierda()
			}
		else if(self.hayUnObstaculoALaIzquierda() and direccionHaciaLaQueMira == "Izquierda")
			{
				self.caminarArriba()
				self.caminarDerecha()
			}
	}
	
	method hayUnObstaculoALaDerecha() = juego.obstaculos().any({obstaculo => position.right(1) == obstaculo.position()})
	method hayUnObstaculoALaIzquierda() = juego.obstaculos().any({obstaculo => position.left(1) == obstaculo.position()})
	method hayUnObstaculoArriba() = juego.obstaculos().any({obstaculo => position.up(1) == obstaculo.position()})
	method hayUnObstaculoAbajo() = juego.obstaculos().any({obstaculo => position.down(1) == obstaculo.position()})
	
	method velocidadDeMovimiento(){ //tiempo en el que el enemigo se mueve 1 casilla
		
		game.onTick(500, "movimientoEnemgio",{ self.movimiento() })
	}
	
	method velocidadDeAtaque(){ //tiempo en el que el enemigo lanza un ataque
		
		game.onTick(700, "movimientoEnemgio",{ self.realizarAtaque() })
	}
	
	method morir(){ 
		if (not self.estaVivo()){
			animaciones.morir(self)
			game.schedule(2000, {game.removeVisual(self)})  //cambiar para que tambien funcione con cualquier enemigo
		}
	}

}

