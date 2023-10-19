import wollok.game.*
import entidades.goku

object animaciones{
	
	method golpear(entidad,direccion){
		//esto seria mas que nada la animacion del golpe, se puede cambiar el nombre
		entidad.accion(direccion + "Golpe1")
		game.schedule(100, {entidad.accion(direccion + "Golpe2")})
		game.schedule(200, {entidad.accion(direccion + "Golpe3")})
		game.schedule(300, {entidad.accion(direccion + "Golpe4")})
		game.schedule(400, {entidad.accion(direccion)})
		
	}
	
	method disparar(entidad,direccion){
		
		entidad.accion(direccion + "Kame1")
		game.schedule(100, {entidad.accion(direccion + "Kame2")})
		game.schedule(200, {entidad.accion(direccion + "Kame3")})
		game.schedule(400, {entidad.accion(direccion)})
	}
	
	method transformacion(){
		goku.serAturdido(530)
		goku.accion("Transformacion1")
		game.schedule(130, {goku.accion("Transformacion2")})
		game.schedule(230, {goku.accion("Transformacion3")})
		game.schedule(330, {goku.accion("Transformacion4")})
		game.schedule(430, {goku.accion("Transformacion5")})
		game.schedule(530, {goku.accion("Frente")})
	}
}