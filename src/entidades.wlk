import wollok.game.*
import habilidades.*
import juegoManager.*
import animaciones.*
import obstaculos.*


class EntidadesVivas{
	
	var position
	var vida = 100
	var furia = 0
	var property accion = "Frente"  //pasar a objeto
	var estaAturdido = false
	var danio
	method furia()= furia
	method danio() = danio
	method estaVivo() = vida > 0
	method position() = position
	method vida() = vida
	
	method image()
	
	method recibirAtaque(cant){
		vida -= cant
		furia+=10
	}
		
	method puedeMoverse() = not estaAturdido and self.estaVivo()
	
	
	method avanzar() {
		//el personaje avanza solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.up(1)).isEmpty() and not estaAturdido){
			position = position.up(1)
		}
		accion = "Atras"
	}
	
	method retroceder() {
		//el personaje retrocede solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.down(1)).isEmpty() and not estaAturdido){
			position = position.down(1)
		}
		accion = "Frente"
	}
	
	method derecha() {
		//el personaje avanza a la derecha solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.right(1)).isEmpty() and not estaAturdido){
			position = position.right(1)
		}
		accion = "Derecha"
	}
	
	method izquierda() {
		//el personaje avanza a la izquierda solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.left(1)).isEmpty() and not estaAturdido){
			position = position.left(1)
		}
		accion = "Izquierda"
	}
	 
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } //esta funcion tiene inplementado el tiempo, ya que se usara para la habilidad "Bengala Solar" la cual aturde a los enemigos "x" segundos
}

object goku inherits EntidadesVivas(position = game.center(), danio = 20){
	
	var energia= 100
	var estaTransformado = false
	method energia()= energia
	
	override method image() = if (not estaTransformado) "assets/jugador/" + accion + ".png" else "assets/jugador/ssj/" + accion + ".png"
    method agarrarVida(){
    	if(accion == "Frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
    		vida = vida + 10
    	game.removeVisual(recargaVida)
    	}
    	else if (accion == "Atras" and not game.getObjectsIn(position.up(1)).isEmpty()){  //cambiar
          vida = vida + 10
    	game.removeVisual(recargaVida)
        }
        else if (accion == "Derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
            vida = vida + 10
    	game.removeVisual(recargaVida)
        }
        else if (accion == "Izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
            vida = vida + 10
    	game.removeVisual(recargaVida)
        }
    	
    }
	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		
		if (accion == "Frente"){
			self.realizarAtaqueHacia("Frente")
		}
		else if (accion == "Atras"){
			self.realizarAtaqueHacia("Atras")
		}
		else if (accion == "Derecha"){
			self.realizarAtaqueHacia("Derecha")  //cambiar
		}
		else if (accion == "Izquierda"){
			self.realizarAtaqueHacia("Izquierda")
		}
	}
	
   method realizarAtaqueHacia(direccion){ 
        self.hacerDanio(danio)
        animaciones.golpear(self,direccion)
    }
	
	method hacerDanio(cant){ //realiza daño hacia el enemigo que esta en la direccion que mira el personaje

        if (accion == "Frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
            game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
            game.getObjectsIn(position.down(1)).first().morir()

        }
        else if (accion == "Atras" and not game.getObjectsIn(position.up(1)).isEmpty()){  //cambiar
            game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
            game.getObjectsIn(position.up(1)).first().morir()
        }
        else if (accion == "Derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
            game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
            game.getObjectsIn(position.right(1)).first().morir()
        }
        else if (accion == "Izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
            game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
            game.getObjectsIn(position.left(1)).first().morir()
        }
    }
	
	method usarBolaDeEnergia(){  //dispara una bola de energia que va en linea recta, si choca con el enemigo le hace daño, y si choca con un bostaculo desparece
		if( energia >=0){
			const bola = new BolaDeEnergia(position = position)
			game.addVisual(bola)
			bola.desplazarse()
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
	
	override method image() = "assets/enemigos/enemigo" + accion + ".png"
	
	method movimiento(){ //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			if (self.hayUnObstaculoALaDerecha()){
			 	self.esquivarObstaculo()
			 }
			 self.derecha()
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){  //cambiar
			 if (self.hayUnObstaculoALaIzquierda()){
			 	self.esquivarObstaculo()
			 }
			self.izquierda()
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.avanzar()
			self.esquivarObstaculo()
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.retroceder()
			self.esquivarObstaculo()
		}
		
	}
	method hacerDanio(cant, direccion){ //como funciona el ataque del enemigo es diferente al del jugador, si no cada vez que camina lanza una ataque
		
		if (accion == "Frente" and position.down(1) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
			game.getObjectsIn(position.down(1)).first().morir()
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Atras" and position.up(1) == goku.position() and self.puedeMoverse() ){  //cambiar
			game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
			game.getObjectsIn(position.up(1)).first().morir()
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Derecha" and position.right(1) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
			game.getObjectsIn(position.right(1)).first().morir()
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Izquierda" and position.left(1) == goku.position() and self.puedeMoverse() ){
			game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
			game.getObjectsIn(position.left(1)).first().morir()
			animaciones.golpear(self,direccion)
		}
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
		if( self.hayUnObstaculoAbajo() and accion == "Frente" )
			{
				self.izquierda()
				game.schedule(100,{self.retroceder()})
				
			}
		else if( self.hayUnObstaculoArriba() and accion == "Atras" )  //cambiar
			{
				self.derecha()
				game.schedule(100,{self.avanzar()})
			}
		else if(self.hayUnObstaculoALaDerecha() and accion == "Derecha" )
			{
				self.retroceder()
				self.izquierda()
			}
		else if(self.hayUnObstaculoALaIzquierda() and accion == "Izquierda")
			{
				self.avanzar()
				self.derecha()
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
		
		game.onTick(700, "movimientoEnemgio",{ self.hacerDanio(danio, accion) })
	}
	
	method morir(){ 
		if (not self.estaVivo()){
			self.serAturdido(2050)
			accion = "Muere1"
			game.schedule(200, {accion = "Muere2"})  //cambiar
			game.schedule(400, {accion = "Muere3"})
			game.schedule(2000, {game.removeVisual(self)})  //cambiar para que tambien funcione con cualquier enemigo
		}
	}

	
}

