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
		
		game.say(self, vida.toString())
	}
		
	method puedeMoverse(){
		return 
			not estaAturdido
	}
	
	
	method avanzar() {
		
		if (game.getObjectsIn(position.up(1)).isEmpty()){
			position = position.up(1)
		}
		accion = "Atras"
	}
	
	method retroceder() {
		
		if (game.getObjectsIn(position.down(1)).isEmpty()){
			position = position.down(1)
		}
		accion = "Frente"
	}
	
	method derecha() {
		
		if (game.getObjectsIn(position.right(1)).isEmpty()){
			position = position.right(1)
		}
		accion = "Derecha"
	}
	
	method izquierda() {
		
		if (game.getObjectsIn(position.left(1)).isEmpty()){
			position = position.left(1)
		}
		accion = "Izquierda"
	}
	
	method golpear(direccion){
		
		accion = direccion + "Golpe1"
		game.schedule(100, {accion = direccion + "Golpe2"})
		game.schedule(200, {accion = direccion + "Golpe3"})
		game.schedule(300, {accion = direccion + "Golpe4"})
		game.schedule(400, {accion = direccion})
		
	}
	
	method matar(){

        if (accion == "frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
            game.getObjectsIn(position.down(1)).first().morir()
        }
        else if (accion == "atras" and not game.getObjectsIn(position.up(1)).isEmpty()){
            game.getObjectsIn(position.up(1)).first().morir()
        }
        else if (accion == "derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
            game.getObjectsIn(position.right(1)).first().morir()
        }
        else if (accion == "izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
            game.getObjectsIn(position.left(1)).first().morir()
        }

    }
}

object goku inherits EntidadesVivas(position = game.center()){
	
	method image() = "assets/" + accion + ".png"
	
	method golpear(){
		
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
	
	method hacerDanio(cant){
		
		if (accion == "Frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
			game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
		}
		else if (accion == "Atras" and not game.getObjectsIn(position.up(1)).isEmpty()){
			game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
		}
		else if (accion == "Derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
			game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
		}
		else if (accion == "Izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
			game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
		}
	}
	
	override method golpear(direccion){
		
		self.hacerDanio(20)
		self.matar()
		super(direccion)
	}
	
	method disparar(){
		const bola = new BolaDeEnergia(position = position.right(1))
		game.addVisual(bola)
		bola.desplazarse()
	}
	
	method morir(){ 
		//por ahora no hace nada, se hara cuando se haga la pantalla de game over
	}
	
	
}

class Enemigo inherits EntidadesVivas(position = game.at(4,4)){
	
	method image() = "assets/enemigos/enemigo" + accion + ".png"
	
	method movimiento() =
		
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
		
	method hacerDanio(cant, direccion){
		
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
	
	override method puedeMoverse(){
		return 
			goku.position().x()-self.position().x().abs() <= 4 and
			goku.position().y()-self.position().y().abs() <= 4 and
			goku.position().x()-self.position().x() >= -4 and
			goku.position().y()-self.position().y() >= -4 and
			super()
		}
	
	method movimientoEnemigo(){
		
		game.onTick(500, "movimientoEnemgio",{ => self.movimiento() })
	}
	
	method morir(){ 
		if (not self.estaVivo()){
			
			estaAturdido = true
			accion = "Muere1"
			game.schedule(200, {accion = "Muere2"})
			game.schedule(400, {accion = "Muere3"})
			game.schedule(2000, {juego.eliminarEnemigo()})  //cambiar para que tambien funcione con cualquier enemigo
		}
	}
	
}
