import wollok.game.*
import habilidades.*
import juegoManager.*
import animaciones.*
import obstaculos.*
import direcciones.*
import musica.*


class EntidadesVivas{
	
	var property position
	var property vida
	var property energia = 100
	var property direccionHaciaLaQueMira = frente
	var property accion = ""
	var property danio = 0
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
	
	method atacarHaciaLaDireccionQueMira(){
		
		if (direccionHaciaLaQueMira.destino(self) == self.enemigo().position()){
			self.enemigo().recibirAtaque(danio)	
		}
	}
	
		
	method puedeMoverse() = not estaAturdido and self.estaVivo() and self.enemigo().estaVivo()
	
	method cambiarDireccionHaciaLaQueMira(direccion){ if (self.puedeMoverse()) direccionHaciaLaQueMira = direccion}
	
	method hayUnaCapsulaAdelante() = juego.capsulas().contains(game.getObjectsIn(direccionHaciaLaQueMira.destino(self)).first())
	
	method caminarArriba() {
		//el personaje avanza solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		self.cambiarDireccionHaciaLaQueMira(atras)
		if ((game.getObjectsIn(position.up(1)).isEmpty() or self.hayUnaCapsulaAdelante() ) and self.puedeMoverse()){
			position = position.up(1)
		}
	}
	
	method caminarAbajo() {
		//el personaje retrocede solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		self.cambiarDireccionHaciaLaQueMira(frente)
		if ((game.getObjectsIn(position.down(1)).isEmpty() or self.hayUnaCapsulaAdelante() )and self.puedeMoverse()){
			position = position.down(1)
		}
	}
	
	method caminarDerecha() {
		//el personaje avanza a la derecha solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		self.cambiarDireccionHaciaLaQueMira(derecha)
		if ((game.getObjectsIn(position.right(1)).isEmpty() or self.hayUnaCapsulaAdelante()) and self.puedeMoverse()){
			position = position.right(1)
		}
	}
	
	method caminarIzquierda() {
		//el personaje avanza a la izquierda solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		self.cambiarDireccionHaciaLaQueMira(izquierda)
		if ((game.getObjectsIn(position.left(1)).isEmpty() or self.hayUnaCapsulaAdelante()) and self.puedeMoverse()){
			position = position.left(1)
		}
	}
	 
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } //esta funcion tiene inplementado el tiempo, ya que se usara para la habilidad "Bengala Solar" la cual aturde a los enemigos "x" segundos
    
    method morir()
    
   	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		if (self.puedeMoverse()){
            self.atacarHaciaLaDireccionQueMira()
            animaciones.golpear(self)
            sonidoGolpe.iniciar()
        }
	}
    
    method usarBolaDeEnergia(){  //dispara una bola de energia que va en linea recta, si choca con el enemigo le hace daño, y si choca con un bostaculo desparece
		if( energia >= 15){
			const bola = new BolaDeEnergia(position = direccionHaciaLaQueMira.destino(self), usuario = self)
			animaciones.disparar(self)
			game.addVisual(bola)
			sonidoKame.iniciar()
			direccionHaciaLaQueMira.desplazamiento(bola)
			energia = 0.max(energia - 10)
		}
		else{ game.say(self,"No tengo suficiente energia")}
		
	}
			//usar(habilidad)
	method usarBengalaSolar(){  //el personaje lanza una onda de luz que deja aturdido al enemigo, sin poder realizar una accion por un determinado tiempo
		if ( energia >= 25){
			const bengalaSolar = new BengalaSolar(usuario = self)
			game.addVisual(bengalaSolar)
			sonidoBengalaSolar.iniciar()
			bengalaSolar.aturdir()
			energia = 0.max(energia - 25)
		}
		else{ game.say(self, "No tengo suficiente energia") }
	}
	
	method enemigo() = goku
}

object goku inherits EntidadesVivas(position = game.center(), vida = 100){
	
	var property furia = 0
	var property estaTransformado = false
	
	override method image() = if (not estaTransformado) "assets/jugador/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png" else "assets/jugador/ssj/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
	
	method puedeTransformarse() = furia == 100 and not estaTransformado
	
	method transformarse(){  // el jugador se transforma y aumenta su daño
		if (self.puedeTransformarse()){
			estaTransformado = true
			animaciones.transformacion()
			sonidoTransformacion.iniciar()
			danio *= 2
		}
		else{
			game.say(self, "no me puedo transformar")
		}
	}
	
	override method morir(){
		animaciones.morir(self)
		game.schedule(2000, {juego.dificultad().pantallaDerrota()})
	}
	
	override method enemigo() = freezer
	
}

object freezer inherits EntidadesVivas(position = game.at(4,4),vida = 100){
	
	
	override method image() = "assets/freezer/" + direccionHaciaLaQueMira.miraHacia() + accion + ".png"
	
	method movimiento(){ //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			 self.caminarDerecha()
			if (self.hayUnObstaculoALaDerecha()){
			 	self.esquivarObstaculo()
			 }
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			self.caminarIzquierda()
			if (self.hayUnObstaculoALaIzquierda()){
			 	self.esquivarObstaculo()
			 }
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.caminarArriba()
			if (self.hayUnObstaculoArriba()){
				self.esquivarObstaculo()	
			}
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.caminarAbajo()
			if (self.hayUnObstaculoAbajo()){
				self.esquivarObstaculo()	
			}
		}
	}
	
	method golpearBot(){ 
        if (direccionHaciaLaQueMira.destino(self) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(direccionHaciaLaQueMira.destino(self) ).first().recibirAtaque(danio)
			animaciones.golpear(self)
		}
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
			}
		else if(self.hayUnObstaculoALaIzquierda())
			{
				self.caminarArriba()
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
		
		game.onTick(valor, "ataqueEnemgio",{ self.golpearBot() })
	}
	
	override method morir(){ 
		animaciones.morir(self)
		game.schedule(2000, {juego.dificultad().pantallaVictoria()})
	}
	
	override method enemigo() = goku
	
}

