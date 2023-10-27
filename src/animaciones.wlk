import wollok.game.*
import entidades.*
import direcciones.*

object animaciones{
	
	method golpear(entidad){ //animacion de golpe
		
		entidad.accion("Golpe")
		(1..3).forEach( { n => game.schedule( 100 * n, { entidad.accion("golpe" + n.toString()) } ) } )
		game.schedule(400, {entidad.accion("")})
		
	}
	
	method disparar(entidad){ //animacion de lanzar kame
		
		entidad.accion("Kame")
		game.schedule(100, {entidad.accion("Kame1")})
		game.schedule(200, {entidad.accion("Kame2")})
		game.schedule(400, {entidad.accion("")})
	}
	
	method transformacion(){  //animacion de transformacion
		goku.serAturdido(530)
		goku.direccionHaciaLaQueMira(frente)
		goku.accion("Transformacion")
		(1..4).forEach( { n => game.schedule( 125 * n, { goku.accion("Transformacion" + n.toString()) } ) } )
		game.schedule(530, {goku.accion("")})
	}
	
	method morir(entidad){
		entidad.direccionHaciaLaQueMira(frente)
		entidad.accion("Muere")
		game.schedule(200, {entidad.accion("Muere1")})  //cambiar
		game.schedule(400, {entidad.accion("Muere2")})
	}
}