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
		self.cambiarDireccionHaciaLaQueMira(atras)
		if ((game.getObjectsIn(position.up(1)).isEmpty() or self.hayUnaCapsulaAdelante() ) and self.puedeMoverse()){
			position = position.up(1)
		}
	}
	
	method caminarAbajo() {
		self.cambiarDireccionHaciaLaQueMira(frente)
		if ((game.getObjectsIn(position.down(1)).isEmpty() or self.hayUnaCapsulaAdelante() )and self.puedeMoverse()){
			position = position.down(1)
		}
	}
	
	method caminarDerecha() {
		self.cambiarDireccionHaciaLaQueMira(derecha)
		if ((game.getObjectsIn(position.right(1)).isEmpty() or self.hayUnaCapsulaAdelante()) and self.puedeMoverse()){
			position = position.right(1)
		}
	}
	
	method caminarIzquierda() {
		self.cambiarDireccionHaciaLaQueMira(izquierda)
		if ((game.getObjectsIn(position.left(1)).isEmpty() or self.hayUnaCapsulaAdelante()) and self.puedeMoverse()){
			position = position.left(1)
		}
	}
	 
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } 
    method morir()
    
   	method golpear(){
		if (self.puedeMoverse()){
            self.atacarHaciaLaDireccionQueMira()
            animaciones.golpear(self)
            sonidoAReproducir.iniciar("assets/sonidos/golpe.wav")
        }
	}
	
    method usarBolaDeEnergia(){  
		if( energia >= 15){
			const bola = new BolaDeEnergia(position = direccionHaciaLaQueMira.destino(self), usuario = self)
			bola.usar()
		}
		else{ game.say(self,"No tengo suficiente energia")}
		
	}
	method usarBengalaSolar(){  
		if ( energia >= 25){
			const bengalaSolar = new BengalaSolar(usuario = self)
			bengalaSolar.usar()
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
	
	method transformarse(){  
		if (self.puedeTransformarse()){
			estaTransformado = true
			animaciones.transformacion()
			sonidoAReproducir.iniciar("assets/sonidos/transformacion.wav")
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
	
	method movimiento(){ 
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			self.caminarDerecha()
			game.schedule(250,{direccionHaciaLaQueMira.esquivarObstaculo()})

		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			self.caminarIzquierda()
			game.schedule(250,{direccionHaciaLaQueMira.esquivarObstaculo()})

		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.caminarArriba()
			game.schedule(250,{direccionHaciaLaQueMira.esquivarObstaculo()})	
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.caminarAbajo()
			game.schedule(250,{direccionHaciaLaQueMira.esquivarObstaculo()})	
		}
	}
	
	method golpearBot(){ 
        if (direccionHaciaLaQueMira.destino(self) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(direccionHaciaLaQueMira.destino(self) ).first().recibirAtaque(danio)
			animaciones.golpear(self)
		}
    }
    
    method hayUnObstaculoEnLaDireccionHaciaLaQueMira() = juego.obstaculos().any({obstaculo => direccionHaciaLaQueMira.destino(self) == obstaculo.position()})
    
	method velocidadDeMovimiento(valor){ 
		
		game.onTick(valor, "movimientoEnemgio",{ self.movimiento() })
	}
	
	method velocidadDeAtaque(valor){
		
		game.onTick(valor, "ataqueEnemgio",{ self.golpearBot() })
	}
	
	override method morir(){ 
		animaciones.morir(self)
		game.schedule(2000, {juego.dificultad().pantallaVictoria()})
	}
	
	override method enemigo() = goku
	
}

