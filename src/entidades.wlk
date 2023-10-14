import wollok.game.*
import ataques.*
import juegoManager.*




class Obstaculos{
	
	const position
	
	method recibirAtaque() {}
	
}

class EntidadesVivas{
	
	var position
	var vida = 100
	var accion = "Frente"
	var estaAturdido = false
	method estaVivo() = vida > 0
	method position() = position
	
	method recibirAtaque(cant){
		vida -= cant
	}
		
	method puedeMoverse() = not estaAturdido and self.estaVivo()
	
	
	method avanzar() {
		//el personaje avanza solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.up(1)).isEmpty()){
			position = position.up(1)
		}
		accion = "Atras"
	}
	
	method retroceder() {
		//el personaje retrocede solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.down(1)).isEmpty()){
			position = position.down(1)
		}
		accion = "Frente"
	}
	
	method derecha() {
		//el personaje avanza a la derecha solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.right(1)).isEmpty()){
			position = position.right(1)
		}
		accion = "Derecha"
	}
	
	method izquierda() {
		//el personaje avanza a la izquierda solo si en la casilla de enfrente no hay nada, si no solo cambia el lugar al que mira
		if (game.getObjectsIn(position.left(1)).isEmpty()){
			position = position.left(1)
		}
		accion = "Izquierda"
	}
	
	method golpear(direccion){
		//esto seria mas que nada la animacion del golpe, se puede cambiar el nombre
		accion = direccion + "Golpe1"
		game.schedule(100, {accion = direccion + "Golpe2"})
		game.schedule(200, {accion = direccion + "Golpe3"})
		game.schedule(300, {accion = direccion + "Golpe4"})
		game.schedule(400, {accion = direccion})
		
	}
    
    method serAturdido(tiempo){
    	estaAturdido=true
    	game.schedule(tiempo,{estaAturdido=false})
    } //esta funcion tiene inplementado el tiempo, ya que se usara para la habilidad "Bengala Solar" la cual aturde a los enemigos "x" segundos
}

object goku inherits EntidadesVivas(position = game.center()){
	
	method image() = "assets/" + accion + ".png"
    method vida() = vida
    method accion() = accion
	method golpear(){ //realiza la animacion de golpe hacia la direccion que mira el personaje
		
		if (accion == "Frente"){
			self.golpear("Frente")
		}
		else if (accion == "Atras"){
			self.golpear("Atras")
		}
		else if (accion == "Derecha"){
			self.golpear("Derecha")
		}
		else if (accion == "Izquierda"){
			self.golpear("Izquierda")
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

    override method golpear(direccion){ //animacion de golpear inplementada junto con el daño

        self.hacerDanio(20)
        super(direccion)
    }
	
	method disparar(){
		if (accion == "Frente"){
			const bola = new BolaDeEnergia(position = position.down(1))
		}
		else if (accion == "Atras"){
			const bola = new BolaDeEnergia(position = position.up(1))
		}
		else if (accion == "Derecha"){
			const bola = new BolaDeEnergia(position = position.right(1))
		}
		else if (accion == "Izquierda"){
			const bola = new BolaDeEnergia(position = position.left(1))
		}
		
		game.addVisual(bola)
		bola.desplazarse()
	}
	
	method morir(){ 
		//por ahora no hace nada, se hara cuando se haga la pantalla de game over
	}
	
}

class Enemigo inherits EntidadesVivas{
	
	method image() = "assets/enemigos/enemigo" + accion + ".png"
	
	method movimiento() = //el enemigo se mueve hacia donde esta el jugador
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			 self.derecha()
			 self.hacerDanio(5,"Derecha")
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			self.izquierda()
			self.hacerDanio(5,"Izquierda")
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			self.avanzar()
			self.hacerDanio(5,"Atras")
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			self.retroceder()
			self.hacerDanio(5,"Frente")
		}
		
	method hacerDanio(cant, direccion){ //como funciona el ataque del enemigo es diferente al del jugador, si no cada vez que camina lanza una ataque
										// ver como lo podemos mejorar, investigar como podemos hacer que el enemigo de golpes cada mas tiempo
		
		if (accion == "Frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
			game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
			self.golpear(direccion)
		}
		else if (accion == "Atras" and not game.getObjectsIn(position.up(1)).isEmpty()){
			game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
			self.golpear(direccion)
		}
		else if (accion == "Derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
			game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
			self.golpear(direccion)
		}
		else if (accion == "Izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
			game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
			self.golpear(direccion)
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
	
	method movimientoEnemigo(){ //el enemigo da un paso cada medio segundo
		
		game.onTick(500, "movimientoEnemgio",{ => self.movimiento() })
	}
	
	method morir(){ 
		if (not self.estaVivo()){
			self.serAturdido(2001)
			accion = "Muere1"
			game.schedule(200, {accion = "Muere2"})
			game.schedule(400, {accion = "Muere3"})
			game.schedule(2000, {juego.eliminarEnemigo()})  //cambiar para que tambien funcione con cualquier enemigo
		}
	}
	
}
