import wollok.game.*
import ataques.*
import juegoManager.*


class Entidades{
	
	// aca se pondria el codigo que inpide que todas las entidades se superpongan.
	// esta clase se usaria mas que nada para los obstaculos como arboles, casas, piedras, etc.
	
}

class EntidadesVivas inherits Entidades{
	
	var vida = 100
	var accion = "Frente"
	var estaAturdido = false
	method estaVivo() = vida > 0
	
	method recibirAtaque(cant){
		vida -= cant
		
		game.say(self, vida.toString())
	}
		
	method puedeMoverse(){
		return 
			not estaAturdido
			}
	
	method morir(){ 
		if (not self.estaVivo()){
			
			estaAturdido = true
			accion = "Muere1"
			game.schedule(200, {accion = "Muere2"})
			game.schedule(400, {accion = "Muere3"})
			game.schedule(2000, {juego.eliminarEnemigo()})
		}
	}
}

object goku inherits EntidadesVivas{
	
	var property position = game.center()
	method image() = "assets/" + accion + ".png"
	
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
	
	method disparar(){
		const bola = new BolaDeEnergia(position = position.right(1))
		game.addVisual(bola)
		bola.desplazarse()
	}
	
	
	
	method hacerDanio(cant){
		
		if (accion == "frente" and not game.getObjectsIn(position.down(1)).isEmpty()){
			game.getObjectsIn(position.down(1)).first().recibirAtaque(cant)
		}
		else if (accion == "atras" and not game.getObjectsIn(position.up(1)).isEmpty()){
			game.getObjectsIn(position.up(1)).first().recibirAtaque(cant)
		}
		else if (accion == "derecha" and not game.getObjectsIn(position.right(1)).isEmpty()){
			game.getObjectsIn(position.right(1)).first().recibirAtaque(cant)
		}
		else if (accion == "izquierda" and not game.getObjectsIn(position.left(1)).isEmpty()){
			game.getObjectsIn(position.left(1)).first().recibirAtaque(cant)
		}
		
	}
	
	method golpear(direccion){
		
		self.hacerDanio(20)
		self.matar()
		accion = direccion + "Golpe1"
		game.schedule(75, {accion = direccion + "Golpe2"})
		game.schedule(150, {accion = direccion + "Golpe3"})
		game.schedule(225, {accion = direccion + "Golpe4"})
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

class Enemigo inherits EntidadesVivas{
	
	var property position = game.at(4,4)
	method image() = "assets/enemigos/enemigo" + accion + ".png"
	
	method movimiento() =
		
		if (goku.position().x() > self.position().x() and self.puedeMoverse()){
			
			 position = position.right(1)
			 accion = "Derecha"
			 
		}
		else if (goku.position().x() < self.position().x() and self.puedeMoverse()){
			
			position = position.left(1)
			accion = "Izquierda"
			
		}
		else if (goku.position().y() > self.position().y() and self.puedeMoverse()){
			
			position = position.up(1)
			accion = "Atras"
			
		}
		else if (goku.position().y() < self.position().y() and self.puedeMoverse()){
			
			position = position.down(1)
			accion = "Frente"
		}
		
	override method puedeMoverse(){
        return 
            goku.position().x()-self.position().x().abs() <= 4 and
            goku.position().y()-self.position().y().abs() <= 4 and
            goku.position().x()-self.position().x() >= -4 and
            goku.position().y()-self.position().y() >= -4 and
            goku.position().x()-self.position().x().abs() != 1 and
            goku.position().y()-self.position().y().abs() != 1 and
            goku.position().x()-self.position().x().abs() != -1 and
            goku.position().y()-self.position().y().abs() != -1 and
            super()
        }
	
	method movimientoEnemigo(){
		
		game.onTick(500, "movimientoEnemgio",{ => self.movimiento() })
	}
	
}
