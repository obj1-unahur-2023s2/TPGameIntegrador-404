import wollok.game.*
import ataques.*


class Obstaculos{
	
	
	
}

object goku {
	
	var property vida = 100
	
	var accion = "frente"
	
	var property position = game.center()
	
	method image() = "assets/" + accion + ".png"
	
	method golpear(){
		
		if (accion == "frente"){
			self.golpear("frente")
		}
		else if (accion == "atras"){
			self.golpear("atras")
		}
		else if (accion == "derecha"){
			self.golpear("derecha")
		}
		else if (accion == "izquierda"){
			self.golpear("izquierda")
		}

	}
	
	method recibirAtaque(cantidad){
		
		vida -= cantidad
	}
	
	method hacerDanio(cant){
		
		if (accion == "frente"){
			game.getObjectsIn(position.down(1)).first().recibirDanio(cant)
		}
		else if (accion == "atras"){
			game.getObjectsIn(position.up(1)).first().recibirDanio(cant)
		}
		else if (accion == "derecha"){
			game.getObjectsIn(position.right(1)).first().recibirDanio(cant)
		}
		else if (accion == "izquierda"){
			game.getObjectsIn(position.left(1)).first().recibirDanio(cant)
		}
		
	}
	
	method golpear(direccion){
		
		self.hacerDanio(20)
		accion = direccion + "Golpe1"
		game.schedule(75, {accion = direccion + "Golpe2"})
		game.schedule(150, {accion = direccion + "golpe3"})
		game.schedule(225, {accion = direccion + "golpe4"})
		game.schedule(300, {accion = direccion})
	}
	
	method avanzar() {
		position = position.up(1)
		accion = "atras"
	}
	
	method retroceder() {
		position = position.down(1)
		accion = "frente"
	}
	
	method derecha() {
		position = position.right(1)
		accion = "derecha"
	}
	
	method izquierda() {
		position = position.left(1)
		accion = "izquierda"
	}
	
}

class Enemigo{
	
	var vida = 100
	
	var property position = game.at(4,4)
	
	method image() = "assets/frente.png"
	
	method recibirDanio(cant){
		vida -= cant
		
		game.say(self, vida.toString())
	}
	
	method movimiento() =
		
		if (goku.position().x() > self.position().x() and self.jugadorCerca()){
			
			 position = position.right(1)
			 
		}
		else if (goku.position().x() < self.position().x() and self.jugadorCerca()){
			
			position = position.left(1)
			
		}
		else if (goku.position().y() > self.position().y() and self.jugadorCerca()){
			
			position = position.up(1)
			
		}
		else if (goku.position().y() < self.position().y() and self.jugadorCerca()){
			
			position = position.down(1)
		}
		
	method jugadorCerca() = goku.position().x()-self.position().x().abs() <= 4 and  goku.position().y()-self.position().y().abs() <= 4
	
	method movimientoEnemigo(){
		
		game.onTick(500, "movimientoEnemgio",{ => self.movimiento() })
	}
	
}
