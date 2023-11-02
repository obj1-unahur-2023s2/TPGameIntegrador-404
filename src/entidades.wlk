import wollok.game.*
import habilidades.*
import juegoManager.*
import animaciones.*
import obstaculos.*
import direcciones.*


class EntidadesVivas{
	
	var position
	var property vida 
	var property direccionHaciaLaQueMira = frente
	var property accion = ""
	var estaAturdido = false
	

	method estaVivo() = vida > 0
	method position() = position
	method image()
	
	method recibirAtaque(cant){
		vida -= cant
		goku.furia( 100.min(goku.furia() + 10) )
		if (not self.estaVivo()){
			self.morir()
		}
	}
		
	method puedeMoverse() = not estaAturdido and self.estaVivo()
	
	
	method cambiarDireccionHaciaLaQueMira(direccion){ if (self.puedeMoverse()) direccionHaciaLaQueMira = direccion}
	
	method caminarArriba() {
		//el personaje avanza solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.up(1)).isEmpty() and self.puedeMoverse()){
			position = position.up(1)
		}
		self.cambiarDireccionHaciaLaQueMira(atras)
	}
	
	method caminarAbajo() {
		//el personaje retrocede solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.down(1)).isEmpty() and self.puedeMoverse()){
			position = position.down(1)
		}
		self.cambiarDireccionHaciaLaQueMira(frente)
	}
	
	method caminarDerecha() {
		//el personaje avanza a la derecha solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.right(1)).isEmpty() and self.puedeMoverse()){
			position = position.right(1)
		}
		self.cambiarDireccionHaciaLaQueMira(derecha)
	}
	
	method caminarIzquierda() {
		//el personaje avanza a la izquierda solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.left(1)).isEmpty() and self.puedeMoverse()){
			position = position.left(1)
		}
		self.cambiarDireccionHaciaLaQueMira(izquierda)
	}
	 
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } //esta funcion tiene inplementado el tiempo, ya que se usara para la habilidad "Bengala Solar" la cual aturde a los enemigos "x" segundos
    
    method morir()
}

object goku inherits EntidadesVivas(position = game.center(), vida = 100){
	
	var property energia= 100
	var property furia = 0
	var estaTransformado = false
	var danio = 20
	
	method energia()= energia
	method danio() = danio
	override method image() = if (not estaTransformado) "assets/jugador/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png" else "assets/jugador/ssj/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
    
	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		if (not game.getObjectsIn(direccionHaciaLaQueMira.destino(self)).isEmpty() and self.puedeMoverse()){
            game.getObjectsIn(direccionHaciaLaQueMira.destino(self)).first().recibirAtaque(danio)
        }
        animaciones.golpear(self)
	}
	
	
	method usarBolaDeEnergia(){  //dispara una bola de energia que va en linea recta, si choca con el enemigo le hace daño, y si choca con un bostaculo desparece
		if( energia >= 10){
			const bola = new BolaDeEnergia(position = position)
			animaciones.disparar()
			game.addVisual(bola)
			direccionHaciaLaQueMira.desplazamiento(bola)
			energia = 0.max(energia - 10)
			}
		else{ game.say(self,"No tengo suficiente energia")}
		
	}
			//usar(habilidad)
	method usarBengalaSolar(){  //el personaje lanza una onda de luz que deja aturdido al enemigo, sin poder realizar una accion por un determinado tiempo
		if ( energia >= 25 ){
			const bengalaSolar = new BengalaSolar()
			game.addVisual(bengalaSolar)
			bengalaSolar.aturdir()
			energia = 0.max(energia - 25)
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
	
	override method morir(){ 
		game.schedule(2000, {derrota.configurar()})
	}
	
	override method puedeMoverse() =
		super() and
		freezer.estaVivo()
	
}

object freezer inherits EntidadesVivas(position = game.at(4,4),vida = 100){
	
	var property danio = 0
	
	
	override method image() = "assets/enemigos/enemigo" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
	
	method movimiento(){ //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			if (self.hayUnObstaculoALaDerecha()){
			 	self.esquivarObstaculo()
			 }
			 self.caminarDerecha()
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			self.esquivarObstaculo()

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
	
	method golpear(){ 
        if (direccionHaciaLaQueMira.destino(self) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(direccionHaciaLaQueMira.destino(self) ).first().recibirAtaque(danio)
			animaciones.golpear(self)
		}
    }
	
	override method puedeMoverse(){ //el enemigo solo se puede mover si el jugador esta en un radio de 4 casillas de el
		return 
			goku.position().x()-self.position().x().abs() <= 4 and
			goku.position().y()-self.position().y().abs() <= 4 and
			goku.position().x()-self.position().x() >= -4 and
			goku.position().y()-self.position().y() >= -4 and
			super() and
			goku.estaVivo()
		}
		
	method esquivarObstaculo(){  // metodo para que el enemigo no se quede enganchado contra un obstaculo, y pase por al lado
		if( self.hayUnObstaculoAbajo())
			{
				self.caminarIzquierda()
				game.schedule(100,{self.caminarAbajo()})
				
			}
		else if( self.hayUnObstaculoArriba())  //cambiar
			{
				self.caminarDerecha()
				game.schedule(100,{self.caminarArriba()})
			}
		else if(self.hayUnObstaculoALaDerecha())
			{
				self.caminarAbajo()
				self.caminarIzquierda()
			}
		else if(self.hayUnObstaculoALaIzquierda())
			{
				self.caminarArriba()
				self.caminarDerecha()
			}
	}
	
	method hayUnObstaculoALaDerecha() = juego.obstaculos().any({obstaculo => position.right(1) == obstaculo.position()})
	method hayUnObstaculoALaIzquierda() = juego.obstaculos().any({obstaculo => position.left(1) == obstaculo.position()})
	method hayUnObstaculoArriba() = juego.obstaculos().any({obstaculo => position.up(1) == obstaculo.position()})
	method hayUnObstaculoAbajo() = juego.obstaculos().any({obstaculo => position.down(1) == obstaculo.position()})
	
	method velocidadDeMovimiento(valor){ //tiempo en el que el enemigo se mueve 1 casilla
		
		game.onTick(valor, "movimientoEnemgio",{ self.movimiento() })
	}
	
	method velocidadDeAtaque(valor){ //tiempo en el que el enemigo lanza un ataque
		
		game.onTick(valor, "ataqueEnemgio",{ self.golpear() })
	}
	
	override method morir(){ 
		animaciones.morir(self)
		goku.serAturdido(2000)
		game.schedule(2000, {victoria.configurar()})
	}




}

