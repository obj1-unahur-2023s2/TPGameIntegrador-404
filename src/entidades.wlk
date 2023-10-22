import wollok.game.*
import habilidades.*
import juegoManager.*
import animaciones.*
import obstaculos.*




class EntidadesVivas{
	
	var position
	var vida = 100
	var property accion = "Frente"
	var estaAturdido = false
	method estaVivo() = vida > 0
	method position() = position
	
	method recibirAtaque(cant){
		vida -= cant
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

object goku inherits EntidadesVivas(position = game.center()){
	
	var energia= 100
	var furia = 100
	var estaTransformado = false
	var danio = 20
	method danio() = danio
	method energia()= energia
	method usarBolaDeFuego(){
		energia= energia - 10
	}
	
	method image() = if (not estaTransformado) "assets/jugador/" + accion + ".png" else "assets/jugador/ssj/" + accion + ".png"
	
    method vida() = vida
    
	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		
		if (accion == "Frente"){
			self.golpe("Frente")
		}
		else if (accion == "Atras"){
			self.golpe("Atras")
		}
		else if (accion == "Derecha"){
			self.golpe("Derecha")
		}
		else if (accion == "Izquierda"){
			self.golpe("Izquierda")
		}

	}
	
	method transformarse(){
		if (furia == 100 and not estaTransformado){
			estaTransformado = true
			animaciones.transformacion()
			danio *= 2
		}
		else{
			game.say(self, "no me puedo transformar")
		}
	}
	
	method hacerDanio(cant){ //realiza daño hacia el enemigo que esta en la direccion que mira el personaje

        if (accion == "Frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
            game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
            game.getObjectsIn(position.down(1)).first().morir()

        }
        else if (accion == "Atras" and not game.getObjectsIn(position.up(1)).isEmpty()){
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

    method golpe(direccion){ //animacion de golpear inplementada junto con el daño

        self.hacerDanio(danio)
        animaciones.golpear(self,direccion)
    }
	
	method usarBolaDeEnergia(){
		if(self.energia() >=0){
			const bola = new BolaDeEnergia(position = position)
			game.addVisual(bola)
			bola.desplazarse()
			self.usarBolaDeFuego()
			}
		else{ game.say(self,"No me queda energia suficiente")}
		
	}
	
	method usarBengalaSolar(){
		
		bengalaSolar.stunear()
	}
	
	method morir(){ 
		//por ahora no hace nada, se hara cuando se haga la pantalla de game over
	}
	
}

class Enemigo inherits EntidadesVivas{
	
	method image() = "assets/enemigos/enemigo" + accion + ".png"
	
	method movimiento(){ //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			if (self.hayUnArbolALaDerecha()){
			 	self.esquivarArbol()
			 }
			 self.derecha()
			 self.hacerDanio(5,"Derecha")
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			 if (self.hayUnArbolALaIzquierda()){
			 	self.esquivarArbol()
			 }
			self.izquierda()
			self.hacerDanio(5,"Izquierda")
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.avanzar()
			self.esquivarArbol()
			self.hacerDanio(5,"Atras")
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.retroceder()
			self.esquivarArbol()
			self.hacerDanio(5,"Frente")
		}
		
	}
	method hacerDanio(cant, direccion){ //como funciona el ataque del enemigo es diferente al del jugador, si no cada vez que camina lanza una ataque
										// ver como lo podemos mejorar, investigar como podemos hacer que el enemigo de golpes cada mas tiempo
		
		if (accion == "Frente" and position.down(1) == goku.position()){
			game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Atras" and position.up(1) == goku.position()){
			game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Derecha" and position.right(1) == goku.position()){
			game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
			animaciones.golpear(self,direccion)
		}
		else if (accion == "Izquierda" and position.left(1) == goku.position()){
			game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
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
		
	method esquivarArbol(){
		if( self.hayUnArbolAbajo() and accion == "Frente" )
			{
				self.izquierda()
				game.schedule(100,{self.retroceder()})
				
			}
		else if( self.hayUnArbolArriba() and accion == "Atras" )
			{
				self.derecha()
				game.schedule(100,{self.avanzar()})
			}
		else if(self.hayUnArbolALaDerecha() and accion == "Derecha" )
			{
				self.retroceder()
				self.izquierda()
			}
		else if(self.hayUnArbolALaIzquierda() and accion == "Izquierda")
			{
				self.avanzar()
				self.derecha()
			}
	}
	
	method hayUnArbolALaDerecha() = juego.obstaculos().any({arbol => position.right(1) == arbol.position()})
	method hayUnArbolALaIzquierda() = juego.obstaculos().any({arbol => position.left(1) == arbol.position()})
	method hayUnArbolArriba() = juego.obstaculos().any({arbol => position.up(1) == arbol.position()})
	method hayUnArbolAbajo() = juego.obstaculos().any({arbol => position.down(1) == arbol.position()})
	

	
	method movimientoEnemigo(){ //el enemigo da un paso cada medio segundo
		
		game.onTick(500, "movimientoEnemgio",{ => self.movimiento() })
	}
	
	method morir(){ 
		if (not self.estaVivo()){
			self.serAturdido(2200)
			accion = "Muere1"
			game.schedule(200, {accion = "Muere2"})
			game.schedule(400, {accion = "Muere3"})
			game.schedule(2000, {juego.eliminarEnemigo()})  //cambiar para que tambien funcione con cualquier enemigo
		}
	}
	
}
